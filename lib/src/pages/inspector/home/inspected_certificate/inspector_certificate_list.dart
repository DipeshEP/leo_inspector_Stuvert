import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/certificate_model.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/pdf_viewer.dart';

import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../admin/custom_widgets/dialogs/info_dialog.dart';
import '../../../home_page.dart';

class InspectorCertificatePage extends StatefulWidget {

  final String? inspectorId;
  const InspectorCertificatePage({Key? key,required this.inspectorId}) : super(key: key);

  @override
  State<InspectorCertificatePage> createState() => _InspectorCertificatePageState();
}

class _InspectorCertificatePageState extends State<InspectorCertificatePage> {

  late bool isLoading;
  late List<Certificate> _certificateList;
  final InspectorRepository inspectorRepository = InspectorRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _certificateList = [];
    getCertificateList();
  }

  getCertificateList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await inspectorRepository.getCertificateList(widget.inspectorId!,null,null,null);
      _certificateList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        CertificateModel certificateModel = certificateModelFromJson(s1);
        _certificateList = certificateModel.certificate!;
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
    getCertificateList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget certificateListTile() {
    return Container(
        height: MediaQuery.of(context).size.height*0.70,
        width: 350,
        decoration: BoxDecoration(
          color: AppTheme.colors.loginWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListView.builder(
            itemCount: _certificateList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4,vertical: 5 ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PDFViewer1(url: _certificateList[index].certificatePdf!,pdfName: _certificateList[index].certificateId!,certificate: _certificateList[index],)));
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
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Certificate No   : ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].certificateId != null) ? _certificateList[index].certificateId! : '',
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
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Description       :  ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].certificateVersion != null) ? _certificateList[index].certificateVersion! : '',
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
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Date of Issue    :  ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].createdAt != null) ? DateFormat('dd/MM/yyyy').format( _certificateList[index].createdAt!) : '',
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
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    /*Navigator.
                    push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManageCertificateHomePage()));*/
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.81,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppTheme.colors.loginWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Text(
                                        "Certificates",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                certificateListTile(),
                              ],
                            ),
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

/*
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.81,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.colors.loginWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "COMPANY NAME",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                    searchBar(),
                    const SizedBox(
                      height: 10,
                    ),
                    certificateListTile(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
*/
    );
  }
}
