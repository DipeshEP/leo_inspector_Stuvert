import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/bloc/login/client/client_login_cubit.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';


class ClientLoginPage extends StatefulWidget {
  const ClientLoginPage({Key? key}) : super(key: key);

  @override
  State<ClientLoginPage> createState() => _ClientLoginPageState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();
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
      child: BlocConsumer<ClientLoginCubit, ClientLoginState>(
        listener: (context, state) {
          if (state.isSuccess == true) {
            Fluttertoast.showToast(
              msg: "login Success",
              backgroundColor: Colors.redAccent.shade700,
              toastLength: Toast.LENGTH_LONG,
            );

            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const ClientHomePage()));
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
                if (formKey.currentState!.validate()) {
                  await BlocProvider.of<ClientLoginCubit>(context)
                      .saveEmailAndPassword(_emailController.text.trim(),
                          _passwordController.text.trim());

                  // await getIt<ClientLoginManager>().signInwithEmailandPassword(email: _emailController.text, password: _passwordController.text);

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

Widget userNameField() {
  return TextFormField(
    textInputAction: TextInputAction.next,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter Your Username';
      } else {
        return null;
      }
    },
    controller: _emailController,
    keyboardType: TextInputType.text,
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

Widget passwordField() {
  return TextFormField(
    textInputAction: TextInputAction.done,
    controller: _passwordController,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Enter Your Password';
      } else {
        return null;
      }
    },
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

// Widget loginButton(context) {
//   return Neumorphic(
//     style: NeumorphicStyle(
//       depth: 15,
//       surfaceIntensity: .2,
//       intensity: 5,
//       shadowLightColor: AppTheme.colors.loginBlur.withOpacity(.3),
//       lightSource: LightSource.topLeft,
//       color: AppTheme.colors.white,
//     ),
//     child: Container(
//       height: 60,
//       width: 157,
//       decoration: BoxDecoration(
//           color: Colors.white70, borderRadius: BorderRadius.circular(10)),
//       child: TextButton(
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ClientHomePage()));
//             }
//           },
//           child: Text(
//             "LOGIN",
//             style: GoogleFonts.inter(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w800,
//                 color: AppTheme.colors.black),
//           )),
//     ),
//   );
// }

class _ClientLoginPageState extends State<ClientLoginPage> {
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
                    key: formKey,
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
                                // BlocConsumer<ClientAuthenticationCubit,
                                //     ClientAuthenticationState>(
                                //   listener: (context, state) {
                                //     if (state is ClientAuthenticationSuccess) {
                                //       Navigator.pushReplacement(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) =>
                                //               const ClientHomePage(),
                                //         ),
                                //       );
                                //     } else if (state
                                //         is ClientAuthenticationError) {
                                //       Fluttertoast.showToast(
                                //         msg: Strings.loginFailed,
                                //         backgroundColor:
                                //             AppTheme.colors.loginWhite,
                                //         toastLength: Toast.LENGTH_LONG,
                                //       );
                                //     } else {}
                                //   },
                                //   builder: (context, state) {
                                //     if (state is ClientAuthenticationLoading) {
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
                                //               shadowLightColor: AppTheme.colors.white,
                                //               border: const NeumorphicBorder(
                                //                 // color: Color(0XFF07649F)
                                //               ),
                                //               boxShape:
                                //               NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                                //           child: Container(
                                //             height: 40,
                                //             width: 137,
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
                                //                             ClientAuthenticationCubit>(
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
            ],
          ),
        ),
      ),
    );
  }
}
