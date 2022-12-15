import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../Model/inspector_model.dart';
import '../../../../../Model/inspector_model2.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../../appcolors/colors.dart';

class CertificateListTile extends StatelessWidget {

  final Inspector? inspector;
  final Function() onPressed;

  const CertificateListTile({Key? key,required this.onPressed,required this.inspector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding:
      const EdgeInsets.only(left: 5.0, right: 5, top: 3),
      child: Card(
          elevation: 1,
          color: AppTheme.colors.white,
          child: ListTile(
            onTap: () {
              onPressed();
            },
            focusColor: AppTheme.colors.appBlue,
            title: Column(
              children: [
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Certficate No       :  ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        (inspector!.cmpId != null) ? inspector!.cmpId! : '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Center(
                      child: Text(
                        "Description           :  ",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.colors.black),
                      ),
                    ),
                    Center(
                      child: Text(
                        (inspector!.cmpId != null) ? inspector!.cmpId! : '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Center(
                  child: Text(
                    "Date of Issue        :  ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.colors.black),
                  ),
                ),
                Center(
                  child: Text(
                    (inspector!.updatedAt != null) ? DateFormat('dd/MM/yyyy').format(inspector!.updatedAt!) : 'NA',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.colors.black),
                  ),
                ),
              ],
            ),
            trailing:
            NeumorphicButton(
              style: NeumorphicStyle(
                  shadowLightColor: AppTheme.colors.blue,
                  color: AppTheme.colors.green,
                  shape: NeumorphicShape.convex,
                  depth: 0,
                  surfaceIntensity: 0,
                  boxShape: const NeumorphicBoxShape.circle()),
              child: const SizedBox(
                height:0.5,
                width: 0.5,
              ),
            ),
            selectedColor: AppTheme.colors.shadowWhite,
          )),
      //   );
      // }),
    );
  }
}
