

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/Services2/Repository/admin_repo.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';

import '../../inspector_bottom_navigation_bar.dart';

class SuccessScreen extends StatefulWidget {

  final String? message;
  final bool isSuccess;

  const SuccessScreen({Key? key,required this.message,required this.isSuccess}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const InspectorBottomNavigationPage()),
              (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppTheme.colors.appDarkBlue,
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
            child: Container(
              height: SizeConfig.blockSizeVertical*60,
              width: SizeConfig.blockSizeHorizontal*80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0XFFECE9E6),
              ),
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                      (widget.message != null) ? widget.message!.toUpperCase() : '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.blockSizeVertical*5,
                  ),

                  Icon(
                    (widget.isSuccess) ? Icons.check_circle_outline : Icons.cancel_outlined,
                    color: (widget.isSuccess) ? Colors.green : Colors.red,
                    size: SizeConfig.blockSizeHorizontal*50,
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
