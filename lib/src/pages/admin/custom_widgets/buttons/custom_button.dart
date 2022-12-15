import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';

class CustomButton extends StatelessWidget {

  final Function() onPressed ;
  final String title ;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final double? fontSize;
  final double? borderRadius;
  final double? width;

  // ignore: use_key_in_widget_constructors
  const CustomButton({
    required this.backgroundColor,
    required this.borderColor,
    required this.title,
    required this.titleColor,
    required this.onPressed,
    this.fontSize,
    this.borderRadius,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        height: SizeConfig.blockSizeHorizontal*12,
        width: (width != null) ? width : SizeConfig.blockSizeHorizontal*25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius != null ? borderRadius! : 5),
            border: Border.all(color: borderColor),
            color: backgroundColor
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize != null ? fontSize! : 14,
              fontFamily: Constants.fontSemiBold,
              color: titleColor,
            ),
          ),
        ),
      ),
    );  }
}