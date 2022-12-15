import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/qr/qrcode_detailpage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class InspectorQrView extends StatefulWidget {
  const InspectorQrView({Key? key}) : super(key: key);

  @override
  State<InspectorQrView> createState() => _InspectorQrViewState();
}

class _InspectorQrViewState extends State<InspectorQrView> {

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String qrLink="https://leo-inspector-app-files.s3.ap-south-1.amazonaws.com/client/profileImageUrl/Leo1/";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        children: <Widget>[

          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: SizeConfig.blockSizeVertical*10,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: TextButton(
                     child:Text( (result != null) ? 'https://leo-inspector-app-files.s3.ap-south-1.amazonaws.com/client/profileImageUrl/Leo1/${result!.code}' : 'Scan a code',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                      onPressed: (){


                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>QrDetailPage()));
                      }),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: SizeConfig.blockSizeVertical*10,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller?.resumeCamera();
                      },
                      child: const Text('Scan',
                          style: TextStyle(fontSize: 20)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: AppTheme.colors.appDarkBlue,
          borderRadius: 10,
          borderLength: 10,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
