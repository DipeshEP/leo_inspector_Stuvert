
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/certificate_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_company_certificate_list_page.dart';


class CertificateView extends StatefulWidget {
  final Certificate? certificate;

  const CertificateView({Key? key,required this.certificate}) : super(key: key);

  @override
  State<CertificateView> createState() => _CertificateViewState();
}
class _CertificateViewState extends State<CertificateView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.appDarkBlue,
        leadingWidth: 400,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 3, bottom: 3),
          child: SizedBox(
              height: 60,
              width: 400,
              child: Image.asset(
                "assets/icons/leo_logo.png",
                fit: BoxFit.fill,
              )),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: RotatedBox(
                quarterTurns: 2,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> const CompanyCertificatePage()));
                },
                  icon: Icon(Icons.double_arrow,
                    size: 30,
                    color: AppTheme.colors.logoColor,),),
              )

          )
        ],
      ),
      backgroundColor: AppTheme.colors.loginWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppTheme.colors.loginWhite,
                  // child: SfPdfViewer.asset('assets/pdf/gvr.pdf'),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                        border: NeumorphicBorder(
                            color: AppTheme.colors.appDarkBlue,
                            width: 3
                        ),
                        shadowLightColor: AppTheme.colors.white.withOpacity(.1),
                        color: AppTheme.colors.loginWhite,
                        shape: NeumorphicShape.convex,
                        depth: 15,
                        surfaceIntensity: .5,
                        boxShape: const NeumorphicBoxShape.circle(
                        )
                    ),
                    onPressed: (){
                      showDialog(context: context, builder:(_)=> AlertDialog(
                        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        backgroundColor: AppTheme.colors.appDarkBlue,

                        title: Column(
                          children: [
                            Text(
                              "Cert.No : ${widget.certificate!.certificateId!}",
                              style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 17),),
                            Text(
                                "Date of Issued : ${DateFormat().format(widget.certificate!.createdAt!)}",
                                style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 17)),
                            Text(
                                "Description : ${widget.certificate!.certificateRowData!}",
                                style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 17,)),

                          ],
                        ),
                        elevation: 2,

                      ));
                    },
                    child:Center(
                      child: SizedBox(

                        height: 55,
                        child:Image.asset("assets/images/Authentic_Badge.png"),
                      ),
                    ),
                  ),
                ),
                /*NeumorphicButton(
              style: NeumorphicStyle(
                  color: AppTheme.colors.loginWhite,
                  shape: NeumorphicShape.concave,
                  depth: 15,
                  surfaceIntensity: .5,
                  boxShape: NeumorphicBoxShape.circle()),
              onPressed: () {
                *//*if(boomFormkey.currentState!.validate()){
                  //**//*Navigator.push(context, MaterialPageRoute(builder: (context)=>InspectorProfilePage()));*//**//
                }
                null;*//*
              },
              child: Container(
                height: 55,
                child: Icon(
                  Icons.share,
                  color: AppTheme.colors.appDarkBlue,
                  size: 50,
                ),
              ),
            ),*/
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // NeumorphicButton(
                //   style: NeumorphicStyle(
                //       color: AppTheme.colors.loginWhite,
                //       shape: NeumorphicShape.concave,
                //       depth: 15,
                //       surfaceIntensity: .5,
                //       boxShape: NeumorphicBoxShape.circle()),
                //   onPressed: () {
                //     /*if(boomFormkey.currentState!.validate()){
                //   //*Navigator.push(context, MaterialPageRoute(builder: (context)=>InspectorProfilePage()));*//
                // }
                // null;*/
                //   },
                //   child: Container(
                //     height: 55,
                //     child:
                //     Icon(
                //       Icons.download,
                //       color: AppTheme.colors.appDarkBlue,
                //       size: 50,
                //     ),
                //   ),
                // ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                      color: AppTheme.colors.loginWhite,
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      surfaceIntensity: .5,
                      boxShape: const NeumorphicBoxShape.circle()),
                  onPressed: () {
                    /*if(boomFormkey.currentState!.validate()){
                  //*Navigator.push(context, MaterialPageRoute(builder: (context)=>InspectorProfilePage()));*//
                }
                null;*/
                  },
                  child: SizedBox(
                    height: 55,
                    child: Icon(
                      Icons.share,
                      color: AppTheme.colors.appDarkBlue,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
