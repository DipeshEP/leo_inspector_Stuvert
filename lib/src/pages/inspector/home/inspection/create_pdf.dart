/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../../../../../Model/inspector_model2.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../custom widgets/question_ui.dart';


class CertificatePdf{

  final List<Question> filledForm;
  final List<Question> checkBoxForm;
  final QuestionOption? questionOption;

  final String? clientId;
  final String? companyId;

  final bool isToBeAuthorised;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  CertificatePdf({
    required this.filledForm,
    required this.checkBoxForm,
    required this.questionOption,
    required this.clientId,
    required this.companyId,
    required this.surveyInspector,
    required this.authorisedInspector,
    required this.isToBeAuthorised,
  });


  Question? _inspectionDate, _nameAddress, _inspectionLocation;
  String? _certificateNo;
  late List<Question> _filledForm;
  late bool isLoading;
  final _pdf = Document();
  File? _file;

  pw.Widget page01(){
    return pw.Container(
      width: SizeConfig.blockSizeHorizontal*90,
      //color: pw.Colors.white,
      padding: pw.EdgeInsets.all(SizeConfig.blockSizeHorizontal*2),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          pw.SizedBox(
            height: 20,
          ),

          generateHeading(),

          generateFirstRow(),

          generateNamePlace(),

          generateDetails(),

          generateRemark(),

          generateLastRow(),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              generateAuthorisedInspector(),

              generateSurveyInspector()
            ],
          ),

          pw.SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }

  pw.Widget page02(){
    return pw.Container(
      width: SizeConfig.blockSizeHorizontal*90,
      //color: Colors.white,
      padding: pw.EdgeInsets.all(SizeConfig.blockSizeHorizontal*2),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          pw.SizedBox(
            height: 20,
          ),

          generateHeading2(),

          generateFirstRow(),

          generateCheckList(),

          pw.SizedBox(
            height: 3,
          ),

          generateRemark2(),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              generateSurveyInspector()
            ],
          ),

          pw.SizedBox(
            height: 20,
          ),

        ],
      ),
    );
  }

  pw.Widget generateHeading(){
    String? s = '';

    if(questionOption!.equipmentType != null) {
      s = questionOption!.equipmentType;
    }

    return pw.Container(
      width: SizeConfig.screenWidth,
      padding: pw.EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal*1,
          vertical: SizeConfig.blockSizeHorizontal*1),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children:  [

          pw.Text(
            'CERTIFICATE',
            style: pw.TextStyle(
              //color: pw.Colors.black,
                fontSize: 13,
                fontWeight: pw.FontWeight.bold
            ),
          ),

          pw.Text(
            'Of Thorough Examination of $s Equipment',
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              //color: AppTheme.colors.appDarkBlue,
                fontSize: 12,
                fontWeight: pw.FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget generateFirstRow(){

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


    return pw.Container(
        width: SizeConfig.screenWidth,
        padding: pw.EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal*1,
            vertical: SizeConfig.blockSizeHorizontal*2),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children:  [

                pw.Text(
                  'Certificate No.:',
                  style: pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                pw.SizedBox(
                  width: 2,
                ),

                pw.Text(
                  '$certNo',
                  style: pw.TextStyle(
                      decoration: TextDecoration.underline,
                      //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children:  [

                pw.Text(
                  'Date of Inspection:',
                  style: pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                pw.SizedBox(
                  width: 2,
                ),

                pw.Text(
                  '  $formattedDate  ',
                  style: pw.TextStyle(
                      decoration: TextDecoration.underline,
                      //color: Colors.black,
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

  pw.Widget generateNamePlace(){
    return pw.SizedBox(
        width: SizeConfig.screenWidth,
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              //color: Colors.black,
                width: 0.5),
          ),
          height: 40,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

              pw.Container(
                width: SizeConfig.blockSizeHorizontal*42,
                height: 40,
                padding: pw.EdgeInsets.all(5),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Name and Address of the Owner:',
                      style: pw.TextStyle(
                        //color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    pw.SizedBox(
                      height: 2,
                    ),

                    (_nameAddress != null && _nameAddress!.answer != null) ?
                    pw.Container(
                      width: SizeConfig.screenWidth,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _nameAddress!.answer!,
                        style: pw.TextStyle(
                          //color: Colors.black,
                            fontSize: 8,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ) : pw.Container(),

                  ],
                ),
              ),

              pw.Container(
                height: 40,
                child: pw.VerticalDivider(
                  width: 1,
                  //color: Colors.black,
                  thickness: 0.5,
                ),

              ),

              pw.Container(
                padding: pw.EdgeInsets.all(5),
                width: SizeConfig.blockSizeHorizontal*42,
                height: 40,
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Place of Inspection:',
                      style: pw.TextStyle(
                        //color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    pw.SizedBox(
                      height: 2,
                    ),

                    (_inspectionLocation != null && _inspectionLocation!.answer != null) ?
                    pw.Container(
                      width: SizeConfig.screenWidth,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        _inspectionLocation!.answer!,
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
              )

            ],
          ),
        )
    );
  }

  pw.Widget generateDetails(){
    return pw.SizedBox(
      width: SizeConfig.screenWidth,
      child: pw.ListView.builder(
        itemCount: checkBoxForm.length,
        padding: pw.EdgeInsets.all(0),
        itemBuilder: (pw.Context context, int index) {
          return pw.Container(
            height: 40,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                //pw.color: Colors.black,
                  width: 0.5),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: SizeConfig.blockSizeHorizontal*40,
                  height: 40,
                  padding: pw.EdgeInsets.all(2),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    (_filledForm[index].question != null) ? _filledForm[index].question! : '',
                    overflow: pw.TextOverflow.clip,
                    maxLines: 1,
                    style: pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 40,
                  child: pw.VerticalDivider(
                    width: 1,
                    //color: Colors.black,
                    thickness: 0.5,
                  ),
                ),

                pw.Container(
                  width: SizeConfig.blockSizeHorizontal*44,
                  padding: pw.EdgeInsets.all(2),
                  height: 40,
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    (_filledForm[index].answer != null) ? _filledForm[index].answer! : '',
                    overflow: pw.TextOverflow.clip,
                    maxLines: 1,
                    style: pw.TextStyle(
                      //color: Colors.black,
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

  pw.Widget generateRemark(){
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          //color: Colors.black,
            width: 0.5),
      ),
      padding: pw.EdgeInsets.all(5),
      width: SizeConfig.screenWidth,
      child: pw.Text(
        'Remarks: SHALL BE OPERATED BY TRAINED AND CERTIFIED OPERATOR WITH MANDATORY PPE.',
        style: pw.TextStyle(
          //color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold
        ),
      ),

    );
  }

  pw.Widget generateLastRow(){
    return pw.Container(
        width: SizeConfig.screenWidth,
        padding: pw.EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal*0,
            vertical: SizeConfig.blockSizeHorizontal*2),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [

                pw.Text(
                  'Date Of Issue:',
                  style: pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                pw.SizedBox(
                  width: 1,
                ),

                pw.Text(
                  '03.01.2022',
                  style:  pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children:  [

                pw.Text(
                  'Job Ref. No.:',
                  style: pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                pw.SizedBox(
                  width: 1,
                ),

                pw.Text(
                  '4600003434',
                  style:  pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children:  [

                pw.Text(
                  'Time Sheet No.:',
                  style: pw.TextStyle(
                    //color: Colors.black,
                      fontSize: 8,
                      fontWeight: FontWeight.bold
                  ),
                ),

                pw.SizedBox(
                  width: 1,
                ),

                pw.Text(
                  '6505',
                  style:  pw.TextStyle(
                    //color: Colors.black,
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

  pw.Widget generateAuthorisedInspector(){
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Container(
          width: SizeConfig.blockSizeHorizontal*40,
          padding: pw.EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal*0,
              vertical: SizeConfig.blockSizeHorizontal*2),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children:  [

                  pw.Text(
                    'Authorised Name:',
                    style: pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  pw.SizedBox(
                    width: 5,
                  ),

                  pw.Text(
                    'Stuart S Paul',
                    style:  pw.TextStyle(
                      //color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 8,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),

              pw.SizedBox(
                height: 10,
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children:   [

                  pw.Text(
                    'Authorised Signature:',
                    style: pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  pw.SizedBox(
                    width: 5,
                  ),

                  pw.Container(
                    width: SizeConfig.blockSizeHorizontal*10,
                    height: 20,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          //color: Colors.black,
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

  pw.Widget generateSurveyInspector(){
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Container(
          width: SizeConfig.blockSizeHorizontal*40,
          padding: pw.EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal*0,
              vertical: SizeConfig.blockSizeHorizontal*2),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [

                  pw.Text(
                    'Surveyor\'s Name:',
                    style: pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  pw.SizedBox(
                    width: 5,
                  ),

                  pw.Text(
                    'Stuart S Paul',
                    style:  pw.TextStyle(
                      //color: Colors.black,
                        decoration: TextDecoration.underline,
                        fontSize: 8,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),

              pw.SizedBox(
                height: 10,
              ),

              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children:   [

                  pw.Text(
                    'Surveyor\'s Signature:',
                    style: pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  pw.SizedBox(
                    width: 5,
                  ),

                  pw.Container(
                    width: SizeConfig.blockSizeHorizontal*10,
                    height: 20,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          //color: Colors.black,
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

  pw.Widget generateHeading2(){
    return pw.Container(
      width: SizeConfig.screenWidth,
      padding: pw.EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal*1,
          vertical: SizeConfig.blockSizeHorizontal*1),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [

          pw.Text(
            'Annex to Certificate Of Thorough Examination',
            style: pw.TextStyle(
              //color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    );
  }

  pw.Widget generateCheckList(){
    return pw.Container(
        width: SizeConfig.screenWidth,
        decoration: pw.BoxDecoration(
            border: pw.Border.all(
              //color: Colors.black,
                width: 0.5)
        ),
        child: pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [

            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Container(
                  width: SizeConfig.blockSizeHorizontal*4,
                  height: 25,
                  padding: pw.EdgeInsets.all(2),
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    'S/No',
                    style:  pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),


                pw.SizedBox(
                  height: 25,
                  child: pw.VerticalDivider(
                    width: 1,
                    //color: pw.Colors.black,
                    thickness: 0.5,
                  ),
                ),

                pw.Container(
                  width: SizeConfig.blockSizeHorizontal*40,
                  padding: pw.EdgeInsets.all(2),
                  alignment: pw.Alignment.centerLeft,
                  height: 25,
                  child: pw.Text(
                    'Description',
                    overflow: pw.TextOverflow.clip,
                    maxLines: 3,
                    style:  pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),


                pw.SizedBox(
                  height: 25,
                  child: pw.VerticalDivider(
                    width: 1,
                    //color: Colors.black,
                    thickness: 0.5,
                  ),
                ),

                pw.Container(
                  width: SizeConfig.blockSizeHorizontal*40,
                  padding: pw.EdgeInsets.all(2),
                  alignment: pw.Alignment.centerLeft,
                  height: 25,
                  child: pw.Text(
                    'Conditions / Remarks',
                    style:  pw.TextStyle(
                      //color: Colors.black,
                        fontSize: 8,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),

            pw.ListView.builder(
              itemCount: checkBoxForm.length,
              padding: pw.EdgeInsets.all(0),
              itemBuilder: (pw.Context context, int index) {
                return pw.Container(
                  height: 25,
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      //pw.color: Colors.black,
                        width: 0.5),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal*4,
                        padding: pw.EdgeInsets.all(2),
                        height: 25,
                        alignment: pw.Alignment.center,
                        child: pw.Text(
                          (index + 1).toString(),
                          style: pw.TextStyle(
                            //color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        height: 25,
                        child: pw.VerticalDivider(
                          width: 1,
                          //color: Colors.black,
                          thickness: 0.5,
                        ),
                      ),

                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal*40,
                        padding: pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          (checkBoxForm[index].question != null) ? checkBoxForm[index].question! : '',
                          overflow: pw.TextOverflow.clip,
                          maxLines: 1,
                          style: pw.TextStyle(
                            //color: Colors.black,
                              fontSize: 8,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                      pw.SizedBox(
                        height: 25,
                        child: pw.VerticalDivider(
                          width: 1,
                          //color: Colors.black,
                          thickness: 0.5,
                        ),
                      ),

                      pw.Container(
                        width: SizeConfig.blockSizeHorizontal*40,
                        padding: pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          (checkBoxForm[index].answer != null) ? checkBoxForm[index].answer! : '',
                          overflow: pw.TextOverflow.clip,
                          maxLines: 1,
                          style: pw.TextStyle(
                            //color: Colors.black,
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

  pw.Widget generateRemark2(){
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(
          //color: Colors.black,
            width: 0.5),
      ),
      padding: pw.EdgeInsets.all(2),
      alignment: pw.Alignment.centerLeft,
      width: SizeConfig.screenWidth,
      child: pw.Text(
        'COMMENTS: ',
        textAlign: TextAlign.left,
        style: pw.TextStyle(
          //color: Colors.black,
            fontSize: 8,
            fontWeight: FontWeight.bold
        ),
      ),

    );
  }
}*/
