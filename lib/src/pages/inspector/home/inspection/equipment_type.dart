import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/custom%20widgets/select_type.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspection/fill_checklist.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../../../Model/inspector_model2.dart';


class EquipmentType extends StatefulWidget {

  final Client? client;
  final Company? company;
  final Inspector? authorisedInspector;
  final Inspector? surveyInspector;

  const EquipmentType({Key? key,required this.client,required this.company,required this.surveyInspector,required this.authorisedInspector}) : super(key: key);

  @override
  State<EquipmentType> createState() => _EquipmentTypeState();
}


class _EquipmentTypeState extends State<EquipmentType> {

  late Company? _company;
  late QuestionOption? _selectedType;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _company = widget.company;
    if(widget.company!.questionOption != null && widget.company!.questionOption!.isNotEmpty){
      _selectedType = _company!.questionOption![0];
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: 313,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0XFFECE9E6),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Text(
                            'Select the checklist from the dropdown list',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        
                        selectType(),
                        
                        const SizedBox(
                          height: 180,
                        ),
                        
                        NeumorphicButton(
                          style: NeumorphicStyle(
                              color: AppTheme.colors.loginWhite,
                              shape: NeumorphicShape.concave,
                              depth: 15,
                              surfaceIntensity: .5,
                              boxShape: const NeumorphicBoxShape.circle()),
                          onPressed: () {
                            if(_selectedType != null){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FillCheckListPage(
                                        questionOption: _selectedType,
                                        companyId: widget.company!.companyId!,
                                        clientId: widget.client!.clientId,
                                        isToBeAuthorised: false,
                                        authorisedInspector: widget.authorisedInspector,
                                        surveyInspector: widget.surveyInspector,
                                      )));
                            }
                            else{
                              Fluttertoast.showToast(msg: 'Select checklist!');
                            }
                          },
                          child: SizedBox(
                            height: 55,
                            child: Icon(
                              Icons.check_circle_outline,
                              color: AppTheme.colors.appDarkBlue,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectType() {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return SelectTypeDialog(
                content: _company!.questionOption!,
                ok: (val) {
                  setState(() {
                    _selectedType = val;
                  });
                  print('_selectedType!.questionOptionId');
                  print(_selectedType!.questionOptionId);
                },
                initVal: _selectedType,
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5,left: SizeConfig.blockSizeHorizontal*5,right: SizeConfig.blockSizeHorizontal*5),
        child: Container(
          width: SizeConfig.screenWidth / 1.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!
              )
            ]
          ),
          child: Column(
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3,vertical: SizeConfig.blockSizeHorizontal * 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        // ignore: unnecessary_null_comparison
                        (_selectedType != null)
                            ? _selectedType!.equipmentType!
                            : 'Select Type',
                        style: const TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 17,
                            fontFamily: Constants.fontRegular),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey[400],
                      size: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeHorizontal * 2,
              ),
              Divider(
                thickness: 2,
                height: 2,
                color: Colors.grey[300],
              )
            ],
          ),
        ),
      ),
    );
  }

}
