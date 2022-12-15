import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../Model/inspector_model2.dart';

import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';

class RequestListTile extends StatelessWidget {

  final Inspector? inspector;
  final Function() onPressed;

  const RequestListTile({Key? key,required this.onPressed,required this.inspector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 23),
      child: Card(
        child: ListTile(
          onTap: (){
            onPressed();
          },
          title: Text(
              (inspector!.name != null) ?
              'Company Name:${inspector!.name!}' : 'Company Name: '
          ),
          subtitle: Text(
              (inspector!.createdAt != null) ?
              'Date of Inspection :${DateFormat('dd/MM/yyyy').format(inspector!.createdAt!)}' : 'Date of Inspection : '),
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0XFFD9D9D9),
          ),
        ),
      ),
    );
  }
}
