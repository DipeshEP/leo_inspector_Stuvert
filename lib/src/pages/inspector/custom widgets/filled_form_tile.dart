import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/drop_down_ui.dart';

import 'question_ui.dart';

class FilledFormTile extends StatelessWidget {
  final Question? question;
  const FilledFormTile({Key? key,required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isDateValid = false;
    if(question!.answer != null){
      isDateValid = isDate(question!.answer);
    }

    DateTime? date = stringToDate(question!.answer);


    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              width: SizeConfig.blockSizeHorizontal*37,
              alignment: Alignment.topLeft,
              child: Text(
                (question!.question != null) ? question!.question!.trimLeft() : '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12
                ),
              ),
            ),

            SizedBox(
              width: SizeConfig.blockSizeHorizontal*3,
              child: const Text(
                ' : ',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12
                ),
              ),
            ),

            (question!.type == 'Date' && isDateValid && date != null) ?
            Container(
                width: SizeConfig.blockSizeHorizontal*37,
                alignment: Alignment.topLeft,
                child: Text(
                  DateFormat('dd MMM yyyy').format(date),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12
                ),
              )
            ):
            Container(
              width: SizeConfig.blockSizeHorizontal*37,
                alignment: Alignment.topLeft,
                child: Text(
               (question!.answer != null) ? question!.answer!.toString().trimLeft() : '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
