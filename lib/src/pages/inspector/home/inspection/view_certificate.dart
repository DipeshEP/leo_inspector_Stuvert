import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model2.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../../appcolors/colors.dart';
import '../authorised_inspector_list/approve_certificate_page.dart';
import '../authorised_inspector_list/auth_inspector_list.dart';

class ViewCertificate extends StatefulWidget {
  final File? certificate;
  final String? certificateNo;
  final List<Question> filledForm;
  final List<Question> checkBoxForm;
  final QuestionOption? questionOption;

  final String? clientId;
  final String? companyId;

  final bool isToBeAuthorised;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  const ViewCertificate({
    required this.certificate,
    required this.certificateNo,
    required this.authorisedInspector,
    required this.surveyInspector,
    required this.checkBoxForm,
    required this.filledForm,
    required this.questionOption,
    required this.clientId,
    required this.companyId,
    required this.isToBeAuthorised,
    Key? key})
      : super(key: key);

  @override
  State<ViewCertificate> createState() => _ViewCertificateState();
}

class _ViewCertificateState extends State<ViewCertificate> {

  late bool _isLoading;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
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
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> const CompanyCertificatePage()));
                },
                  icon: Icon(Icons.double_arrow,
                    size: 30,
                    color: AppTheme.colors.logoColor,),),
              )

          )
        ],
      ),
      body: SafeArea(
          child: Stack(
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.blue,
                child: PDFView(
                  filePath: widget.certificate!.path,
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  fitPolicy: FitPolicy.WIDTH,
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                  },
                ),
              ),

              Positioned(
                top: 20,
                right: 20,
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                      border: NeumorphicBorder(
                          color: AppTheme.colors.appDarkBlue,
                          width: 3
                      ),
                      shadowLightColor: AppTheme.colors.white.withOpacity(.1),
                      color: AppTheme.colors.loginWhite,
                      shape: NeumorphicShape.convex,
                      depth: 15,
                      surfaceIntensity: .5,
                      boxShape: const NeumorphicBoxShape.circle(
                      )
                  ),
                  onPressed: (){
                    showDialog(context: context, builder:(_)=> AlertDialog(
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      backgroundColor: AppTheme.colors.appDarkBlue,

                      title: Column(
                        children: [
                          Text(
                            "Cert.No : ${widget.certificateNo!}",
                            style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 14),),
                          /*Text(
                              "Date of Issued : ${DateFormat().format(widget.certificate!.createdAt!)}",
                              style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 17)),
                          Text(
                              "Description : ${widget.certificate!.certificateVersion!}",
                              style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 17,)),*/
                        ],
                      ),
                      elevation: 2,

                    ));
                  },
                  child:Center(
                    child: SizedBox(

                      height: 55,
                      child:Image.asset("assets/images/Authentic_Badge.png"),
                    ),
                  ),
                ),
              ),

              Positioned(
                bottom: 20,
                left: SizeConfig.blockSizeHorizontal*38,
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                      color: AppTheme.colors.loginWhite,
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      surfaceIntensity: .5,
                      boxShape: const NeumorphicBoxShape.circle()),
                  onPressed: () {
                    //Navigator.pop(context);
                    if(widget.certificate != null){
                      uploadCertificate();
                    }
                  },
                  child: SizedBox(
                    height: 55,
                    child: Icon(
                      Icons.send,
                      color: AppTheme.colors.appDarkBlue,
                      size: 50,
                    ),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  uploadCertificate() async {
    try{

      //check if need to be authorised

      QuestionOption? questionOption = widget.questionOption!;
      questionOption.question!.clear();
      questionOption.question = widget.filledForm + widget.checkBoxForm;

      print('---------- ViewCertificate -------------');
      print(widget.certificate!.path);

      if(widget.isToBeAuthorised){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ApproveCertificatePage(
          clientId: widget.clientId,
          companyId: widget.companyId,
          questionOption: widget.questionOption,
          file: widget.certificate!,
          surveyor: widget.surveyInspector,
          authorizer: widget.authorisedInspector,
          certificateNo: widget.certificateNo,
        )));
      }
      else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SelectAuthInspector(
          clientId: widget.clientId,
          companyId: widget.companyId,
          questionOption: widget.questionOption,
          file: widget.certificate!,
          inspector: widget.surveyInspector,
          certificateNo: widget.certificateNo,
          checkBoxForm: widget.checkBoxForm,
          filledForm: widget.filledForm,
        )));
      }
    }
    catch(e){
      print(e.toString());
    }
  }

}
