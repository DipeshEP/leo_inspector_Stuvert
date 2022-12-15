import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/question_ui.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Services2/size_config.dart';
import 'filled_checklist.dart';
import '../../../../../Model/inspector_model2.dart';


class FillCheckListPage extends StatefulWidget {

  final QuestionOption? questionOption;
  final String? clientId;
  final String? companyId;

  final bool isToBeAuthorised;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  const FillCheckListPage({Key? key,
    required this.questionOption,
    required this.companyId,
    required this.clientId,
    required this.surveyInspector,
    required this.authorisedInspector,
    required this.isToBeAuthorised
  }) : super(key: key);

  @override
  _FillCheckListPageState createState() => _FillCheckListPageState();
}

class _FillCheckListPageState extends State<FillCheckListPage> {

  late List<Question> _questionsList;
  late List<Question> _checkBoxQuestionsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionsList = [];
    _checkBoxQuestionsList = [];
    getCheckBoxQuestions();
  }

  getCheckBoxQuestions(){
    for(int i = 0; i< widget.questionOption!.question!.length; i++){
      if(widget.questionOption!.question![i].type == 'Checkbox'){
        _checkBoxQuestionsList.add(widget.questionOption!.question![i]);
      }
      else{
        _questionsList.add(widget.questionOption!.question![i]);
      }
    }
    setState(() {

    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: unFocus,
      child: Scaffold(
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

                            (_questionsList != null && _questionsList.isNotEmpty)?
                            ListView.builder(
                                itemCount: _questionsList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context ,int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*2 ),
                                    child: QuestionUI(
                                      question: _questionsList[index],
                                      onAnswered: (val){
                                        _questionsList[index] = val;
                                        setState(() {});
                                      },
                                    ),
                                  );
                                }) : Container(),

                            const SizedBox(
                              height: 20,
                            ),

                          /*  (_checkBoxQuestionsList != null && _checkBoxQuestionsList.isNotEmpty)?
                                buildCheckFormField() : Container(),*/

                            NeumorphicButton(
                              style: NeumorphicStyle(
                                  color: AppTheme.colors.loginWhite,
                                  shape: NeumorphicShape.concave,
                                  depth: 15,
                                  surfaceIntensity: .5,
                                  boxShape: const NeumorphicBoxShape.circle()),
                              onPressed: () {
                                validateForm();
                              },
                              child: SizedBox(
                                height: 55,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: AppTheme.colors.appDarkBlue,
                                  size: 50,
                                ),
                              ),
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
        ),
      ),
    );
  }

  Widget buildCheckFormField(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal*40,
              ),

              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal*13,
                      child: const Text(
                        'Available',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: SizeConfig.blockSizeHorizontal*.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal*13,
                      child: const Text(
                        'Satisfactory',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                    ),
                    VerticalDivider(
                      width: SizeConfig.blockSizeHorizontal*.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal*13,
                      child: const Text(
                        'NA',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),

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
                child: QuestionUI(
                  question: _questionsList[index],
                  onAnswered: (val){
                    _questionsList[index] = val;
                    setState(() {});
                  },
                ),
              );
            }),

        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  validateForm() async{
    try{

      if(_questionsList.isNotEmpty || _checkBoxQuestionsList.isNotEmpty){

        bool isValid = true;
        for(int i = 0; i< _questionsList.length; i++){
          if(_questionsList[i].answer == null && _questionsList[i].type != 'Dropdown' && _questionsList[i].dropdownOptions!.isNotEmpty ){
            isValid = false;
          }
        }
        for(int i = 0; i< _checkBoxQuestionsList.length; i++){
          if(_checkBoxQuestionsList[i].answer == null){
            isValid = false;
          }
        }

        if(isValid){
          //proceed to next page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FilledCheckListPage(
                    filledForm: _questionsList,
                    checkBoxForm: _checkBoxQuestionsList,
                    companyId: widget.companyId,
                    clientId: widget.clientId,
                    questionOption: widget.questionOption,
                    isToBeAuthorised: widget.isToBeAuthorised,
                    authorisedInspector: widget.authorisedInspector,
                    surveyInspector: widget.surveyInspector,
                  )));
        }
        else{
          Fluttertoast.showToast(msg: 'Please fill out all fields');
        }
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}


