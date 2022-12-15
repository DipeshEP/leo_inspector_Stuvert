import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/drop_down_ui.dart';

class QuestionUI extends StatefulWidget {

  final Question? question;
  final Function(Question) onAnswered;

  const QuestionUI({Key? key,required this.question,required this.onAnswered}) : super(key: key);

  @override
  _QuestionUIState createState() => _QuestionUIState();
}

class _QuestionUIState extends State<QuestionUI> {

  late Question? _question;
  DropdownOption? _option;
  int? _checkBoxOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _question = widget.question;
    _option = DropdownOption();
    checkForAnswer();
  }

  @override
  Widget build(BuildContext context) {

    if(_question != null && _question!.type != null){
      switch(_question!.type){
        case "Text":
          return buildTextField('Text');
        case "Number":
          return buildTextField('Number');
        case "Date":
          return buildDatePicker();
        case "Radio":
          return buildRadioField();
        case "Checkbox":
          return buildCheckBox();
        case "Dropdown":
          return buildDropDown();
        default:
          return Container();
      }
    }
    return Container();
  }


  Widget buildDatePicker(){

    bool isValid = false;
    if(_question!.answer != null){
      isValid = isDate(_question!.answer);
    }

    DateTime? date = stringToDate(_question!.answer);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {

          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: (isValid && date != null) ? date : DateTime.now(),
              firstDate: DateTime(2000, 8),
              lastDate: DateTime(2101));

          if (picked != null) {
            // pickedDate = DateFormat('dd MMM yyyy').format(picked);
            if(!(isValid && (picked == date))){
              setState(() {
                _question!.answer = picked.toString();
              });
              widget.onAnswered(_question!);
            }
          }
        },
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal*50,
                    child: Text(
                      (_question!.question != null) ? _question!.question! : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.calendar_today,
                    size: 17,
                    color: Colors.black,
                  )
                ],
              ),

              (_question!.answer != null) ?
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      (date != null) ? DateFormat('dd MMM yyyy').format(date) : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ):Container()
            ],
          )
        ),
      ),
    );
  }

  Widget buildTextField(String type){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: (type == 'Number') ? TextInputType.number : TextInputType.multiline,
          /*inputFormatters: [
            FilteringTextInputFormatter.deny('-')
          ], */// Only numbe
          autofocus: false,
          maxLines: (_question!.question == "Description") ? 7 : 1,
          textAlign: TextAlign.start,
          onChanged: (v) {

            _question!.answer = v;
            setState(() {});

            EasyDebounce.debounce(
                'Debounce${_question!.questionId}',
                const Duration(milliseconds: 400), () {
              widget.onAnswered(_question!);
            });
          },
          initialValue: _question!.answer,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: (_question!.question != null) ? _question!.question! : '',
            labelStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
            contentPadding: EdgeInsets.fromLTRB(
              SizeConfig.blockSizeHorizontal*4,
              SizeConfig.blockSizeHorizontal*4,
              SizeConfig.blockSizeHorizontal*4,
              SizeConfig.blockSizeHorizontal*4,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(7)),
                borderSide:
                BorderSide(color: Colors.grey[200]!, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(7)),
                borderSide:
                BorderSide(color: Colors.grey[200]!, width: 1)),
            disabledBorder: OutlineInputBorder(
                borderRadius:
                const BorderRadius.all(Radius.circular(7)),
                borderSide:
                BorderSide(color: Colors.grey[200]!, width: 1)),
          ),
          onSaved: (input) {
            _question!.answer = input;
            setState(() {});
            widget.onAnswered(_question!);
          },
        ),
      ),
    );
  }

  Widget buildRadioField(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        //padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: EdgeInsets.fromLTRB(
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
          SizeConfig.blockSizeHorizontal*4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConfig.blockSizeHorizontal*50,
              child: Text(
                (_question!.question != null) ? _question!.question! : '',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14
                ),
              ),
            ),

            Radio(
                value: "radio value",
                groupValue: "group value",
                onChanged: (value){
                  print(value); //selected value
                }
            )
          ],
        ),
      ),
    );
  }

  Widget buildDropDown(){
    try{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {

            if(widget.question!.dropdownOptions!.isNotEmpty){
              showDialog(
                  context: context,
                  //barrierDismissible: false,
                  builder: (_) {
                    return DropDownUIDialog(
                      content: _question!.dropdownOptions,
                      ok: (val) {
                        _option = val;
                        _question!.answer = _option!.option;
                        setState(() {});
                        widget.onAnswered(_question!);
                      },
                      initVal: _option,
                    );
                  });
            }
            else{
              Fluttertoast.showToast(msg: 'No fields available');
            }
          },
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
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal*50,
                        child: Text(
                          (_question!.question != null) ? _question!.question! : '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14
                          ),
                        ),
                      ),

                      Icon(
                        Icons.arrow_drop_down,
                        size: 17,
                        color: Colors.grey[600],
                      )
                    ],
                  ),

                  (widget.question!.dropdownOptions!.isNotEmpty && _option != null) ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          (_option != null) ? _option!.option! : '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ):Container()
                ],
              )
          ),
        ),
      );
    }catch(e){
      print(e.toString());
      return Container();
    }
  }

  Widget buildCheckBox(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal*40,
            padding: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              (_question!.question != null) ? _question!.question! : '',
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  _checkBoxOption = 1;
                  _question!.answer = 'Available';
                  widget.onAnswered(_question!);
                },
                child: Icon(
                  (_checkBoxOption == 1) ? Icons.check_box_outlined :Icons.check_box_outline_blank,
                  color: (_checkBoxOption == 1) ? Colors.green : Colors.grey,
                ),
              ),

              InkWell(
                onTap: (){
                  _checkBoxOption = 2;
                  _question!.answer = 'Satisfactory';
                  widget.onAnswered(_question!);
                },
                child: Icon(
                  (_checkBoxOption == 2) ? Icons.check_box_outlined :Icons.check_box_outline_blank,
                  color: (_checkBoxOption == 2) ? Colors.green : Colors.grey,
                ),
              ),

              InkWell(
                onTap: (){
                  _checkBoxOption = 3;
                  _question!.answer = 'NA';
                  widget.onAnswered(_question!);
                },
                child: Icon(
                  (_checkBoxOption == 3) ? Icons.check_box_outlined :Icons.check_box_outline_blank,
                  color: (_checkBoxOption == 3) ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  checkForAnswer(){
    if(widget.question != null){
      if(_question!.dropdownOptions!.isNotEmpty && _question!.type == 'Dropdown'){
        if(_question!.answer != null ){
          for(int i = 0; i < _question!.dropdownOptions!.length; i++){
            if(_question!.answer == _question!.dropdownOptions![i].option){
              _option = _question!.dropdownOptions![i];
            }
          }
        }
        else{
          _option = _question!.dropdownOptions![0];
          _question!.answer = _option!.option;
          Future.delayed(const Duration(milliseconds: 100), (){
            widget.onAnswered(_question!);
          });
        }
      }
      if(_question!.answer != null && _question!.type == 'Checkbox'){
        switch(_question!.answer){
          case "Available":
            _checkBoxOption = 1;
            break;
          case "Satisfactory":
            _checkBoxOption = 1;
            break;
          case "NA":
            _checkBoxOption = 1;
            break;
        }
      }
    }
  }
}


bool isDate(dynamic str) {
  try {
    DateTime.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

String? dateToString(DateTime t){
  try {
    String s = t.toString();
    return s;
  } catch (e) {
    return null;
  }
}

DateTime? stringToDate(String? t){
  try {
    DateTime s = DateTime.parse(t!);
    return s;
  } catch (e) {
    return null;
  }
}