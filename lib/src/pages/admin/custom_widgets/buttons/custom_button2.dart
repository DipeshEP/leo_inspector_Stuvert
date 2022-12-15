import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../Services2/size_config.dart';

class CustomButton2 extends StatelessWidget {

  final Function() onPressed ;
  final String title ;
  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final double? width;
  final String? img;

  // ignore: use_key_in_widget_constructors
  const CustomButton2({
    required this.backgroundColor,
    required this.borderColor,
    required this.title,
    required this.titleColor,
    required this.onPressed,
    this.width,this.img
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
            color: backgroundColor
        ),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (img != null)?
            Padding(
              padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal*3),
              child: Container(
                width: SizeConfig.blockSizeHorizontal*6,
                height: SizeConfig.blockSizeHorizontal*6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img!),
                    fit: BoxFit.contain
                  )
                ),
              ),
            ):Container(),

            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: titleColor,
              ),
            ),
          ],
        )
      ),
    );  }
}