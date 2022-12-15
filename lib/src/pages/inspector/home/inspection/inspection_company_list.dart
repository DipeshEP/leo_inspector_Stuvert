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

import '../../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../../data/constants.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../admin/custom_widgets/dialogs/info_dialog.dart';
import '../../../home_page.dart';
import 'equipment_type.dart';
import '../../../../../Model/inspector_model2.dart';

class InspectionCompanyList extends StatefulWidget {
  final String? companyId;

  const InspectionCompanyList({Key? key,required this.companyId}) : super(key: key);

  @override
  State<InspectionCompanyList> createState() => _InspectionCompanyListState();
}

class _InspectionCompanyListState extends State<InspectionCompanyList> {

  late bool isLoading;
  late List<Client> _clientList;
  late Inspector? _inspector;
  final InspectorRepository inspectorRepository = InspectorRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _clientList = [];
    //getClientList();
    getInspector();
  }

  getInspector() async{
    try{
      _inspector = await inspectorRepository.getInspectorDetailsLocal();
      getClientList();
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }

  getClientList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await inspectorRepository.getClientList(_inspector!.inspectorId!,widget.companyId);
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

                  Company? company = await inspectorRepository.getCompanyDetailsLocal();

                  Inspector? auth;
                  if(_inspector != null){
                    if(_inspector!.inspectorType == 'InspectorSignetory'){
                      auth = _inspector;
                    }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EquipmentType(
                            client: _clientList[index],
                            company: company,
                            surveyInspector: _inspector,
                            authorisedInspector: auth,
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
                                    fontSize: 11,
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
                              width: SizeConfig.blockSizeHorizontal*30,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                              child: Text(
                                "COMPANY Id         : ",
                                style: TextStyle(
                                    fontSize: 11,
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