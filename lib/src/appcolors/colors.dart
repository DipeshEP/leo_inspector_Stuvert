
import 'package:flutter/material.dart';
import 'package:leo_inspector/src/appcolors/appcolors.dart';

class AppTheme{
  static final colors=AppColor();
  static ThemeData define(){
    return ThemeData(
        primaryColor: const Color(0XFF055E98),
        focusColor: const Color(0XFFFFFFFF),
        scaffoldBackgroundColor: const Color(0XFF075E94)
    );
  }
}