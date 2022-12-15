import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_company_certificate_list_page.dart';
import 'package:leo_inspector/src/pages/inspector/home/pending_approval/pending_certificate_list.dart';

import '../../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../../data/constants.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../admin/custom_widgets/dialogs/info_dialog.dart';
import '../../../home_page.dart';
import '../../../../../Model/inspector_model2.dart';

class SelectClient extends StatefulWidget {

  final String? inspectorId;
  final Inspector? authorisedInspector;
  final String? companyId;

  const SelectClient({Key? key,required this.inspectorId,required this.authorisedInspector,required this.companyId}) : super(key: key);

  @override
  State<SelectClient> createState() => _SelectClientState();
}

class _SelectClientState extends State<SelectClient> {

  late bool isLoading;
  late List<Client> _clientList;
  final InspectorRepository inspectorRepository = InspectorRepository();

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
      Response? response = await inspectorRepository.getClientList(widget.inspectorId,widget.companyId);
      _clientList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        ClientModel clientModel = clientModelFromJson(s1);
        _clientList = clientModel.client!;
      }
      else if(response.statusCode == 303 || response.statusCode == 401 ){

        inspectorRepository.clear();
        inspectorRepository.setInspectorLoggedIn(false);
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

  Widget clientLists(){
    return Container(
      height: MediaQuery.of(context).size.height*0.70,
      width:  MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppTheme.colors.loginWhite,
        borderRadius: BorderRadius.circular(20),),
      child: ListView.builder(
          itemCount: _clientList.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context ,int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4,vertical: SizeConfig.blockSizeHorizontal*1 ),
              child: InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PendingCertificatePage(
                            inspectorId: widget.inspectorId,
                            authorisedInspector: widget.authorisedInspector,
                            clientId: _clientList[index].clientId,
                          )));
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
                              width: SizeConfig.blockSizeHorizontal*30,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                "COMPANY NAME : ",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),

                          Container(
                              width: SizeConfig.blockSizeHorizontal*40,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                (_clientList[index].name != null) ? _clientList[index].name! : '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
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
                              width: SizeConfig.blockSizeHorizontal*30,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                "COMPANY Id         : ",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.colors.black),
                              )
                          ),

                          Container(
                              width: SizeConfig.blockSizeHorizontal*41,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                (_clientList[index].clientId != null) ? _clientList[index].clientId! : '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
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
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminBottomNavigationBarPage()));*/
                    },
                    icon: Icon(
                      Icons.double_arrow,
                      size: 30,
                      color: AppTheme.colors.logoColor,
                    ),
                  ),
                ))
          ],
        ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.76,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppTheme.colors.loginWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Center(child: Text("COMPANY LIST",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),)),
                              ),
                              const SizedBox(height: 10,),
                              clientLists()
                            ],
                          ),
                        ),
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