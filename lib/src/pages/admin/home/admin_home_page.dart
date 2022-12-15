import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/Repository/admin_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_certificate.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_client/manage_client_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_inspector/manage_inspector_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_request/manage_request.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  final AdminRepository adminRepository = AdminRepository();
  late Company? _company;
  late String? _companyId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _company = Company();
    _companyId = "";
    getCompanyDetails();
  }

  getCompanyDetails() async{
    try{
      _company = await adminRepository.getCompanyDetailsLocal();
      _companyId = _company!.companyId;
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }
  // final provider = getIt<AuthManager>();
  // AdminInspectorGetall? data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 63,
              ),
              InkWell(
                onTap: ()async{
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageInspectorHomePage(companyId: _companyId,)));
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
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 140,
                          child: Image.asset("assets/icons/manage_inspector.png"),
                        ),
                        Text(
                          "MANAGE INSPECTOR",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageClientHomePage(companyId: _companyId,)));
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
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 140,
                          child:Image.asset("assets/icons/add_client.png") ,),
                        Text(
                          "MANAGE CLIENT",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageCertificateHomePage(companyId: _companyId,)));
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
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 100.29,
                          child: Image.asset("assets/icons/manage_certificate.png"),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "MANAGE CERTIFICATE",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageRequest(companyId: _companyId,)));
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
                      boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20))),
                  child: SizedBox(
                    height: 199,
                    width: 272,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 90,
                          width: 100.29,
                          child: Image.asset("assets/icons/manage_requests.png"),
                        ),
                        Text(
                          "MANAGE REQUESTS",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
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
            ],
          ),
        ),
      ),
    );
  }
}
