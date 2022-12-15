
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/home/authorised_inspector_list/success_screen.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspected_certificate/inspector_certificate_list.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspection/inspection_company_list.dart';
import '../../../../../Model/inspector_model2.dart';

import '../../../../../Model/client_model.dart';
import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../admin/custom_widgets/dialogs/info_dialog.dart';
import '../../../home_page.dart';


class ApproveCertificatePage extends StatefulWidget {

  final File file;
  //make sure to append both question list before sending here
  final QuestionOption? questionOption;
  final String? clientId;
  final String? companyId;
  final Inspector? surveyor;
  final Inspector? authorizer;
  final String? certificateNo;

  const ApproveCertificatePage({Key? key,required this.certificateNo,
    required this.questionOption,required this.clientId,required this.companyId,
    required this.surveyor,required this.authorizer,required this.file}) : super(key: key);

  @override
  State<ApproveCertificatePage> createState() =>
      _ApproveCertificatePageState();
}

class _ApproveCertificatePageState extends State<ApproveCertificatePage> {

  final InspectorRepository inspectorRepository = InspectorRepository();
  late bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(

      body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 63,
                      ),
                      InkWell(
                        onTap: () {
                          uploadCertificate(true);
                        },
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              color: AppTheme.colors.loginWhite,
                              surfaceIntensity: .5,
                              depth: 20,
                              intensity: 5,
                              shadowLightColor: AppTheme.colors.white,
                              border: const NeumorphicBorder(
                                //  color: Color(0XFF07649F)
                              ),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20))),
                          child: SizedBox(
                            height: 199,
                            width: 272,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                                  child: Icon(
                                   Icons.check_circle_outline,
                                    color: Colors.grey[700],
                                    size: SizeConfig.blockSizeHorizontal*30,
                                  )
                                ),
                                Text(
                                  "APPROVE",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: AppTheme.colors.appDarkBlue),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 63,
                      ),
                      InkWell(
                        onTap: () {
                          uploadCertificate(false);
                        },
                        child: Neumorphic(
                          style: NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              color: AppTheme.colors.loginWhite,
                              surfaceIntensity: .5,
                              depth: 20,
                              intensity: 5,
                              shadowLightColor: AppTheme.colors.white,
                              border: const NeumorphicBorder(
                                //  color: Color(0XFF07649F)
                              ),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(20))),
                          child: SizedBox(
                            height: 199,
                            width: 272,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 2, bottom: 10),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.grey[700],
                                      size: SizeConfig.blockSizeHorizontal*30,
                                    )
                                ),
                                Text(
                                  "REJECT",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: AppTheme.colors.appDarkBlue),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 63,
                      ),
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
                color: Colors.white,
                strokeWidth: 2,
              ),
            ): Container(),
          ]
      ),
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
              child:RotatedBox(
                quarterTurns: 2,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                },
                  icon: Icon(Icons.double_arrow,
                    size: 30,
                    color: AppTheme.colors.logoColor,),),
              ))
        ],
      ),
      backgroundColor: AppTheme.colors.loginWhite,
    );
  }

  uploadCertificate(bool isApproved) async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      String inspectionStatus = "", details = "", certificateRowData = "";
      bool isSuccess;

      if(isApproved){
        inspectionStatus = "Approved";
        isSuccess = true;
      }
      else{
        inspectionStatus = "Rejected";
        isSuccess = false;
      }

      Map<String,dynamic> certificateDetails = {
        "questionOption" : widget.questionOption!.toJson(),
        "certificateNo" : widget.certificateNo,
        "surveyor" : widget.surveyor!.toJson(),
        "authorised" : widget.authorizer!.toJson()
      };

      certificateRowData = json.encode(certificateDetails);

      Response? response = await inspectorRepository.uploadCertificate(
          'v2',certificateRowData,widget.file,widget.surveyor!.inspectorId,
          widget.companyId!,widget.clientId!,details,
          widget.authorizer!.inspectorId,inspectionStatus
      );

      if(response!.statusCode == 200 || response.statusCode == 201 ){

        String msg = "";

        if(isApproved){
          msg = "APPROVED BY AUTHORISED SIGNATORY";
        }
        else{
          msg = "REJECTED BY AUTHORISED SIGNATORY";
        }
        Fluttertoast.showToast(msg: msg);

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SuccessScreen(
          message: msg, isSuccess: isSuccess,
        )));
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
      else if(response.statusCode == 400 || response.statusCode == 404){
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Error!',
                subtext: (response.data['message'] != null) ? response.data['message'].toString().toUpperCase() : '',
                ok: () {
                  Navigator.pop(context, true);
                  return true;
                },
              );
            });
      }
      else{
        //print(response.data);
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Error!',
                subtext: 'Please try again',
                ok: () {
                  Navigator.pop(context, true);
                  return true;
                },
              );
            });
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      showDialog(
          context: context,
          //barrierDismissible: false,
          builder: (_) {
            return InfoDialog(
              message: 'Error !',
              subtext: e.toString(),
              ok: () {
                Navigator.pop(context, true);
                return true;
              },
            );
          });
      setState(() {
        isLoading = false;
      });
    }
  }

}
