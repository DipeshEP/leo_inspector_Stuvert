import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspected_certificate/inspector_certificate_list.dart';
import 'package:leo_inspector/src/pages/inspector/home/inspection/inspection_company_list.dart';
import 'package:leo_inspector/src/pages/inspector/home/pending_approval/pending_certificate_list.dart';
import 'package:leo_inspector/src/pages/inspector/home/pending_approval/select_client.dart';

import '../../../../Model/company_model.dart';
import '../../../../Model/inspector_login_response_model.dart';
import '../../../../Model/inspector_model.dart';
import 'authorised_inspector_list/approve_certificate_page.dart';
import 'authorised_inspector_list/auth_inspector_list.dart';
import 'authorised_inspector_list/success_screen.dart';
import '../../../../../Model/inspector_model2.dart';


class InspectorHomePage extends StatefulWidget {
  const InspectorHomePage({Key? key}) : super(key: key);

  @override
  State<InspectorHomePage> createState() =>
      _InspectorHomePageState();
}

class _InspectorHomePageState
    extends State<InspectorHomePage> {

  final InspectorRepository inspectorRepository = InspectorRepository();
  late Inspector? _inspector;
  late Company? _company;
  late String? _companyId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 63,
            ),
            InkWell(
              onTap: () {
                /*Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SuccessScreen(
                  message: 'SUCCESSFULY SENT TO AUTHORISED SIGNATORY',
                )));*/

                //Navigator.push(context, MaterialPageRoute(builder: (context) => const ApproveCertificatePage()));

                Navigator.push(context, MaterialPageRoute(builder: (context) => InspectionCompanyList(companyId: _companyId,)));
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    color: AppTheme.colors.loginWhite,
                    surfaceIntensity: .5,
                    depth: 20,
                    intensity: 5,
                    shadowLightColor: AppTheme.colors.white,
                    border: const NeumorphicBorder(
                        //  color: Color(0XFF07649F)
                        ),
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20))),
                child: SizedBox(
                  height: 199,
                  width: 272,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 10,right: 15),
                        child: SizedBox(
                          height: 100,
                          width: 146,
                          child:
                              // Icon(Icons.accessibility),),
                              Image.asset("assets/icons/inspectors_icon.png"),
                        ),
                      ),
                      Text(
                        "INSPECTION",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppTheme.colors.appDarkBlue),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 63,
            ),
            InkWell(
              onTap: () async {

                //Inspector? inspector = await inspectorRepository.getInspectorDetailsLocal();

                InspectorLoginModel? responseModel = await inspectorRepository.getInspectorLoginResponse();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InspectorCertificatePage(inspectorId: responseModel!.userId!)));
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    color: AppTheme.colors.loginWhite,
                    surfaceIntensity: .5,
                    depth: 20,
                    intensity: 5,
                    shadowLightColor: AppTheme.colors.white,
                    border: const NeumorphicBorder(
                        //  color: Color(0XFF07649F)
                        ),
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20))),
                child: SizedBox(
                  height: 199,
                  width: 272,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 10),
                        child: SizedBox(
                          height: 100,
                          width: 146,
                          child:
                              // Icon(Icons.accessibility),),
                              Image.asset(
                                  "assets/icons/manage_certificate.png"),
                        ),
                      ),
                      Text(
                        "INSPECTED CERTIFICATE",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppTheme.colors.appDarkBlue),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 63,
            ),

            (_inspector != null && _inspector!.inspectorType == 'InspectorSignetory') ?
            InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectClient(
                          inspectorId: _inspector!.inspectorId,
                          authorisedInspector: _inspector,
                          companyId: _companyId,
                        )));
              },
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    color: AppTheme.colors.loginWhite,
                    surfaceIntensity: .5,
                    depth: 20,
                    intensity: 5,
                    shadowLightColor: AppTheme.colors.white,
                    border: const NeumorphicBorder(
                      //  color: Color(0XFF07649F)
                    ),
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20))),
                child: SizedBox(
                  height: 199,
                  width: 272,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 10),
                        child: SizedBox(
                          height: 100,
                          width: 146,
                          child:
                          // Icon(Icons.accessibility),),
                          Image.asset(
                              "assets/icons/manage_certificate.png"),
                        ),
                      ),
                      Text(
                        "PENDING APPROVAL",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            color: AppTheme.colors.appDarkBlue),
                      )
                    ],
                  ),
                ),
              ),
            ) : Container(),

            const SizedBox(
              height: 63,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inspector = Inspector();
    _company = Company();
    _companyId = "";
    getInspector();
    getCompanyDetails();
  }

  getCompanyDetails() async{
    try{
      _company = await inspectorRepository.getCompanyDetailsLocal();
      _companyId = _company!.companyId;
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }

  getInspector() async{
    try{
      _inspector = await inspectorRepository.getInspectorDetailsLocal();
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }
}
