import 'dart:io';
import 'dart:math';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/Services2/Repository/pdf_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/filled_form_tile.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/question_ui.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/select_type.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspection/pdf_generator_preview.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspection/view_certificate.dart';
import 'package:open_file/open_file.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../Model/inspector_model2.dart';
import '../../../../../data/constants.dart';
import '../../../admin/custom_widgets/dialogs/custom_dialog.dart';


class FilledCheckListPage extends StatefulWidget {

  final List<Question> filledForm;
  final List<Question> checkBoxForm;
  final QuestionOption? questionOption;

  final String? clientId;
  final String? companyId;

  final bool isToBeAuthorised;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  const FilledCheckListPage({
    Key? key,
    required this.checkBoxForm,
    required this.filledForm,
    required this.companyId,
    required this.clientId,
    required this.questionOption,
    required this.surveyInspector,
    required this.authorisedInspector,
    required this.isToBeAuthorised
  }) : super(key: key);

  @override
  _FilledCheckListPageState createState() => _FilledCheckListPageState();
}

class _FilledCheckListPageState extends State<FilledCheckListPage> {

  late List<Question> _questionsList;
  late List<Question> _checkBoxQuestionsList;

  final PdfRepository pdfRepository = PdfRepository();
  final InspectorRepository inspectorRepository = InspectorRepository();
  late File? _file;
  late bool isLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _questionsList = widget.filledForm;
    _checkBoxQuestionsList = widget.checkBoxForm;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:  AppBar(
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
      backgroundColor: AppTheme.colors.appDarkBlue,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 30,
                              bottom: 30,
                              left: SizeConfig.blockSizeHorizontal*5,
                              right: SizeConfig.blockSizeHorizontal*5
                          ),
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal*90,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0XFFECE9E6),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                const SizedBox(
                                  height: 40,
                                ),

                                ListView.builder(
                                    itemCount: _questionsList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context ,int index) {
                                      return FilledFormTile(
                                        question: _questionsList[index],
                                      );
                                    }),

                                const SizedBox(
                                  height: 20,
                                ),

                                (_checkBoxQuestionsList.isNotEmpty)?
                                buildCheckFormField() : Container(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    NeumorphicButton(
                                      style: NeumorphicStyle(
                                          color: AppTheme.colors.loginWhite,
                                          shape: NeumorphicShape.concave,
                                          depth: 15,
                                          surfaceIntensity: .5,
                                          boxShape: const NeumorphicBoxShape.circle()),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        height: 55,
                                        child: Icon(
                                          Icons.edit,
                                          color: AppTheme.colors.appDarkBlue,
                                          size: 50,
                                        ),
                                      ),
                                    ),

                                    NeumorphicButton(
                                      style: NeumorphicStyle(
                                          color: AppTheme.colors.loginWhite,
                                          shape: NeumorphicShape.concave,
                                          depth: 15,
                                          surfaceIntensity: .5,
                                          boxShape: const NeumorphicBoxShape.circle()),
                                      onPressed: () async {
                                        showDialog(
                                            context: context,
                                            //barrierDismissible: false,
                                            builder: (_) {
                                              return CustomDialog(
                                                title: 'Digital Signature',
                                                subtitle: 'Do you want to display your signature in certificate?',
                                                yesTitle: 'Yes',
                                                noTitle: 'No',
                                                yes: () {
                                                  Navigator.pop(context, true);
                                                  generateCertificate(true);
                                                },
                                                no: () {
                                                  Navigator.pop(context, false);
                                                  generateCertificate(false);
                                                },
                                              );
                                            });
                                      },
                                      child: SizedBox(
                                        height: 55,
                                        child: Icon(
                                          Icons.remove_red_eye_rounded,
                                          color: AppTheme.colors.appDarkBlue,
                                          size: 50,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 40,
                                ),

                              ],
                            ),
                          ),
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
                  color: Constants.primaryColor,
                  strokeWidth: 2,
                ),
              ): Container(),
            ],
          ),
        )
      ),
    );
  }

  Widget buildCheckFormField(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        const SizedBox(
          height: 20,
        ),

        ListView.builder(
            itemCount: _questionsList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context ,int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4 ),
                child: FilledFormTile(
                  question: _questionsList[index],
                ),
              );
            }),

        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  generateCertificate(bool signatureDisplay) async {
    try{

      String certificateName = "";

      Company? company = await inspectorRepository.getCompanyDetailsLocal();
      if(company != null && company.name != null){
        certificateName += company.name!.trim().toUpperCase();
        certificateName = certificateName.replaceAll(" ", "");
        certificateName += '-';
      }
      certificateName += DateTime.now().year.toString();
      certificateName += '-';

      var rng = Random();
      var code = rng.nextInt(900000) + 100000;
      certificateName += code.toString();

      setState(() {
        isLoading = true;
      });

      _file = await pdfRepository.createPDF(
          widget.filledForm,
          widget.checkBoxForm,
          widget.questionOption,
          widget.authorisedInspector,
          widget.surveyInspector,
          certificateName,
          'This is to certify that the above competent surveyor thoroughly examined & tested on the above-mentioned place as per Corporate Standard for Lifting Equipment and Operations.',
          null,
          signatureDisplay
      );
      setState(() {
        isLoading = false;
      });

      if(_file != null){
        print('---------- Filled checklist -------------');
        print(_file!.path);
        //OpenFile.open(_file!.path);

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewCertificate(
          certificate: _file,
          certificateNo:  certificateName,
          filledForm: widget.filledForm,
          clientId: widget.clientId,
          companyId: widget.companyId,
          checkBoxForm: widget.checkBoxForm,
          questionOption: widget.questionOption,
          isToBeAuthorised: widget.isToBeAuthorised,
          authorisedInspector: widget.authorisedInspector,
          surveyInspector: widget.surveyInspector,
        )));
      }
      else{
        Fluttertoast.showToast(msg: 'Error generating pdf !');
      }


    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = true;
      });
      Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
    }
  }
}


