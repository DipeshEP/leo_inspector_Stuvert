import 'package:flutter/material.dart';
import '../../../../../Model/inspector_model2.dart';

import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';

class InspectorListTile extends StatelessWidget {

  final Inspector? inspector;
  final Function() onPressed;

  const InspectorListTile({Key? key,required this.onPressed,required this.inspector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10),
      child: Card(
        child: ListTile(
          onTap: (){
            onPressed();
          },
          title: Text(
              (inspector!.name != null) ?
              'Name  : ${inspector!.name!}' : 'Name  : '
          ),
          subtitle: Text(
              (inspector!.empId != null) ?
              'Emp ID:${inspector!.empId!}' : 'Emp ID: '),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Color(0XFFD9D9D9),
            backgroundImage: (inspector!.profileImageUrl != null) ? NetworkImage(inspector!.profileImageUrl!) : null,
          ),
        ),
      ),
    );
  }
}
