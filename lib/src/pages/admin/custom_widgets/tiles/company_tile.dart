import 'package:flutter/material.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Model/inspector_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';

class CompanyListTile extends StatelessWidget {

  final Company? company;
  final Function() onPressed;

  const CompanyListTile({Key? key,required this.onPressed,required this.company})
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
              (company!.name != null) ?
              'Company Name:${company!.name!}' : 'Company Name: '
          ),
          subtitle: Text(
              (company!.companyId != null) ?
              'Company ID:${company!.companyId!}' : 'Company ID: '),
          leading: const CircleAvatar(
            radius: 20,
            backgroundColor: Color(0XFFD9D9D9),
          ),
        ),
      ),
    );
  }
}
