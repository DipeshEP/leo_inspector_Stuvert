

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/home_page.dart';
import 'package:leo_inspector/src/pages/inspector/home/authorised_inspector_list/auth_inspector_tile.dart';
import '../../../../../Model/inspector_model2.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Services2/Repository/pdf_repo.dart';
import '../../../../../data/constants.dart';
import '../../../admin/custom_widgets/dialogs/info_dialog.dart';
import 'success_screen.dart';

class SelectAuthInspector extends StatefulWidget {

  final File file;
  //make sure to append both question list before sending here
  final QuestionOption? questionOption;
  final String? clientId;
  final String? companyId;
  final Inspector? inspector;
  final String? certificateNo;
  final List<Question> filledForm;
  final List<Question> checkBoxForm;

  const SelectAuthInspector({
    Key? key,
    required this.file,
    required this.inspector,
    required this.questionOption,
    required this.companyId,
    required this.clientId,
    required this.certificateNo,
    required this.filledForm,
    required this.checkBoxForm
  }) : super(key: key);

  @override
  State<SelectAuthInspector> createState() => _SelectAuthInspectorState();
}

class _SelectAuthInspectorState extends State<SelectAuthInspector> {

  late bool isLoading;
  late List<Inspector> _inspectList;
  final InspectorRepository inspectorRepository = InspectorRepository();
  final PdfRepository pdfRepository = PdfRepository();

  Inspector? _selectedInspector;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _inspectList = [];
    getInspectorList();
  }

  getInspectorList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await inspectorRepository.getInspectorList('InspectorSignetory',widget.companyId);
      _inspectList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        InspectorListModel inspectorModel = inspectorListModelFromJson(s1);

        print(widget.inspector!.inspectorType);
        if(widget.inspector!.inspectorType == 'InspectorSignetory'){
          _inspectList.add(widget.inspector!);
        }
        List<Inspector> insList = [];
        insList = inspectorModel.inspectors!;
        for(int i = 0; i < insList.length; i++){
          if(insList[i].inspectorId == widget.inspector!.inspectorId
              && widget.inspector!.inspectorType == 'InspectorSignetory'){
            insList.removeAt(i);
          }
        }
        _inspectList = _inspectList + insList;

        if(widget.inspector!.inspectorType == 'InspectorSignetory'){
          _selectedInspector = widget.inspector!;
        }
        else if(_inspectList.isNotEmpty){
          _selectedInspector = _inspectList[0];
        }
      }
      else if((response.statusCode == 303 || response.statusCode == 401 )){
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
      isLoading = false;
      setState(() {});
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refresh() async {
    getInspectorList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0XFFECE9E6),
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
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: RefreshIndicator(
                onRefresh: refresh,
                child: Stack(
                  children: [
                    ListView(),

                    SingleChildScrollView(
                      child: Stack(
                        children: [

                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:const  EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height/1.15,
                              width: MediaQuery.of(context).size.width,
                              decoration:const  BoxDecoration(
                                //color: Colors.grey
                                color: Color(0XFFECE9E6),
                              ),
                              padding: const EdgeInsets.only(top: 10),
                              child: GridView.builder(
                                  itemCount: _inspectList.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1.3),
                                  itemBuilder: (context,index){
                                    return (_inspectList[index] != null ) ?
                                    AuthInspectorListTile(
                                        isSelected: ((_selectedInspector != null) && (_selectedInspector!.inspectorId == _inspectList[index].inspectorId)),
                                        onPressed: (){
                                          _selectedInspector = _inspectList[index];
                                          setState(() {});
                                        },
                                        inspector: _inspectList[index]
                                    ): Container();
                                  }
                              ),
                            ),
                          ),
                          const  SizedBox(
                            height: 20,
                          ),
                          Positioned(
                            bottom: 10,
                            left: SizeConfig.blockSizeHorizontal*38,
                            child: NeumorphicButton(
                              style: NeumorphicStyle(
                                  //shadowLightColor: Color(0XFFECE9E6),
                                  color: AppTheme.colors.loginWhite,
                                  shape: NeumorphicShape.concave,
                                  depth: 15,
                                  surfaceIntensity: .5,
                                  boxShape: const NeumorphicBoxShape.circle(
                                  )
                              ),
                              onPressed: (){
                                validate();
                              },
                              child:SizedBox(
                                height: 55,
                                child: Icon(Icons.send,color: AppTheme.colors.appDarkBlue,size: 50,),
                              ),
                            ),
                          ),

                        ],
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
                )
            ),
          ),
        ),
      ),
    );
  }

  validate() async{
    try{

      /// need to check if current inspector can authorise
      if(_selectedInspector != null){
        uploadCertificate();
      }
      else{
        Fluttertoast.showToast(msg: 'Please select an authorising inspector!');
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  uploadCertificate() async{
    try{

      print('---------- SelectAuthInspector -------------');
      print(widget.file.path);

      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      String inspectionStatus = "", details = "", certificateRowData = "";

      if(_selectedInspector!.inspectorId == widget.inspector!.inspectorId && widget.inspector!.inspectorType == 'InspectorSignetory'){
        inspectionStatus = "Approved";
      }
      else{
        inspectionStatus = "Pending";
      }

      Map<String,dynamic> certificateDetails = {
        "questionOption" : widget.questionOption!.toJson(),
        "certificateNo" : widget.certificateNo,
        "surveyor" : widget.inspector!.toJson(),
        "authorised" : _selectedInspector!.toJson()
      };

      certificateRowData = json.encode(certificateDetails);

      Response? response = await inspectorRepository.uploadCertificate(
        'v1',certificateRowData,widget.file,widget.inspector!.inspectorId,
          widget.companyId,widget.clientId,details,
          _selectedInspector!.inspectorId,inspectionStatus
      );

      if(response!.statusCode == 200 || response.statusCode == 201 ){

        Fluttertoast.showToast(msg: 'Success');
        String msg = "";
        if(_selectedInspector!.inspectorId == widget.inspector!.inspectorId){
          msg = "SUCCESSFULLY SENT TO YOUR ADMIN";
        }
        else{
          msg = "SUCCESSFULLY SENT TO AUTHORISED SIGNATORY";
        }

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SuccessScreen(
                  message: msg, isSuccess: true,
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
