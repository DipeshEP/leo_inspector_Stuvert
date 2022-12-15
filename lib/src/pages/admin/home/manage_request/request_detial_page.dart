import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Model/request_model.dart';

class RequestDetailPage extends StatefulWidget {


  final ManegeRequest? request;

  const RequestDetailPage({Key? key,required this.request}) : super(key: key);

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    // push(context,MaterialPageRoute(builder: (context)=> const ManageRequest()));
                  },
                    icon: Icon(Icons.double_arrow,
                      size: 30,
                      color: AppTheme.colors.logoColor,),),
                )

            )
          ],
        ),
        backgroundColor: AppTheme.colors.appDarkBlue,
        body: Center(
          child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height*0.70,
                  width: MediaQuery.of(context).size.width*0.85,
                  decoration: BoxDecoration(
                    color: AppTheme.colors.loginWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:Column(

                    children: [
                      const SizedBox(height: 25),
                      Center(
                        child: Text("REQUEST",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Company Name    :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text(
                                (widget.request!.company != null && widget.request!.company!.name != null) ? widget.request!.company!.name! : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Inspection\nLocation",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("              :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text(
                                (widget.request!.inspectionLocation != null) ? widget.request!.inspectionLocation! : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Type of\nInspection",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("               :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text("   Manual",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Date of\nInspection",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("                :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text(
                                (widget.request!.inspectionDate != null) ? DateFormat('dd-MM-yyyy').format(widget.request!.inspectionDate!) : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Contact Number",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("      :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text(
                                (widget.request!.phone != null) ? widget.request!.phone! : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height:20,),
                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Name of\nContact Person",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("        :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text(
                                (widget.request!.company != null && widget.request!.company!.contactPerson != null) ? widget.request!.company!.contactPerson! : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left:30),
                        child: Row(
                          children: [
                            Center(
                              child: Text("Company\nAddress",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                            Center(
                              child: Text("                   :",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),

                            Center(
                              child: Text(
                                (widget.request!.company != null && widget.request!.company!.address != null) ? widget.request!.company!.address! : '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Positioned(
                bottom:50,
                left: 120,
                child: NeumorphicButton(
                  style: NeumorphicStyle(
                      color: AppTheme.colors.loginWhite,
                      shape: NeumorphicShape.concave,
                      depth: 15,
                      surfaceIntensity: .5,
                      boxShape: const NeumorphicBoxShape.circle(
                      )
                  ),
                  onPressed: () async {
                    String? s = widget.request!.phone;
                    if(s != null){
                      await launchUrl(Uri.parse("tel://$s"));
                    }
                  },
                  child:SizedBox(
                    height: 55,
                    child: Icon(Icons.call,color: AppTheme.colors.appDarkBlue,size: 50,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
