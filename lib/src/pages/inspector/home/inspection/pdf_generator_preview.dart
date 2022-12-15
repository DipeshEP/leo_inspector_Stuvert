/*
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/certificate_model.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/size_config.dart';

import '../../../../../Model/inspector_model.dart';
import '../../../../appcolors/colors.dart';
import '../../custom widgets/question_ui.dart';
import '../../../../../Model/inspector_model2.dart';

import '../authorised_inspector_list/approve_certificate_page.dart';
import '../authorised_inspector_list/auth_inspector_list.dart';

class PdfGeneratedPreview extends StatefulWidget {

  final List<Question> filledForm;
  final List<Question> checkBoxForm;
  final QuestionOption? questionOption;

  final String? clientId;
  final String? companyId;

  final bool isToBeAuthorised;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  const PdfGeneratedPreview({
    Key? key,
    required this.filledForm,
    required this.checkBoxForm,
    required this.questionOption,
    required this.clientId,
    required this.companyId,
    required this.surveyInspector,
    required this.authorisedInspector,
    required this.isToBeAuthorised,
  }) : super(key: key);

  @override
  _PdfGeneratedPreviewState createState() => _PdfGeneratedPreviewState();
}

class _PdfGeneratedPreviewState extends State<PdfGeneratedPreview> {

  Question? _inspectionDate, _nameAddress, _inspectionLocation;
  String? _certificateNo;
  late List<Question> _filledForm;
  late bool isLoading;
  //final _pdf = Document();
  File? _file;

  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

*/
/*  final pdfController = PdfController(
    document: PdfDocument.openAsset('assets/pdf/sample.pdf'),
  );*//*


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _certificateNo = '';
    _filledForm = widget.filledForm;
    isLoading = false;
    selectDetails();

   // getTestPdf();
  }

  getTestPdf() async {
    try{

      Future.delayed(const Duration(seconds: 2),() async {
        */
/*FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          _file = File(result.files.single.path!);
          setState(() {

          });
        } else {
          // User canceled the picker
        }*//*

      });

    }
    catch(e){
      print(e.toString());
    }
  }

  selectDetails(){
    for(int i = 0; i < _filledForm.length; i++){
      if(_filledForm[i].question != null){
        if(_filledForm[i].question!.trim() == 'Date of Inspection'){
          _inspectionDate = _filledForm[i];
          _filledForm.removeAt(i);
        }
        if(_filledForm[i].question == 'Name and Address of the Owner'){
          _nameAddress = _filledForm[i];
          _filledForm.removeAt(i);
        }
        if(_filledForm[i].question == 'Place of Inspection'){
          _inspectionLocation = _filledForm[i];
          _filledForm.removeAt(i);
        }
      }
    }

    makePdf();
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
      backgroundColor: const Color(0XFFECE9E6),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  */
/*(_file != null) ?
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal*90,
                    height: SizeConfig.blockSizeVertical*80,
                    child: PDFView(
                      filePath: _file!.path,
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: false,
                      pageFling: false,
                      onRender: (_pages) {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      onError: (error) {
                        print(error.toString());
                      },
                      onPageError: (page, error) {
                        print('$page: ${error.toString()}');
                      },
                      onViewCreated: (PDFViewController pdfViewController) {
                        _pdfViewController.complete(pdfViewController);
                      },
                      onPageChanged: (int? page, int? total) {
                        print('page change: $page/$total');
                      },
                    ),
                  ) : Container(),*//*


                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*10),
                    child: page01(),
                  ),

                  (widget.checkBoxForm.isNotEmpty) ?
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*10),
                    child: page02(),
                  ): Container(),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*10),
                    child: NeumorphicButton(
                      style: NeumorphicStyle(
                          color: AppTheme.colors.loginWhite,
                          shape: NeumorphicShape.concave,
                          depth: 15,
                          surfaceIntensity: .5,
                          boxShape: const NeumorphicBoxShape.circle()),
                      onPressed: () {
                        //Navigator.pop(context);
                        if(_file != null){
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget page01(){
    return Container(
      width: SizeConfig.blockSizeHorizontal*90,
      color: Colors.white,
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal*2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const SizedBox(
            height: 20,
          ),

          generateHeading(),

          generateFirstRow(),

          generateNamePlace(),

          generateDetails(),

          generateRemark(),

          generateLastRow(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              generateAuthorisedInspector(),

              generateSurveyInspector()
            ],
          ),

          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }

  Widget page02(){
    return Container(
      width: SizeConfig.blockSizeHorizontal*90,
      color: Colors.white,
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal*2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const SizedBox(
            height: 20,
          ),

          generateHeading2(),

          generateFirstRow(),

          generateCheckList(),

          const SizedBox(
            height: 3,
          ),

          generateRemark2(),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              generateSurveyInspector()
            ],
          ),

          const SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }

  Widget generateHeading(){
    String? s = '';

    if(widget.questionOption!.equipmentType != null) {
      s = widget.questionOption!.equipmentType;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal*1,
          vertical: SizeConfig.blockSizeHorizontal*1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [

          const Text(
            'CERTIFICATE',
            style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold
            ),
          ),

          Text(
            'Of Thorough Examination of $s Equipment',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppTheme.colors.appDarkBlue,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget generateFirstRow(){

    String certNo = '',formattedDate = '';

    try{
      certNo = 'CLAB/KELA/134535EOOC';
      bool isDateValid = false;
      if(_inspectionDate != null && _inspectionDate!.answer != null){
        isDateValid = isDate(_inspectionDate!.answer);
      }
      DateTime? date = stringToDate(_inspectionDate!.answer);
      if(date != null){
        formattedDate = DateFormat('dd MMM yyyy').format(date);
      }
    }
    catch(e){
      print(e.toString());
    }


    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal*1,
          vertical: SizeConfig.blockSizeHorizontal*2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [

              const Text(
                'Certificate No.:',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(
                width: 2,
              ),

              Text(
                '$certNo',
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [

              const  Text(
                'Date of Inspection:',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(
                width: 2,
              ),

              Text(
                '  $formattedDate  ',
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget generateNamePlace(){
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 0.5),
          ),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: SizeConfig.blockSizeHorizontal*40,
                height: 40,
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Name and Address of the Owner:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    (_nameAddress != null && _nameAddress!.answer != null) ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        _nameAddress!.answer!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ) : Container(),

                  ],
                ),
              ),

              const SizedBox(
                height: 40,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.black,
                    thickness: 0.5,
                  ),

              ),

              Container(
                padding: EdgeInsets.all(5),
                width: SizeConfig.blockSizeHorizontal*44,
                height: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Place of Inspection:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    (_inspectionLocation != null && _inspectionLocation!.answer != null) ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        _inspectionLocation!.answer!,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }

  Widget generateDetails(){
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.filledForm.length,
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {

            bool isValidDate;
            DateTime? date;
            isValidDate = false;
            if(_filledForm[index].type == 'Date'){
              isValidDate = isDate(_filledForm[index].answer);
              date = stringToDate(_filledForm[index].answer);
            }

            return Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  //pw.color: Colors.black,
                    width: 0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: SizeConfig.blockSizeHorizontal*40,
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (_filledForm[index].question != null) ? _filledForm[index].question! : '',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      width: 1,
                      color: Colors.black,
                      thickness: 0.5,
                    ),
                  ),

                  (isValidDate) ?
                  Container(
                    width: SizeConfig.blockSizeHorizontal*44,
                    padding: const EdgeInsets.all(2),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (date != null) ? DateFormat('dd MMM yyyy').format(date) : '',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ) :
                  Container(
                    width: SizeConfig.blockSizeHorizontal*44,
                    padding: const EdgeInsets.all(2),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      (_filledForm[index].answer != null) ? _filledForm[index].answer! : '',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      */
/*  child: pw.GridView(
          itemCount: _filledForm.length,
          padding: const EdgeInsets.all(0),
          addAutomaticKeepAlives: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 4),
          itemBuilder: (BuildContext context, int index) {
            return pw.Container(
              width: SizeConfig.blockSizeHorizontal*40,
              height: 40,
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                    //color: Colors.black,
                    width: 0.5),
              ),
              padding: pw.EdgeInsets.all(5),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [

                  (_filledForm[index].question != null) ?
                  pw.Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: pw.Alignment.topLeft,
                    child: pw.Text(
                      _filledForm[index].question!,
                      style: pw.TextStyle(
                          //color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ) : pw.Container(),

                  pw.SizedBox(
                    height: 2,
                  ),

                  (_filledForm[index].answer != null) ?
                  pw.Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: pw.Alignment.center,
                    child: pw.Text(
                      _filledForm[index].answer!,
                      overflow: pw.TextOverflow.clip,
                      maxLines: 2,
                      style: pw.TextStyle(
                          //color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ) : pw.Container(),
                ],
              ),
            );
          },
        ),*//*

    );
  }

  Widget generateRemark(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            //color: Colors.black,
            width: 0.5),
      ),
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'Remarks: SHALL BE OPERATED BY TRAINED AND CERTIFIED OPERATOR WITH MANDATORY PPE.',
        style: TextStyle(
            color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold
        ),
      ),

    );
  }

  Widget generateLastRow(){
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal*0,
            vertical: SizeConfig.blockSizeHorizontal*2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [

                Text(
                  'Date Of Issue:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  width: 1,
                ),

                Text(
                  '03.01.2022',
                  style:  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [

                Text(
                  'Job Ref. No.:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  width: 1,
                ),

                Text(
                  '4600003434',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [

                Text(
                  'Time Sheet No.:',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(
                  width: 1,
                ),

                Text(
                  '6505',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

          ],
        )
    );
  }

  Widget generateAuthorisedInspector(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: SizeConfig.blockSizeHorizontal*40,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal*0,
              vertical: SizeConfig.blockSizeHorizontal*2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [

                  Text(
                    'Authorised Name:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(
                    width: 5,
                  ),

                  Text(
                    'Stuart S Paul',
                    style:  TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 8,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  const Text(
                    'Authorised Signature:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Container(
                    width: SizeConfig.blockSizeHorizontal*10,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                          width: 0.2)
                    ),
                  )
                ],
              ),

            ],
          )
      ),
    );
  }

  Widget generateSurveyInspector(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          width: SizeConfig.blockSizeHorizontal*40,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal*0,
              vertical: SizeConfig.blockSizeHorizontal*2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [

                  Text(
                    'Surveyor\'s Name:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(
                    width: 5,
                  ),

                  Text(
                    'Stuart S Paul',
                    style:  TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 8,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  const Text(
                    'Surveyor\'s Signature:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Container(
                    width: SizeConfig.blockSizeHorizontal*10,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 0.2)
                    ),
                  )
                ],
              ),

            ],
          )
      ),
    );
  }

  Widget generateHeading2(){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal*1,
          vertical: SizeConfig.blockSizeHorizontal*1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [

          Text(
            'Annex to Certificate Of Thorough Examination',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    );
  }

  Widget generateCheckList(){
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
            //color: Colors.black,
            width: 0.5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal*4,
                height: 25,
                padding: const EdgeInsets.all(2),
                alignment: Alignment.center,
                child: const Text(
                  'S/No',
                  style:  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),


              const SizedBox(
                height: 25,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.black,
                    thickness: 0.5,
                  ),
              ),

              Container(
                width: SizeConfig.blockSizeHorizontal*40,
                padding: const EdgeInsets.all(2),
                alignment: Alignment.centerLeft,
                height: 25,
                child: const Text(
                  'Description',
                  overflow: TextOverflow.clip,
                  maxLines: 3,
                  style:  TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),


              const SizedBox(
                height: 25,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.black,
                    thickness: 0.5,
                  ),
              ),

              Container(
                width: SizeConfig.blockSizeHorizontal*40,
                padding: const EdgeInsets.all(2),
                alignment: Alignment.centerLeft,
                height: 25,
                child: const Text(
                  'Conditions / Remarks',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
          ),

          ListView.builder(
            itemCount: widget.checkBoxForm.length,
            padding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 25,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 0.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal*4,
                      padding: const EdgeInsets.all(2),
                      height: 25,
                      alignment: Alignment.center,
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                        child: VerticalDivider(
                          width: 1,
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                    ),

                    Container(
                      width: SizeConfig.blockSizeHorizontal*40,
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (widget.checkBoxForm[index].question != null) ? widget.checkBoxForm[index].question! : '',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                        child: VerticalDivider(
                          width: 1,
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                    ),

                    Container(
                      width: SizeConfig.blockSizeHorizontal*40,
                      padding: const EdgeInsets.all(2),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        (widget.checkBoxForm[index].answer != null) ? widget.checkBoxForm[index].answer! : '',
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )
    );
  }

  Widget generateRemark2(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.black,
            width: 0.5),
      ),
      padding: const EdgeInsets.all(2),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'COMMENTS: ',
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold
        ),
      ),

    );
  }

  Future<void> makePdf() async {
    try{
    */
/*  setState(() {
        isLoading = true;
      });

      print('makePdf');

      _pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return page01(); // Center
          }));

      if(widget.checkBoxForm.isNotEmpty){
        _pdf.addPage(pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return page02(); // Center
            }));
      }

      DateTime now = DateTime.now();
      String s = now.toString();
      _file = File('inspector_example546456465saved.pdf');
      await _file!.writeAsBytes(await _pdf.save());

      print('_file!.path');
      print(_file!.path);
      setState(() {
        isLoading = false;
      });*//*


    }catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  uploadCertificate() async {
    try{

      //check if need to be authorised

      QuestionOption? questionOption = widget.questionOption!;
      questionOption.question!.clear();
      questionOption.question = widget.filledForm + widget.checkBoxForm;

      if(widget.isToBeAuthorised){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ApproveCertificatePage(
          clientId: widget.clientId,
          companyId: widget.companyId,
          questionOption: widget.questionOption,
          file: _file!,
          surveyor: widget.surveyInspector,
          authorizer: widget.authorisedInspector,
          certificateNo: 'Certificate-dummy-no',
        )));
      }
      else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SelectAuthInspector(
          clientId: widget.clientId,
          companyId: widget.companyId,
          questionOption: widget.questionOption,
          file: _file!,
          inspector: widget.surveyInspector,
          certificateNo: 'Certificate-dummy-no',
        )));
      }
    }
    catch(e){
      print(e.toString());
    }
  }

}*/
