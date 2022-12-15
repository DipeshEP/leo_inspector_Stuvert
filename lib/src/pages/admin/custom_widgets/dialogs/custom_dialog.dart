// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../buttons/custom_button.dart';

class CustomDialog extends StatelessWidget {

  final Function() yes;
  final Function() no;
  final Function()? onDismissed;
  final String title, subtitle, yesTitle , noTitle;

  CustomDialog({Key? key,
    required this.yes,
    required this.no,
    required this.title,
    required this.subtitle,
    required this.noTitle,
    required this.yesTitle,
    this.onDismissed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [

                  Padding(
                    padding:  EdgeInsets.only(top: SizeConfig.blockSizeHorizontal*5),
                    child: Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Constants.primaryColor,
                          fontFamily: Constants.fontSemiBold),
                    ),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: SizeConfig.blockSizeHorizontal*4),
                    child: Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,

                      style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Color.fromRGBO(34, 34, 34, 1),
                          fontFamily: Constants.fontMedium),
                    ),
                  ),


                  SizedBox(height: SizeConfig.blockSizeVertical*2),

                  buttonRow(context),

                  SizedBox(height: SizeConfig.blockSizeVertical*1),

                ],
              ),
            ),

            Positioned(
              top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close,color: Color.fromRGBO(175, 175, 175, 1),),
                  onPressed: (){
                    Navigator.pop(context,false);
                    onDismissed!();
                  },
                ))
          ],
        ),
      ),
    );
  }

  Widget buttonRow(BuildContext context){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          title: noTitle,
          borderColor: Constants.primaryColor,
          backgroundColor: Colors.white,
          titleColor: Colors.black,
          onPressed: (){
            no();
          },
        ),

        SizedBox(width: SizeConfig.blockSizeHorizontal*8),

        CustomButton(
          title: yesTitle,
          borderColor: Constants.primaryColor,
          backgroundColor: Constants.primaryColor,
          titleColor: Colors.white,
          onPressed: (){
            yes();
          },
        )
      ],
    );
  }
}
