
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart';

import '../../Model/company_model.dart';
import '../../Model/inspector_model2.dart';
import '../../src/pages/inspector/custom widgets/question_ui.dart';

class PdfRepository {


  Future<File?> createPDF(
      List<Question> filledForm,
      List<Question> checkBoxForm,
      QuestionOption? questionOption,
      Inspector? authorisedInspector,
      Inspector? surveyInspector,
      String certificateNo,
      String? remarks,
      String? comment,
      bool signatureDisplay) async {

    try{

      /// Define all questions for two forms - Lifting Gear and Crane,
      /// Select the data for all these questions from the filled form list
      Question? inspectionDate, nameAddress, inspectionLocation,issueDate,jobRefNo,timeSheetNo;
      //lifting gear
      Question? requestedBy, makerSupplier, refStandard,idNo, qty, description, proofLoad,swl,inspPrNo, checkListNo;
      //Lifting appliances
      Question? makerDate,title, regNo, ownerNo, modelNo, serialNo, boomLength, radius, testLoad;
      //common questions
      Question? dateOfLastExam, dateOfNextExam, dateOfLastProof,dateOfNextProof;


      /// filter list
      print('filledForm.length 1');
      print(filledForm.length);

      /// Lifting gear
      if(questionOption!.equipmentType == "Lifting Gear"){
        for(int i = 0; i < filledForm.length; i++){
          if(filledForm[i].question != null){
            print(filledForm[i].question!);
            if(filledForm[i].question!.trim() == 'Date of Inspection'){
              inspectionDate = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Name and Address of the Owner'){
              nameAddress = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Place of Inspection'){
              inspectionLocation = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Requested By'){
              requestedBy = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Maker or Supplier'){
              makerSupplier = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Reference standard' || filledForm[i].question!.trim() == 'Ref. Standard'){
              refStandard = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'ID NO.'){
              idNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Qty'){
              qty = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Description'){
              description = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Proof Load Applied'){
              proofLoad = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'SWL'){
              swl = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Insp. Pr. No. :'){
              inspPrNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Checklist No.'){
              checkListNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Last Examination'){
              dateOfLastExam = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of next inspection'){
              dateOfNextExam = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Last Proof Load Test'){
              dateOfLastProof = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Next Proof Load Test'){
              dateOfNextProof = filledForm[i];
            }
          }
        }
      }
      /// Lifting appliances
      else if(questionOption.equipmentType == "Lifting appliance" || questionOption.equipmentType == 'Lifting Appliances'){
        for(int i = 0; i < filledForm.length; i++){
          if(filledForm[i].question != null){
            print(filledForm[i].question!);
            if(filledForm[i].question!.trim() == 'Date of Inspection'){
              inspectionDate = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Name and address pf the Owner'){
              nameAddress = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Place of Inspection'){
              inspectionLocation = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Maker & Date of Manufacturer'){
              makerDate = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'DIESEL POWERD HYDRULIC TELESCOPIC BOOM ALL TERRAIN MOBILE CRANE'){
              title = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Description of Test'){
              description = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Boom Length'){
              boomLength = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Radius'){
              radius = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Test Load'){
              testLoad = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'SWL'){
              swl = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Insp. Pr.No '){
              inspPrNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Checklist No.'){
              checkListNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Last Examination'){
              dateOfLastExam = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Next Examination'){
              dateOfNextExam = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Last Proof Load Test'){
              dateOfLastProof = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Date of Next Proof Load Test'){
              dateOfNextProof = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Reg.No'){
              regNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Owner.No'){
              ownerNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Model.No'){
              modelNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Serial.No'){
              serialNo = filledForm[i];
            }
            if(filledForm[i].question!.trim() == 'Ref.Standard'){
              refStandard = filledForm[i];
            }

            // Serial No, description, boom length, radius, testload, swl,
          }
        }
      }
      ///Default
      else{
        for(int i = 0; i < filledForm.length; i++){
          if(filledForm[i].question != null){
            print(filledForm[i].question!);
            if(filledForm[i].question!.trim() == 'Date of Inspection'){
              print('has inspection date');
              inspectionDate = filledForm[i];
              filledForm.removeAt(i);
            }
            else if(filledForm[i].question!.trim() == 'Name And address of the Owner'){
              print('has Name And address');
              nameAddress = filledForm[i];
              filledForm.removeAt(i);
            }
            else if(filledForm[i].question!.trim() == 'Place of Inspection'){
              print('has Place of Inspection');
              inspectionLocation = filledForm[i];
              filledForm.removeAt(i);
            }
            else if(filledForm[i].question!.trim() == 'Job Reference Number'){
              print('has Job Reference Number');
              jobRefNo = filledForm[i];
              filledForm.removeAt(i);
            }
            else if(filledForm[i].question!.trim() == 'Time Sheet Number'){
              print('has Time Sheet');
              timeSheetNo = filledForm[i];
              filledForm.removeAt(i);
            }
            else if(filledForm[i].question!.trim() == 'Date of Issue'){
              print('has Date of Issue');
              issueDate = filledForm[i];
              filledForm.removeAt(i);
            }
          }
        }
      }

      /// setup pdf document
      PdfDocument document = PdfDocument();

      final page1 = document.pages.add();

      double blockHeight = page1.getClientSize().height / 100;
      double blockWidth = page1.getClientSize().width / 100;
      PdfFont titleFont = PdfStandardFont(PdfFontFamily.helvetica, 18,style: PdfFontStyle.bold);
      PdfFont subTitleFont = PdfStandardFont(PdfFontFamily.helvetica, 16,style: PdfFontStyle.bold);
      PdfFont contentFont1 = PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold);
      PdfFont contentFont2 = PdfStandardFont(PdfFontFamily.helvetica, 9);
      var topBorder = PdfBorders(top: PdfPen(PdfColor(255, 255, 255), width: 0));
      var bottomBorder = PdfBorders(bottom: PdfPen(PdfColor(255, 255, 255), width: 0));

      /// Watermark
      PdfGraphics graphics1 = page1.graphics;
      PdfGraphicsState state = graphics1.save();
      graphics1.setTransparency(0.05);
      graphics1.drawImage(
          PdfBitmap(await _readImageFromAsset('certificate_logo.png')),
          Rect.fromLTWH(blockWidth*20, blockHeight*30, blockWidth*60, blockWidth*60));

      graphics1.restore(state);


      /// Title
      PdfTextElement textElement = PdfTextElement(
        text: 'CERTIFICATE',
        font: titleFont,
        brush: PdfBrushes.black,
      );
      PdfLayoutResult layoutResult = textElement.draw(
          page: page1,
          bounds: Rect.fromCenter(center: Offset(blockWidth * 55, blockHeight*10), width: blockWidth*40, height: blockHeight*5)//Rect.fromCenter( 0, , blockHeight*5)
      )!;

      /// subtitle equipment type
      String equipmentType = "";
      if(questionOption.equipmentType != null){
        equipmentType = questionOption.equipmentName!;
      }
      textElement.text = 'Of Thorough Examination of $equipmentType';
      textElement.brush =  PdfBrushes.darkCyan;
      textElement.font = subTitleFont;
      layoutResult = textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth *15, layoutResult.bounds.bottom + 2,  blockWidth*80, blockHeight*5)
      )!;

      /// certificate number
      textElement.text =  'Certificate No:   $certificateNo';
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont1;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*3, blockWidth*50,blockHeight*5)
      )!;

      /// inspection date
      String inspecDate = "";
      bool isDateValid = false;
      if(inspectionDate != null && inspectionDate.answer != null && inspectionDate.type == "Date"){
        isDateValid = isDate(inspectionDate.answer);
        DateTime? date = stringToDate(inspectionDate.answer);
        if(date != null){
          inspecDate = DateFormat('dd/MM/yyyy').format(date);
        }
      }
      textElement.text =  'Date of inspection:   $inspecDate';
      layoutResult = textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth*67, layoutResult.bounds.bottom + blockHeight*3, blockWidth*50,blockHeight*5)
      )!;

      /// Setup table
      /// Lifting gear
      if(questionOption.equipmentType == "Lifting Gear"){

        //First row : Name & Address of the Owner ,Place of Inspection, Requested By
        PdfGrid section1 = PdfGrid();
        section1.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section1.columns.add(count: 3);

        /// Title
        PdfGridRow section1TitleRow = section1.rows.add();
        section1TitleRow.cells[0].value = 'Name and Address of the Owner';
        section1TitleRow.cells[0].style.font = contentFont2;
        section1TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1TitleRow.cells[0].style.borders = bottomBorder;
        section1TitleRow.cells[1].value = 'Place Of Inspection';
        section1TitleRow.cells[1].style.font = contentFont2;
        section1TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1TitleRow.cells[1].style.borders = bottomBorder;
        section1TitleRow.cells[2].value = 'Requested By';
        section1TitleRow.cells[2].style.font = contentFont2;
        section1TitleRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1TitleRow.cells[2].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section1AnswerRow = section1.rows.add();
        section1AnswerRow.cells[0].value = (nameAddress != null && nameAddress.answer != null) ? nameAddress.answer.toString().toUpperCase() : '';
        section1AnswerRow.cells[0].style.font = contentFont1;
        section1AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1AnswerRow.cells[0].style.borders = topBorder;
        section1AnswerRow.cells[1].value = (inspectionLocation != null && inspectionLocation.answer != null) ? inspectionLocation.answer.toString().toUpperCase() : '';
        section1AnswerRow.cells[1].style.font = contentFont1;
        section1AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1AnswerRow.cells[1].style.borders = topBorder;
        section1AnswerRow.cells[2].value = (requestedBy != null && requestedBy.answer != null) ? requestedBy.answer.toString().toUpperCase() : '';
        section1AnswerRow.cells[2].style.font = contentFont1;
        section1AnswerRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1AnswerRow.cells[2].style.borders = topBorder;
        layoutResult = section1.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*2, 0, 0))!;


        //Second : Maker or Supplier, Ref.Standard
        PdfGrid section2 = PdfGrid();
        section2.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section2.columns.add(count: 2);

        /// Title
        PdfGridRow section2TitleRow = section2.rows.add();
        section2TitleRow.cells[0].value = 'Maker or Supplier';
        section2TitleRow.cells[0].style.font = contentFont2;
        section2TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2TitleRow.cells[0].style.borders = bottomBorder;
        section2TitleRow.cells[1].value = 'Ref.Standard';
        section2TitleRow.cells[1].style.font = contentFont2;
        section2TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2TitleRow.cells[1].style.borders = bottomBorder;

        /// Answers
        PdfGridRow section2AnswerRow = section2.rows.add();
        section2AnswerRow.cells[0].value = (makerSupplier != null && makerSupplier.answer != null) ? makerSupplier.answer.toString().toUpperCase() : '';
        section2AnswerRow.cells[0].style.font = contentFont1;
        section2AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2AnswerRow.cells[0].style.borders = topBorder;
        section2AnswerRow.cells[1].value = (refStandard != null && refStandard.answer != null) ? refStandard.answer.toString().toUpperCase() : '';
        section2AnswerRow.cells[1].style.font = contentFont1;
        section2AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2AnswerRow.cells[1].style.borders = topBorder;
        layoutResult = section2.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

        //Third: QTY, DESCRIPTION, Proof Load Applied, SWL
        PdfGrid section3 = PdfGrid();
        section3.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section3.columns.add(count: 5);

        /// Title
        PdfGridRow section3TitleRow = section3.rows.add();
        section3TitleRow.cells[0].value = 'ID No.';
        section3TitleRow.cells[0].style.font = contentFont2;
        section3TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);

        section3TitleRow.cells[1].value = 'Qty.';
        section3TitleRow.cells[1].style.font = contentFont2;
        section3TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section3TitleRow.cells[0].style.borders = bottomBorder;
        section3TitleRow.cells[2].value = 'Description';
        section3TitleRow.cells[2].style.font = contentFont2;
        section3TitleRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section3TitleRow.cells[2].columnSpan = (blockWidth*30).toInt();

        //section3TitleRow.cells[1].style.borders = bottomBorder;
        section3TitleRow.cells[3].value = 'Proof Load Applied';
        section3TitleRow.cells[3].style.font = contentFont2;
        section3TitleRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section3TitleRow.cells[2].style.borders = bottomBorder;
        section3TitleRow.cells[4].value = 'SWL';
        section3TitleRow.cells[4].style.font = contentFont2;
        section3TitleRow.cells[4].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section3TitleRow.cells[3].style.borders = bottomBorder;

        /// Answers
        PdfGridRow section3AnswerRow = section3.rows.add();
        section3AnswerRow.cells[0].value = (idNo != null && idNo.answer != null) ? idNo.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[0].style.font = contentFont1;
        section3AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[0].style.borders = topBorder;
        section3AnswerRow.cells[1].value = (qty != null && qty.answer != null) ? qty.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[1].style.font = contentFont1;
        section3AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[1].style.borders = topBorder;
        section3AnswerRow.cells[2].value = (description != null && description.answer != null) ? description.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[2].style.font = contentFont1;
        section3AnswerRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section3AnswerRow.cells[2].columnSpan = (blockWidth*30).toInt();

        section3AnswerRow.cells[2].style.borders = topBorder;
        section3AnswerRow.cells[3].value = (proofLoad != null && proofLoad.answer != null) ? proofLoad.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[3].style.font = contentFont1;
        section3AnswerRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[3].style.borders = topBorder;
        section3AnswerRow.cells[4].value = (swl != null && swl.answer != null) ? swl.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[4].style.font = contentFont1;
        section3AnswerRow.cells[4].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[4].style.borders = topBorder;
        layoutResult = section3.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

        //Fourth: Insp Pr.No, Checklist No
        PdfGrid section4 = PdfGrid();
        section4.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section4.columns.add(count: 2);

        /// Title
        PdfGridRow section4TitleRow = section4.rows.add();
        section4TitleRow.cells[0].value = 'Insp Pr.No';
        section4TitleRow.cells[0].style.font = contentFont2;
        section4TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section4TitleRow.cells[0].style.borders = bottomBorder;
        section4TitleRow.cells[1].value = 'Checklist No';
        section4TitleRow.cells[1].style.font = contentFont2;
        section4TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section4TitleRow.cells[1].style.borders = bottomBorder;

        /// Answers
        PdfGridRow section4AnswerRow = section4.rows.add();
        section4AnswerRow.cells[0].value = (inspPrNo != null && inspPrNo.answer != null) ? inspPrNo.answer.toString().toUpperCase() : '';
        section4AnswerRow.cells[0].style.font = contentFont1;
        section4AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section4AnswerRow.cells[0].style.borders = topBorder;
        section4AnswerRow.cells[1].value = (checkListNo != null && checkListNo.answer != null) ? checkListNo.answer.toString().toUpperCase() : '';
        section4AnswerRow.cells[1].style.font = contentFont1;
        section4AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section4AnswerRow.cells[1].style.borders = topBorder;
        layoutResult = section4.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

      }
      /// Lifting appliances
      else if(questionOption.equipmentType == "Lifting Appliances" || questionOption.equipmentType == 'Lifting appliance'){

        //First row : Name And address of the Owner ,place of Inspection,
        PdfGrid section1 = PdfGrid();
        section1.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section1.columns.add(count: 2);

        /// Title
        PdfGridRow section1TitleRow = section1.rows.add();
        section1TitleRow.cells[0].value = 'Name and Address of the Owner';
        section1TitleRow.cells[0].style.font = contentFont2;
        section1TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1TitleRow.cells[0].style.borders = bottomBorder;
        section1TitleRow.cells[1].value = 'Place Of Inspection';
        section1TitleRow.cells[1].style.font = contentFont2;
        section1TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1TitleRow.cells[1].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section1AnswerRow = section1.rows.add();
        section1AnswerRow.cells[0].value = (nameAddress != null && nameAddress.answer != null) ? nameAddress.answer.toString().toUpperCase() : '';
        section1AnswerRow.cells[0].style.font = contentFont1;
        section1AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1AnswerRow.cells[0].style.borders = topBorder;
        section1AnswerRow.cells[1].value = (inspectionLocation != null && inspectionLocation.answer != null) ? inspectionLocation.answer.toString().toUpperCase() : '';
        section1AnswerRow.cells[1].style.font = contentFont1;
        section1AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section1AnswerRow.cells[1].style.borders = topBorder;
        layoutResult = section1.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*2, 0, 0))!;


        //Second :Ref.standard, MAKER & DATE OF MANUFACTURE
        PdfGrid section2 = PdfGrid();
        section2.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section2.columns.add(count: 2);

        /// Title
        PdfGridRow section2TitleRow = section2.rows.add();
        section2TitleRow.cells[0].value = 'Ref. Standard';
        section2TitleRow.cells[0].style.font = contentFont2;
        section2TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2TitleRow.cells[0].style.borders = bottomBorder;
        section2TitleRow.cells[1].value = 'Maker & Date of Manufacturer';
        section2TitleRow.cells[1].style.font = contentFont2;
        section2TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2TitleRow.cells[1].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section2AnswerRow = section2.rows.add();
        section2AnswerRow.cells[0].value = (refStandard != null && refStandard.answer != null) ? refStandard.answer.toString().toUpperCase() : '';
        section2AnswerRow.cells[0].style.font = contentFont1;
        section2AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2AnswerRow.cells[0].style.borders = topBorder;
        section2AnswerRow.cells[1].value = (makerDate != null && makerDate.answer != null) ? makerDate.answer.toString().toUpperCase() : '';
        section2AnswerRow.cells[1].style.font = contentFont1;
        section2AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section2AnswerRow.cells[1].style.borders = topBorder;
        layoutResult = section2.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;


        //Third : Reg.No, Owner.No, Model.No, Serial.No
        PdfGrid section3 = PdfGrid();
        section3.style = PdfGridStyle(
            font: contentFont1,
            // cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5)
        );
        section3.columns.add(count: 4);

        /// Title
        PdfGridRow section3TitleRow = section3.rows.add();
        section3TitleRow.cells[0].value = 'Registration No.';
        section3TitleRow.cells[0].style.font = contentFont2;
        section3TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3TitleRow.cells[0].style.borders = bottomBorder;
        section3TitleRow.cells[1].value = 'Owner No.';
        section3TitleRow.cells[1].style.font = contentFont2;
        section3TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3TitleRow.cells[1].style.borders = bottomBorder;
        section3TitleRow.cells[2].value = 'Model No.';
        section3TitleRow.cells[2].style.font = contentFont2;
        section3TitleRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3TitleRow.cells[2].style.borders = bottomBorder;
        section3TitleRow.cells[3].value = 'Serial No.';
        section3TitleRow.cells[3].style.font = contentFont2;
        section3TitleRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3TitleRow.cells[3].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section3AnswerRow = section3.rows.add();
        section3AnswerRow.cells[0].value = (regNo != null && regNo.answer != null) ? regNo.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[0].style.font = contentFont1;
        section3AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[0].style.borders = topBorder;
        section3AnswerRow.cells[1].value = (ownerNo != null && ownerNo.answer != null) ? ownerNo.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[1].style.font = contentFont1;
        section3AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[1].style.borders = topBorder;
        section3AnswerRow.cells[2].value = (modelNo != null && modelNo.answer != null) ? modelNo.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[2].style.font = contentFont1;
        section3AnswerRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[2].style.borders = topBorder;
        section3AnswerRow.cells[3].value = (serialNo != null && serialNo.answer != null) ? serialNo.answer.toString().toUpperCase() : '';
        section3AnswerRow.cells[3].style.font = contentFont1;
        section3AnswerRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section3AnswerRow.cells[3].style.borders = topBorder;
        layoutResult = section3.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

        //Fourth:
        PdfGrid section4 = PdfGrid();
        section4.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 17, right: 2, top: 5, bottom: 5));
        section4.columns.add(count: 1);

        /// Title
        PdfGridRow section4TitleRow = section4.rows.add();
        section4TitleRow.cells[0].value = 'DIESEL POWERD HYDRULIC TELESCOPIC BOOM ALL TERRAIN MOBILE CRANE';
        section4TitleRow.cells[0].style.font = contentFont2;
        section4TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.left);
        section4TitleRow.cells[0].style.borders = bottomBorder;

        /// Answers
        PdfGridRow section4AnswerRow = section4.rows.add();
        section4AnswerRow.cells[0].value = (title != null && title.answer != null) ? title.answer.toString().toUpperCase() : '';
        section4AnswerRow.cells[0].style.font = contentFont1;
        section4AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.left);
        section4AnswerRow.cells[0].style.borders = topBorder;
        layoutResult = section4.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

        //Fifth: Description, Boom Length, Radius, Test Load, SWL
        PdfGrid section5 = PdfGrid();
        section5.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section5.columns.add(count: 5);

        /// Title
        PdfGridRow section5TitleRow = section5.rows.add();
        section5TitleRow.cells[0].value = 'Description of Test';
        section5TitleRow.cells[0].style.font = contentFont2;
        section5TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5TitleRow.cells[0].style.borders = bottomBorder;
        //section5TitleRow.cells[0].columnSpan = (blockWidth*40).toInt();

        section5TitleRow.cells[1].value = 'Boom Length';
        section5TitleRow.cells[1].style.font = contentFont2;
        section5TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section5TitleRow.cells[1].style.borders = bottomBorder;
        section5TitleRow.cells[2].value = 'Radius';
        section5TitleRow.cells[2].style.font = contentFont2;
        section5TitleRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section5TitleRow.cells[2].style.borders = bottomBorder;
        section5TitleRow.cells[3].value = 'Test Load';
        section5TitleRow.cells[3].style.font = contentFont2;
        section5TitleRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section5TitleRow.cells[3].style.borders = bottomBorder;
        section5TitleRow.cells[4].value = 'SWL';
        section5TitleRow.cells[4].style.font = contentFont2;
        section5TitleRow.cells[4].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        //section5TitleRow.cells[4].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section5AnswerRow = section5.rows.add();
        section5AnswerRow.cells[0].value = (description != null && description.answer != null) ? description.answer.toString().toUpperCase() : '';
        section5AnswerRow.cells[0].style.font = contentFont1;
        section5AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5AnswerRow.cells[0].style.borders = topBorder;
        //section5AnswerRow.cells[0].columnSpan = (blockWidth*40).toInt();

        section5AnswerRow.cells[1].value = (boomLength != null && boomLength.answer != null) ? boomLength.answer.toString().toUpperCase() : '';
        section5AnswerRow.cells[1].style.font = contentFont1;
        section5AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5AnswerRow.cells[1].style.borders = topBorder;
        section5AnswerRow.cells[2].value = (radius != null && radius.answer != null) ? radius.answer.toString().toUpperCase() : '';
        section5AnswerRow.cells[2].style.font = contentFont1;
        section5AnswerRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5AnswerRow.cells[2].style.borders = topBorder;
        section5AnswerRow.cells[3].value = (testLoad != null && testLoad.answer != null) ? testLoad.answer.toString().toUpperCase() : '';
        section5AnswerRow.cells[3].style.font = contentFont1;
        section5AnswerRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5AnswerRow.cells[3].style.borders = topBorder;
        section5AnswerRow.cells[4].value = (swl != null && swl.answer != null) ? swl.answer.toString().toUpperCase() : '';
        section5AnswerRow.cells[4].style.font = contentFont1;
        section5AnswerRow.cells[4].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section5AnswerRow.cells[4].style.borders = topBorder;
        layoutResult = section5.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;

        //Sixth: Insp Pr.No, Checklist No
        PdfGrid section6 = PdfGrid();
        section6.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        section6.columns.add(count: 2);

        /// Title
        PdfGridRow section6TitleRow = section6.rows.add();
        section6TitleRow.cells[0].value = 'Insp. Pr. No.';
        section6TitleRow.cells[0].style.font = contentFont2;
        section6TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section6TitleRow.cells[0].style.borders = bottomBorder;
        section6TitleRow.cells[1].value = 'Checklist No.';
        section6TitleRow.cells[1].style.font = contentFont2;
        section6TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section6TitleRow.cells[1].style.borders = bottomBorder;


        /// Answers
        PdfGridRow section6AnswerRow = section6.rows.add();
        section6AnswerRow.cells[0].value = (inspPrNo != null && inspPrNo.answer != null) ? inspPrNo.answer.toString().toUpperCase() : '';
        section6AnswerRow.cells[0].style.font = contentFont1;
        section6AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section6AnswerRow.cells[0].style.borders = topBorder;
        section6AnswerRow.cells[1].value = (checkListNo != null && checkListNo.answer != null) ? checkListNo.answer.toString().toUpperCase() : '';
        section6AnswerRow.cells[1].style.font = contentFont1;
        section6AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
        section6AnswerRow.cells[1].style.borders = topBorder;
        layoutResult = section6.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;
      }
      ///Default
      else{
        PdfGrid mainDetailGrid = PdfGrid();
        mainDetailGrid.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 1, bottom: 1));
        mainDetailGrid.columns.add(count: 2);
        PdfGridRow mainDetailRow = mainDetailGrid.rows.add();


        /// Name and address of owner
        String nameAndAddress = "";
        if(nameAddress != null && nameAddress.answer != null){
          nameAndAddress = nameAddress.answer!;
        }
        mainDetailRow.cells[0].value = 'Name and address of the owner';
        mainDetailRow.cells[0].style.font = contentFont1;
        mainDetailRow.cells[1].value = nameAndAddress;
        mainDetailRow.cells[1].style.font = contentFont2;


        /// Place of inspection
        String placeOfInspection = "";
        if(inspectionLocation != null && inspectionLocation.answer != null){
          placeOfInspection = inspectionLocation.answer!;
        }
        mainDetailRow = mainDetailGrid.rows.add();
        mainDetailRow.cells[0].value = 'Place of inspection';
        mainDetailRow.cells[0].style.font = contentFont1;
        mainDetailRow.cells[1].value = placeOfInspection;
        mainDetailRow.cells[1].style.font = contentFont2;


        ///Build list of inspection
        String question = "", answer = "";
        for(int i = 0; i < filledForm.length; i++){
          isDateValid = false;
          if(filledForm[i].answer != null){
            if(filledForm[i].type == 'Date'){
              isDateValid = isDate(filledForm[i].answer);
              DateTime? date = stringToDate(filledForm[i].answer);
              if(date != null){
                answer = DateFormat('dd/MM/yyyy').format(date);
              }
              else if(filledForm[i].answer != null){
                answer = filledForm[i].answer!;
              }
            }
            else{
              answer = filledForm[i].answer!;
            }
          }
          if(filledForm[i].question != null){
            question = filledForm[i].question!;
          }
          mainDetailRow = mainDetailGrid.rows.add();
          mainDetailRow.cells[0].value = question;
          mainDetailRow.cells[0].style.font = contentFont1;
          mainDetailRow.cells[1].value = answer;
          mainDetailRow.cells[1].style.font = contentFont2;
          question = "";
          answer = "";
          isDateValid = false;
        }
        layoutResult = mainDetailGrid.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*2, 0, 0))!;


        ///Draw Remarks
        String rem = "";
        if(remarks != null){
          rem = remarks;
        }
        PdfGrid remarksGrid = PdfGrid();
        remarksGrid.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 1, top: 2, bottom: 2));
        remarksGrid.columns.add(count: 1);
        PdfGridRow remarksRow = remarksGrid.rows.add();
        remarksRow.cells[0].value = 'Remarks:  $rem';
        remarksRow.cells[0].style.font = contentFont1;
        layoutResult = remarksGrid.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom, 0, 0))!;


        ///Date of Issue
        String issDate = "";
        isDateValid = false;
        if(issueDate != null && issueDate.answer != null){
          isDateValid = isDate(issueDate.answer);
          DateTime? date2 = stringToDate(issueDate.answer);
          if(date2 != null){
            issDate = DateFormat('dd/MM/yyyy').format(date2);
          }
        }

        textElement.text =  'Date of Issue:   $issDate';
        textElement.brush =  PdfBrushes.black;
        textElement.font = contentFont1;
        textElement.draw(
            page: page1,
            bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*3, blockWidth*30,blockHeight*5)
        )!;

        ///Job Ref No.
        String jobRef = "";
        if(jobRefNo != null && jobRefNo.answer != null){
          jobRef = jobRefNo.answer!;
        }
        textElement.text =  'Job Ref No.:  $jobRef';
        textElement.draw(
            page: page1,
            bounds: Rect.fromLTWH(blockWidth*35, layoutResult.bounds.bottom + blockHeight*3, blockWidth*50,blockHeight*5)
        )!;

        ///Time Sheet No.
        String tmSht = "";
        if(timeSheetNo != null && timeSheetNo.answer != null){
          tmSht = timeSheetNo.answer!;
        }
        textElement.text =  'Time Sheet No.:  $tmSht';
        layoutResult = textElement.draw(
            page: page1,
            bounds: Rect.fromLTRB(blockWidth*75, layoutResult.bounds.bottom + blockHeight*3, 0,0)
        )!;
      }

      /// Common Bottom table
      // Date of Last Examination, Date of next Examination, Date of Last Proof Load Test, Date of Next Proof Load Test
      PdfGrid section0 = PdfGrid();
      section0.style = PdfGridStyle(
          font: contentFont1,
          cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
      section0.columns.add(count: 4);

      /// Title
      PdfGridRow section0TitleRow = section0.rows.add();
      section0TitleRow.cells[0].value = 'Date of Last Examination';
      section0TitleRow.cells[0].style.font = contentFont2;
      section0TitleRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0TitleRow.cells[1].value = 'Date of Next Examination';
      section0TitleRow.cells[1].style.font = contentFont2;
      section0TitleRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0TitleRow.cells[2].value = 'Date of Last Proof Load Test';
      section0TitleRow.cells[2].style.font = contentFont2;
      section0TitleRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0TitleRow.cells[3].value = 'Date of Next Proof Load Test';
      section0TitleRow.cells[3].style.font = contentFont2;
      section0TitleRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);

      /// Answers
      PdfGridRow section0AnswerRow = section0.rows.add();
      String dateText = "";
      isDateValid = false;
      if(dateOfLastExam != null && dateOfLastExam.answer != null && dateOfLastExam.type == 'Date'){
        isDateValid = isDate(dateOfLastExam.answer);
        DateTime? date = stringToDate(dateOfLastExam.answer);
        if(date != null){
          dateText = DateFormat('dd/MM/yyyy').format(date);
        }
      }
      else if(dateOfLastExam != null && dateOfLastExam.answer != null){
        dateText = dateOfLastExam.answer!;
      }
      section0AnswerRow.cells[0].value = dateText;
      section0AnswerRow.cells[0].style.font = contentFont1;
      section0AnswerRow.cells[0].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0AnswerRow.cells[0].style.borders = topBorder;

      dateText = "";
      isDateValid = false;
      if(dateOfNextExam != null && dateOfNextExam.answer != null && dateOfNextExam.type == 'Date'){
        isDateValid = isDate(dateOfNextExam.answer);
        DateTime? date = stringToDate(dateOfNextExam.answer);
        if(date != null){
          dateText = DateFormat('dd/MM/yyyy').format(date);
        }
      }
      else if(dateOfNextExam != null && dateOfNextExam.answer != null){
        dateText = dateOfNextExam.answer!;
      }
      section0AnswerRow.cells[1].value = dateText;
      section0AnswerRow.cells[1].style.font = contentFont1;
      section0AnswerRow.cells[1].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0AnswerRow.cells[1].style.borders = topBorder;

      dateText = "";
      isDateValid = false;
      if(dateOfLastProof != null && dateOfLastProof.answer != null && dateOfLastProof.type == 'Date'){
        isDateValid = isDate(dateOfLastProof.answer);
        DateTime? date = stringToDate(dateOfLastProof.answer);
        if(date != null){
          dateText = DateFormat('dd/MM/yyyy').format(date);
        }
      }
      else if(dateOfLastProof != null && dateOfLastProof.answer != null){
        dateText = dateOfLastProof.answer!;
      }
      section0AnswerRow.cells[2].value = dateText;
      section0AnswerRow.cells[2].style.font = contentFont1;
      section0AnswerRow.cells[2].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0AnswerRow.cells[2].style.borders = topBorder;

      dateText = "";
      isDateValid = false;
      if(dateOfNextProof != null && dateOfNextProof.answer != null && dateOfNextProof.type == 'Date'){
        isDateValid = isDate(dateOfNextProof.answer);
        DateTime? date = stringToDate(dateOfNextProof.answer);
        if(date != null){
          dateText = DateFormat('dd/MM/yyyy').format(date);
        }
      }
      else if(dateOfNextProof != null && dateOfNextProof.answer != null){
        dateText = dateOfNextProof.answer!;
      }
      section0AnswerRow.cells[3].value = dateText;
      section0AnswerRow.cells[3].style.font = contentFont1;
      section0AnswerRow.cells[3].style.stringFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
      section0AnswerRow.cells[3].style.borders = topBorder;
      layoutResult = section0.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom+ blockHeight*1, 0, 0))!;

      ///Draw Remarks
      String rem = "";
      if(remarks != null){
        rem = remarks;
      }
      PdfGrid remarksGrid = PdfGrid();
      remarksGrid.style = PdfGridStyle(
          font: contentFont1,
          cellPadding: PdfPaddings(left: 8, right: 1, top: 5, bottom: 5));
      remarksGrid.columns.add(count: 1);
      PdfGridRow remarksRow = remarksGrid.rows.add();
      remarksRow.cells[0].value = rem;
      remarksRow.cells[0].style.font = contentFont2;
      layoutResult = remarksGrid.draw(page: page1, bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*1, 0, 0))!;


      /// Authorized name
      String authName = "";
      if(authorisedInspector != null && authorisedInspector.name != null){
        authName = authorisedInspector.name!;
      }
      textElement.text =  'Authorized Name: ';
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont1;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*3, blockWidth*24,blockHeight*10)
      )!;
      textElement.text =  authName.toUpperCase();
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont2;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth*25, layoutResult.bounds.bottom + blockHeight*3, blockWidth*25,blockHeight*10)
      )!;

      /// Surveyors name
      String surName = "";
      if(surveyInspector != null && surveyInspector.name != null){
        surName = surveyInspector.name!;
      }
      textElement.text =  'Surveyor\'s Name: ';
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont1;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth*51, layoutResult.bounds.bottom + blockHeight*3, blockWidth*24,blockHeight*10)
      )!;
      textElement.text =  surName.toUpperCase();
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont2;
      layoutResult = textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth*75, layoutResult.bounds.bottom + blockHeight*3, blockWidth*25,blockHeight*10)
      )!;

      /// Authorized Signature
      String authSign = "";
      if(authorisedInspector != null && authorisedInspector.signatureUrl != null){
        authSign = authorisedInspector.signatureUrl!;
      }
      textElement.text =  'Authorized Signature:';
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont1;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + blockHeight*3, blockWidth*24,blockHeight*10)
      )!;
      if(authSign != "" && signatureDisplay){
        page1.graphics.drawImage(
            PdfBitmap(await _readImageData(authSign)),
            Rect.fromLTWH(blockWidth*25, layoutResult.bounds.bottom + blockHeight*3, blockWidth*23, blockHeight*10));
      }

      /// Surveyor Signature
      String surSign = "";
      if(surveyInspector != null && surveyInspector.signatureUrl != null){
        surSign = surveyInspector.signatureUrl!;
      }
      textElement.text =  'Surveyor\'s Signature:';
      textElement.brush =  PdfBrushes.black;
      textElement.font = contentFont1;
      textElement.draw(
          page: page1,
          bounds: Rect.fromLTWH(blockWidth*51, layoutResult.bounds.bottom + blockHeight*3, blockWidth*24,blockHeight*10)
      )!;
      if(surSign != "" && signatureDisplay){
        page1.graphics.drawImage(
            PdfBitmap(await _readImageData(surSign)),
            Rect.fromLTWH(blockWidth*75, layoutResult.bounds.bottom + blockHeight*3, blockWidth*23, blockHeight*10));
      }


      if(checkBoxForm.isNotEmpty){
        /// second page
        final page2 = document.pages.add();

        /// Watermark
        PdfGraphics graphics2 = page1.graphics;
        PdfGraphicsState state = graphics2.save();
        graphics2.setTransparency(0.05);
        graphics2.drawImage(
            PdfBitmap(await _readImageFromAsset('certificate_logo.png')),
            Rect.fromLTWH(blockWidth*20, blockHeight*30, blockWidth*60, blockWidth*60));
        graphics2.restore(state);

        /// Draw Title
        PdfTextElement textElement2 = PdfTextElement(
          text: 'Annex to Certificate of Thorough Examination',
          font: subTitleFont,
          brush: PdfBrushes.darkCyan,
        );
        PdfLayoutResult layoutResult2 = textElement2.draw(
            page: page2,
            bounds: Rect.fromCenter(center: Offset(blockWidth * 55, blockHeight*15), width: blockWidth*80, height: blockHeight*10)//Rect.fromCenter( 0, , blockHeight*5)
        )!;


        /// Certificate No
        textElement2.text =  'Certificate No:   $certificateNo';
        textElement2.brush =  PdfBrushes.black;
        textElement2.font = contentFont1;
        textElement2.draw(
            page: page2,
            bounds: Rect.fromLTWH(0, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*50,blockHeight*5)
        )!;


        ///Date of inspection
        textElement2.text =  'Date of inspection:    $inspecDate';
        layoutResult2 = textElement2.draw(
            page: page2,
            bounds: Rect.fromLTWH(blockWidth*67, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*50,blockHeight*5)
        )!;


        ///Build checklist form
        PdfGrid checkListGrid = PdfGrid();
        checkListGrid.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 1, bottom: 1));
        checkListGrid.columns.add(count: 3);
        PdfGridRow checkListRow = checkListGrid.rows.add();

        /// CheckList Title
        checkListRow.cells[0].value = 'Sl No ';
        checkListRow.cells[0].style.stringFormat = PdfStringFormat(
            alignment: PdfTextAlignment.center);
        checkListRow.cells[0].style.font = contentFont1;
        checkListRow.cells[1].value = 'Description';
        checkListRow.cells[1].style.font = contentFont1;
        checkListRow.cells[2].value = 'Condition / Remarks';
        checkListRow.cells[2].style.font = contentFont1;

        ///CheckList Content
        String question2 = "", answer2 = "";
        for(int j = 0; j < checkBoxForm.length; j++){
          if(checkBoxForm[j].answer != null){
            answer2 = checkBoxForm[j].answer!;
          }
          if(checkBoxForm[j].question != null){
            question2 = checkBoxForm[j].question!;
          }
          checkListRow = checkListGrid.rows.add();
          checkListRow.cells[0].value = '1';
          checkListRow.cells[0].style.font = contentFont2;
          checkListRow.cells[0].style.stringFormat = PdfStringFormat(
              alignment: PdfTextAlignment.center);
          checkListRow.cells[1].value = question2;
          checkListRow.cells[1].style.font = contentFont2;
          checkListRow.cells[2].value = answer2;
          checkListRow.cells[2].style.font = contentFont2;
          question2 = "";
          answer2 = "";
        }
        layoutResult2 = checkListGrid.draw(page: page2, bounds: Rect.fromLTWH(0, layoutResult2.bounds.bottom + blockHeight*2, 0, 0))!;


        /// Build Comment
        String comnt = "";
        if(comment != null){
          comnt = comment;
        }
        PdfGrid commentGrid = PdfGrid();
        commentGrid.style = PdfGridStyle(
            font: contentFont1,
            cellPadding: PdfPaddings(left: 8, right: 2, top: 5, bottom: 5));
        commentGrid.columns.add(count: 1);
        PdfGridRow commentRow = commentGrid.rows.add();
        commentRow.cells[0].value = 'COMMENTS:   $comnt';
        commentRow.cells[0].style.font = contentFont1;
        layoutResult2 = commentGrid.draw(page: page2, bounds: Rect.fromLTWH(0, layoutResult2.bounds.bottom + 20, 0, 0))!;


        ///Surveyor Name
        textElement2.text =  'Surveyor\'s Name:';
        textElement2.brush =  PdfBrushes.black;
        textElement2.font = contentFont1;
        textElement2.draw(
            page: page2,
            bounds: Rect.fromLTWH(0, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*20,blockHeight*10)
        )!;
        textElement2.text =  surName.toUpperCase();
        textElement2.brush =  PdfBrushes.black;
        textElement2.font = contentFont2;
        textElement2.draw(
            page: page2,
            bounds: Rect.fromLTWH(blockWidth*21, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*25,blockHeight*10)
        )!;


        /// Surveyor Signature
        textElement2.text =  'Surveyor\'s Signature: ';
        textElement2.brush =  PdfBrushes.black;
        textElement2.font = contentFont1;
        textElement2.draw(
            page: page2,
            bounds: Rect.fromLTWH(blockWidth*50, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*24,blockHeight*10)
        )!;
        if(surSign != ""){
          page2.graphics.drawImage(
              PdfBitmap(await _readImageData(surSign)),
              Rect.fromLTWH(blockWidth*75, layoutResult2.bounds.bottom + blockHeight*3, blockWidth*25, blockHeight*10));
        }
      }

      List<int> bytes = await document.save();
      document.dispose();

      /// Build Pdf Name

      String name = '';
      if(surveyInspector != null && surveyInspector.name != null){
        name += surveyInspector.name!.toLowerCase().trim();
      }
      if(authorisedInspector != null && authorisedInspector.name != null){
        name += authorisedInspector.name!.toLowerCase().trim();
      }
      String dateTime = DateTime.now().toString().trim();
      name += dateTime;
      name =  name.replaceAll(":", "");
      name = name.replaceAll(" ", "");
      name = name.replaceAll(".", "");
      name = name.replaceAll("-", "");
      name += 'output.pdf';
      print(' ---------  PDF name ----------');
      print(name);

      final path = (await getTemporaryDirectory()).path;
      final file = File('$path/$name');
      await file.writeAsBytes(bytes);
      //OpenFile.open('$path/$name');
      return file;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<Uint8List> _readImageData(String imageAddress) async {

    //Read an image data from website/webspace
    var url = imageAddress;
    var response = await get(Uri.parse(url));
    var data = response.bodyBytes;

    //final data = await rootBundle.load('images/$name');
    return data; //.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<Uint8List> _readImageFromAsset(String img) async {
    final data = await rootBundle.load('assets/icons/$img');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }


  Future<void> saveAndLaunchFile(List<int> bytes, String name) async {
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$name');
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open('$path/$name');
  }

}