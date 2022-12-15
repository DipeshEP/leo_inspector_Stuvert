

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/data/login/inspector/model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/inspector/inspector_bottom_navigation_bar.dart';
import '../../../../../Model/inspector_model2.dart';
import '../../../Model/inspector_login_response_model.dart';
import '../../../data/constants.dart';
import '../admin/custom_widgets/dialogs/info_dialog.dart';

class InspectorLogin extends StatefulWidget {
  const InspectorLogin({Key? key}) : super(key: key);

  @override
  State<InspectorLogin> createState() => _InspectorLoginState();
}


class _InspectorLoginState extends State<InspectorLogin> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isLoading,toggle,isEnabled;
  final InspectorRepository inspectorRepository = InspectorRepository();

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  late TextEditingController _emailController ;
  late TextEditingController _passwordController ;

  Widget userNameField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Username';
        } else {
          return null;
        }
      },
      textInputAction: TextInputAction.next,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          fillColor: AppTheme.colors.white,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.white)),
          border: const OutlineInputBorder(),
          labelText: "User Name",
          focusColor: AppTheme.colors.white,
          labelStyle: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400)),
    );
  }

  Widget loginButton(context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 15,
        surfaceIntensity: .2,
        intensity: 5,
        shadowLightColor: AppTheme.colors.loginBlur.withOpacity(.3),
        lightSource: LightSource.topLeft,
        color: AppTheme.colors.white,
      ),
      child: Container(
          height: 60,
          width: 157,
          decoration: BoxDecoration(
              color: Colors.white70, borderRadius: BorderRadius.circular(10)),
          child: TextButton(
              onPressed: () {
                validate();
               /* Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const InspectorBottomNavigationPage()));*/
              },
              child: Text(
                "LOGIN",
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.colors.black),
              ))
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Your Password';
        } else {
          return null;
        }
      },
      textInputAction: TextInputAction.done,
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: AppTheme.colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.colors.white)),
          border: const OutlineInputBorder(),
          labelText: "Password",
          focusColor: AppTheme.colors.white,
          labelStyle: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400)),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEnabled = true;
    isLoading = false;
    toggle = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppTheme.colors.appDarkBlue,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 25,
                child: SizedBox(
                  height: 40,
                  width: 115,
                  child: Image.asset(
                    "assets/icons/leo_logo.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 25,
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
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Container(
                            width: 313,
                            height: MediaQuery.of(context).size.height * 0.60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppTheme.colors.loginWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 28),
                                Text("  Login",
                                    style: GoogleFonts.inter(
                                      color: AppTheme.colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                    )),
                                const SizedBox(height: 52),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.5, right: 35.5),
                                  child: userNameField(),
                                ),
                                const SizedBox(height: 38),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 35.5, right: 35.5),
                                  child: passwordField(),
                                ),
                                const SizedBox(height: 45),
                                loginButton(context),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 61.5,
                        ),
                        const SizedBox(
                          height: 30,
                        )
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
        ),
      ),
    );
  }

  validate() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        loginApi();
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  loginApi() async{

      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await inspectorRepository.loginInspector(
          _emailController.text,_passwordController.text
      );

      if(response != null){
        if(response.statusCode == 200 || response.statusCode == 201 ){
          InspectorLoginModel loginResponseModel = InspectorLoginModel.fromJson(response.data);
          await inspectorRepository.storeInspectorLoginResponse(loginResponseModel);
          await inspectorRepository.storeUserToken(loginResponseModel.jwtAccessToken!);
          await inspectorRepository.setInspectorLoggedIn(true);


          Response? response3 = await inspectorRepository.getOneCompany(loginResponseModel.userId!);
          if(response3 != null){
            if(response3.statusCode == 200 || response3.statusCode == 201 ){

              var s1 = json.encode(response3.data);
              CompanyListModel companyModel =  companyModelFromJson(s1);
              await inspectorRepository.storeCompanyDetails(companyModel.companies![0]);
            }
          }

          Response? response2 = await inspectorRepository.getInspectorDetails();
          if(response2 != null){
            if(response2.statusCode == 200 || response2.statusCode == 201 ){
              //InspectorModel inspectorModel = InspectorModel.fromJson(response2.data);

              var s1 = json.encode(response2.data);
              //InspectorModel inspectorModel =  inspectorModelFromJson(s1);
              await inspectorRepository.storeInspectorDetails(s1);

              Inspector? inspector = await inspectorRepository.getInspectorDetailsLocal();
              print('2    inspector.inspector!.inspectorId ');
              print(inspector!.inspectorId);
            }
          }

          Fluttertoast.showToast(msg: 'Success');

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const InspectorBottomNavigationPage()),
                  (Route<dynamic> route) => false);
        }
        else if(response.statusCode == 400){
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
      }
      else{
        Fluttertoast.showToast(msg: 'Error');
      }

      setState(() {
        isLoading = false;
      });
      try{
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
