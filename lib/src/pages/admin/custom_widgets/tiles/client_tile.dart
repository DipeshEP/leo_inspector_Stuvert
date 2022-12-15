import 'package:flutter/material.dart';

import '../../../../../Model/client_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';

class ClientListTile extends StatelessWidget {

  final Client? client;
  final Function() onPressed;

  const ClientListTile({Key? key,required this.onPressed,required this.client})
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
              (client!.name != null) ?
              'Company Name:${client!.name!}' : 'Company Name: '
          ),
          subtitle: Text(
              (client!.cmpId != null) ?
              'Company Id:${client!.cmpId!}' : 'Company Id: '),
        ),
      ),
    );
  }
}
