import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../Model/certificate_model.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../../appcolors/colors.dart';
//import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/*
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
*/

class PDFViewer1 extends StatefulWidget {
  final String url, pdfName;
  final Certificate? certificate;

  const PDFViewer1({required this.url, required this.pdfName,required this.certificate, Key? key})
      : super(key: key);

  @override
  State<PDFViewer1> createState() => _PDFViewer1State();
}

class _PDFViewer1State extends State<PDFViewer1> {
/*
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
*/
  bool _isLoading = true;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SafeArea(
        child: Stack(
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PDF(
                onViewCreated: (PDFViewController pdfViewController) async {
                  _pdfViewController.complete(pdfViewController);
                  final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
                  final int? pageCount = await pdfViewController.getPageCount();
                  _pageCountController.add('${currentPage + 1} - $pageCount');
                },
                onPageChanged: (int? current, int? total) =>
                    _pageCountController.add('${current! + 1} - $total'),
                swipeHorizontal: true,
              ).cachedFromUrl(widget.url,
                  placeholder: (progress) => Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Constants.primaryColor,
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeHorizontal*3,
                      ),
                      Text('$progress %',style: const TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: Constants.fontRegular,
                          fontWeight: FontWeight.w700
                      ),),
                    ],
                  )),
                  errorWidget: (error) => Center(child: Text(error.toString()))),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cert.No : ${widget.certificate!.certificateId!}",
                          style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 14),),
                        const SizedBox(height: 5,),
                        Text(
                            "Date of Issued : ${DateFormat('dd MMM yyyy').format(widget.certificate!.createdAt!)}",
                            style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 14)),
                        const SizedBox(height: 5,),
                        /*Text(
                            "Description : ${widget.certificate!.details!}",
                            style: GoogleFonts.inter(color: AppTheme.colors.loginWhite,fontSize: 14,)),*/

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

          ],
        )

        /*SfPdfViewer.network(
          widget.url,
          key: _pdfViewerKey,
          pageLayoutMode: PdfPageLayoutMode.single,
        ),*/
      ),
    );
  }
}
