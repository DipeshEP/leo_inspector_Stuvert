

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/admin_model.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/bloc/login/admin/admin_login_cubit.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';

import '../../../Services2/Repository/admin_repo.dart';
import '../../../data/constants.dart';
import '../../../data/login/admin/model.dart';
import 'custom_widgets/dialogs/info_dialog.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}


class _AdminLoginState extends State<AdminLogin> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isLoading,toggle,isEnabled;
  final AdminRepository adminRepository = AdminRepository();

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

/*
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
        child: BlocConsumer<AdminLoginCubit, AdminLoginState>(
          listener: (context, state) {
            if (state.isSuccess == true) {
              Fluttertoast.showToast(
                msg: "login Success",
                backgroundColor: Colors.redAccent.shade700,
                toastLength: Toast.LENGTH_LONG,
              );

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const AdminBottomNavigationBarPage()));
            } else if (state.isFailure == true) {
              Fluttertoast.showToast(
                msg: "loginFailed",
                backgroundColor: Colors.redAccent.shade700,
                toastLength: Toast.LENGTH_LONG,
              );
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.topCenter,
                child: CircularProgressIndicator(
                  value: 2,
                  color: AppTheme.colors.appDarkBlue,
                ),
              );
            }
            return TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await BlocProvider.of<AdminLoginCubit>(context)
                        .saveEmailAndPassword(_emailController.text.trim(),
                        _passwordController.text.trim());
                    // await getIt<AuthManager>().signInwithEmailandPassword(
                    //     email: _emailController.text,
                    //     password: _passwordController.text);

                    //
                  } else {}
                },
                child: Text(
                  "LOGIN",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.colors.black),
                ));
          },
        ),
      ),
    );
  }
*/

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
                                // BlocConsumer<AdminAuthenticationCubit,
                                //     AdminAuthenticationState>(
                                //   listener: (context, state) {
                                //     if (state is AdminAuthenticationSuccess) {
                                //       print("eeee");
                                //       Navigator.pushReplacement(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               const AdminHomePage(),
                                //         ),
                                //       );
                                //     } else if (state
                                //         is AdminAuthenticationError) {
                                //       Fluttertoast.showToast(
                                //         msg: Strings.loginFailed,
                                //         backgroundColor:
                                //             AppTheme.colors.loginWhite,
                                //         toastLength: Toast.LENGTH_LONG,
                                //       );
                                //     } else {}
                                //   },
                                //   builder: (context, state) {
                                //     if (state is AdminAuthenticationLoading) {
                                //       return const CircularProgressIndicator(
                                //           color: Colors.blue);
                                //     } else {
                                //       return NeumorphicButton(
                                //           style: NeumorphicStyle(
                                //               shape: NeumorphicShape.concave,
                                //               color: AppTheme.colors.loginWhite,
                                //               surfaceIntensity: .5,
                                //               depth: 20,
                                //               intensity: 5,
                                //               shadowLightColor:
                                //                   AppTheme.colors.white,
                                //               border: const NeumorphicBorder(
                                //                   // color: Color(0XFF07649F)
                                //                   ),
                                //               boxShape:
                                //                   NeumorphicBoxShape.roundRect(
                                //                       BorderRadius.circular(20))),
                                //           child: Container(
                                //             height: 40,
                                //             width: 130,
                                //             decoration: BoxDecoration(
                                //                 borderRadius:
                                //                     BorderRadius.circular(10)),
                                //             child: TextButton(
                                //               onPressed: () {
                                //                 if (formKey.currentState!
                                //                     .validate()) ;
                                //                 String email =
                                //                     _emailController.text.trim();
                                //                 String password =
                                //                     _passwordController.text
                                //                         .trim();
                                //                 BlocProvider.of<
                                //                             AdminAuthenticationCubit>(
                                //                         context)
                                //                     .loginwithEmailPassword(
                                //                         email, password);
                                //               },
                                //               child: Text(
                                //                 "LOGIN",
                                //                 style: GoogleFonts.inter(
                                //                     fontSize: 20,
                                //                     fontWeight: FontWeight.w800,
                                //                     color: AppTheme.colors.black),
                                //               ),
                                //             ),
                                //           ));
                                //     }
                                //   },
                                // ),
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
    try{

      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await adminRepository.loginAdmin(
          _emailController.text,_passwordController.text
      );

      if(response != null){
        if(response.statusCode == 200 || response.statusCode == 201 ){
          AdminLoginModel loginResponseModel = AdminLoginModel.fromJson(response.data);
          await adminRepository.storeAdminLoginResponse(loginResponseModel);
          await adminRepository.storeUserToken(loginResponseModel.jwtAccessToken!);
          await adminRepository.setAdminLoggedIn(true);

          Response? response2 = await adminRepository.getAdminDetails();
          if(response2 != null){
            if(response2.statusCode == 200 || response2.statusCode == 201 ){
              AdminModel adminModel = AdminModel.fromJson(response2.data);
              await adminRepository.storeAdminDetails(adminModel.admin!);
            }
          }

          Response? response3 = await adminRepository.getOneCompany(loginResponseModel.userId!);
          if(response3 != null){
            if(response3.statusCode == 200 || response3.statusCode == 201 ){

              CompanyListModel companyListModel = CompanyListModel.fromJson(response3.data);
              //CompanyModel companyModel = CompanyModel.fromJson(response3.data);
              await adminRepository.storeCompanyDetails(companyListModel.companies![0]);
            }
          }

          Fluttertoast.showToast(msg: 'Success');

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => const AdminBottomNavigationBarPage()),
                  (Route<dynamic> route) => false);
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
      }
      else{
        Fluttertoast.showToast(msg: 'Error');
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
