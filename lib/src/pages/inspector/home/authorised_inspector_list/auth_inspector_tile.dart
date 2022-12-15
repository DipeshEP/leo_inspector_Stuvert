import 'package:flutter/material.dart';

import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../../../Model/inspector_model2.dart';

class AuthInspectorListTile extends StatelessWidget {

  final Inspector? inspector;
  final Function() onPressed;
  final bool isSelected;

  const AuthInspectorListTile({Key? key,required this.isSelected,required this.onPressed,required this.inspector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [

        const SizedBox(
          height: 10,
        ),

        InkWell(
          onTap: (){
            onPressed();
          },
          child: Container(
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!,
                  spreadRadius: 2,
                  blurRadius: 2
                )
              ],
              image: DecorationImage(
                image: NetworkImage( (inspector!.profileImageUrl != null) ?  inspector!.profileImageUrl! : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg' )
              )
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: (isSelected) ? Colors.green.withOpacity(0.6) : Colors.transparent,
              size: 50,
            ),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        Text(
          (inspector!.name != null) ? inspector!.name!.toUpperCase() : '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),
        ),

        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
