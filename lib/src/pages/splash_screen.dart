import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leo_inspector/Services2/Repository/admin_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/home_page.dart';

import '../../Services2/Repository/inspector_repo.dart';
import 'admin/admin_bottom_navigation_bar.dart';
import 'inspector/inspector_bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AdminRepository adminRepository = AdminRepository();
  InspectorRepository inspectorRepository = InspectorRepository();

  @override
  void initState() {
    super.initState();

    selectPage();

    /*Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage()          )
        )
    );*/
  }

  selectPage() async {
    Future.delayed(const Duration(seconds: 4),() async{
      // if logged in
      // move to home screen
      bool isAdminLogged,isInspectorLogged;
      isAdminLogged = await adminRepository.isAdminLoggedIn();
      isInspectorLogged = await inspectorRepository.isInspectorLoggedIn();

      if(isAdminLogged){
        // admin logged in
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const AdminBottomNavigationBarPage()),
                (Route<dynamic> route) => false);
      }
      else if(isInspectorLogged){
        // inspector logged in
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const InspectorBottomNavigationPage()),
                (Route<dynamic> route) => false);
      }
      else{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()),
                (Route<dynamic> route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppTheme.colors.appDarkBlue,
          body: Center(child: Image.asset('assets/images/leo_logo.gif'))),
    );
  }
}
