import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_login.dart';
import 'package:leo_inspector/src/pages/client/client_login_page.dart';
import 'package:leo_inspector/src/pages/demo/demo_home.dart';
import 'package:leo_inspector/src/pages/guest/guest_login.dart';
import 'package:leo_inspector/src/pages/inspector/inspector_login_page.dart';

import 'inspector/qr/inspector_qr_code.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
Widget adminLogin(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: 126,
          width: 146,
          child: Image.asset('assets/icons/admin_logo_icon.png',)
      ),
      //  const SizedBox(height: 5,),
      Text("ADMIN LOGIN",style: GoogleFonts.inter(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.colors.white),)
    ],
  );
}
Widget inspectorLogin(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: 126,
          width: 146,
          child: Image.asset('assets/icons/inspectors_icon.png')
      ),
      // const SizedBox(height: 5,),
      Text("INSPECTOR LOGIN",style: GoogleFonts.inter(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.colors.white),)
    ],
  );
}
Widget clientLogin(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: 126,
          width: 146,
          child: Image.asset('assets/icons/client_icon.png')
      ),
      // const SizedBox(height: 5,),
      Text("CLIENT LOGIN",style: GoogleFonts.inter(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.colors.white),)
    ],
  );
}
GuestUser(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          height: 126,
          width: 146,
          child:
          Image.asset('assets/icons/guest_icon.png')
      ),
      // const SizedBox(height: 5,),
      Text("GUEST USER",style: GoogleFonts.inter(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.colors.white),)
    ],
  );

}
Demo(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 2,bottom: 10),
        child: SizedBox(
            height: 100,
            width: 146,
            child:
          Image.asset('assets/icons/demo_icon.png')
        ),
      ),
      SizedBox(

      ),
      // const SizedBox(height: 5,),
      Text("DEMO",style: GoogleFonts.inter(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: AppTheme.colors.white),)
    ],
  );


}
class _HomePageState extends State<HomePage> {
  // Future<void> secureScreen() async {
  //   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // }
  @override
  void initState() {
    // secureScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.colors.appDarkBlue,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 60,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminLogin()));
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: AppTheme.colors.appDarkBlue,
                        surfaceIntensity: .5,
                        depth: 20,
                        intensity: 5,
                        shadowLightColor: AppTheme.colors.containerShadow,
                        border: const NeumorphicBorder(
                          //  color: Color(0XFF07649F)
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                    ),
                    curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                      height: 180,
                      width: 260,
                      color: AppTheme.colors.appDarkBlue,
                      child: adminLogin(),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const InspectorLogin()));
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: AppTheme.colors.appDarkBlue,
                        surfaceIntensity: .5,
                        depth: 20,
                        intensity: 5,
                        shadowLightColor: const Color(0XFF0A8EE1),
                        border: const NeumorphicBorder(
                          //  color: Color(0XFF07649F)
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                    ),
                    curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                      height: 180,
                      width: 260,
                      color: AppTheme.colors.appDarkBlue,
                      child: inspectorLogin(),
                    ),
                  ),
                ),
                const SizedBox(height: 56,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ClientLoginPage()));
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: AppTheme.colors.appDarkBlue,
                        surfaceIntensity: .5,
                        depth: 20,
                        intensity: 5,
                        shadowLightColor: const Color(0XFF0A8EE1),
                        border: const NeumorphicBorder(
                          //  color: Color(0XFF07649F)
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                    ),
                    curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                      height: 180,
                      width: 260,
                      color: AppTheme.colors.appDarkBlue,
                      child: clientLogin(),
                    ),
                  ),
                ),
                const SizedBox(height: 56,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const GuestLogin()));
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: AppTheme.colors.appDarkBlue,
                        surfaceIntensity: .5,
                        depth: 20,
                        intensity: 5,
                        shadowLightColor: const Color(0XFF0A8EE1),
                        border: const NeumorphicBorder(
                          //  color: Color(0XFF07649F)
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                    ),
                    curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                      height: 180,
                      width: 260,
                      color: AppTheme.colors.appDarkBlue,
                      child: GuestUser(),
                    ),
                  ),
                ),
                const SizedBox(height: 56,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const DemoHomePage()));
                  },
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        color: AppTheme.colors.appDarkBlue,
                        surfaceIntensity: .5,
                        depth: 20,
                        intensity: 5,
                        shadowLightColor: const Color(0XFF0A8EE1),
                        border: const NeumorphicBorder(
                          //  color: Color(0XFF07649F)
                        ),
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20))
                    ),
                    curve: Neumorphic.DEFAULT_CURVE,
                    child: Container(
                      height: 180,
                      width: 260,
                      color: AppTheme.colors.appDarkBlue,
                      child: Demo(),
                    ),
                  ),
                ),
                const SizedBox(height: 60,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
