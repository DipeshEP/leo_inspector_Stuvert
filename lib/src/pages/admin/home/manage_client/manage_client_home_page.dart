import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_client/client_detail_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_client/register_client_page.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';

class ManageClientHomePage extends StatefulWidget {
  final String? companyId;
  const ManageClientHomePage({Key? key,required this.companyId}) : super(key: key);

  @override
  State<ManageClientHomePage> createState() => _ManageClientHomePageState();
}


class _ManageClientHomePageState extends State<ManageClientHomePage> {

  late bool isLoading;
  late List<Client> _clientList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _clientList = [];
    getClientList();
  }

  getClientList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.getClientList("",widget.companyId);
      _clientList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        ClientModel clientModel = clientModelFromJson(s1);
        _clientList = clientModel.client!;
      }
      else if(response.statusCode == 303 || response.statusCode == 401 ){
        adminRepository.clear();
        adminRepository.setAdminLoggedIn(false);
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Authorisation Expired!',
                subtext: 'Please Login again',
                ok: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) =>
                      const HomePage()), (route) => false);
                },
              );
            });
      }
      isLoading = false;
      setState(() {});
      }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refresh() async {
    getClientList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget clientList(){
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: MediaQuery.of(context).size.width,
      child: (_clientList.isNotEmpty) ?
      ListView.builder(
          itemCount: _clientList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientDetailPage(
                            client: _clientList[index],onDelete: refresh,onBackPressed: refresh,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*4,horizontal: SizeConfig.blockSizeHorizontal*2),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.blockSizeHorizontal*29,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                "Company Name :",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),

                          Container(
                              width: SizeConfig.blockSizeHorizontal*45,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                (_clientList[index].name != null) ? _clientList[index].name! : ' ',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),
                        ],
                      ),

                      SizedBox(
                          height: SizeConfig.blockSizeHorizontal*1
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: SizeConfig.blockSizeHorizontal*29,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                "Company Id        :",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),

                          Container(
                              width: SizeConfig.blockSizeHorizontal*45,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                (_clientList[index].cmpId != null) ? _clientList[index].cmpId! : ' ',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }):
      (!isLoading) ?
      const Center(child: Text('List is empty!')) : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.colors.appDarkBlue,
        appBar: AppBar(
          backgroundColor: AppTheme.colors.appDarkBlue,
          leadingWidth: 400,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
            child: SizedBox(
                height: 60,
                width: 400,
                child: Image.asset(
                  "assets/icons/leo_logo.png",
                  fit: BoxFit.fill,
                )),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                    /*Navigator.
                    push(context,MaterialPageRoute(builder: (context)=> const AdminBottomNavigationBarPage()));*/
                  },
                    icon: Icon(Icons.double_arrow,
                      size: 30,
                      color: AppTheme.colors.logoColor,),),
                )

            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: NeumorphicButton(
            style: NeumorphicStyle(
                shadowLightColor: AppTheme.colors.blue,
                color: AppTheme.colors.appDarkBlue,
                shape: NeumorphicShape.concave,
                depth: 20,
                surfaceIntensity: .5,
                boxShape: const NeumorphicBoxShape.circle()),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterClientPage(onBackPressed: refresh,)));
            },
            child: SizedBox(
              height: 55,
              child: Icon(Icons.add,color: AppTheme.colors.loginWhite,size: 60,),
            )),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                onRefresh: refresh,
                child: Stack(
                  children: [
                    ListView(),

                    SingleChildScrollView(
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding:const  EdgeInsets.symmetric(vertical: 10.0,horizontal: 23.0),
                            child: Container(
                                height: MediaQuery.of(context).size.height*0.65,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppTheme.colors.loginWhite,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text("Client List",textAlign: TextAlign.center,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18
                                      )),
                                    ),
                                    clientList(),

                                  ],
                                )
                            ),
                          ),
                        ],
                      ),
                    ),

                    (isLoading)? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Constants.primaryColor,
                        strokeWidth: 2,
                      ),
                    ): Container(),

                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}
