
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.colors.loginWhite,
        appBar:AppBar(
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
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: RotatedBox(
              quarterTurns: 2,
              child: IconButton(onPressed: (){
                // Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomePage()));
              },
                icon: Icon(Icons.double_arrow,
                  size: 30,
                  color: AppTheme.colors.logoColor,),),
            ))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height:50,
              ),
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const DemoRequest()));
                },
                child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      color: AppTheme.colors.loginWhite,
                      surfaceIntensity: .5,
                      depth: 20,
                      intensity: 5,
                      shadowLightColor: AppTheme.colors.white,
                      border: const NeumorphicBorder(
                        //  color: Color(0XFF07649F)
                      ),
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 10),
                          child: SizedBox(
                              height: 100,
                              width:146,
                              child:
                              // Icon(Icons.ac_unit)
                            Image.asset("assets/icons/demo_icon.png"),
                          ),
                        ),
                        Text(
                          "REQUEST DEMO",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppTheme.colors.appDarkBlue),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: (){
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const DemoPlay()));
                },
                child: Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      color: AppTheme.colors.loginWhite,
                      surfaceIntensity: .5,
                      depth: 20,
                      intensity: 5,
                      shadowLightColor: AppTheme.colors.white,
                      border: const NeumorphicBorder(
                        //  color: Color(0XFF07649F)
                      ),
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2,bottom: 10),
                          child: SizedBox(
                            height: 100,
                            width: 146,

                            child:
                            // Icon(Icons.accessibility),),
                          Image.asset("assets/icons/demo_icon.png") ,),
                        ),
                        Text(
                          "DEMO",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: AppTheme.colors.appDarkBlue),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),],),
        ),
      ),
    );
  }
}
