import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/certificate_model.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/custom_widgets/search/search_certificate.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_certificate.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_certificate_view.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/pdf_viewer.dart';

import '../../../../../Model/company_model.dart';
import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';

class CompanyCertificatePage extends StatefulWidget {

  final Client? client;
  const CompanyCertificatePage({Key? key,required this.client}) : super(key: key);

  @override
  State<CompanyCertificatePage> createState() => _CompanyCertificatePageState();
}

class _CompanyCertificatePageState extends State<CompanyCertificatePage> {

  late bool isLoading;
  late List<Certificate> _certificateList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _certificateList = [];
    getCertificateList();
  }

  getCertificateList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.getCertificateList(widget.client!.clientId!,"");
      _certificateList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        CertificateModel certificateModel = certificateModelFromJson(s1);
        _certificateList = certificateModel.certificate!;
      }
      else if(response.statusCode == 303 || response.statusCode == 401 ){
        adminRepository.clear();
        adminRepository.setAdminLoggedIn(false);
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Authorisation Expired!',
                subtext: 'Please Login again',
                ok: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) =>
                      const HomePage()), (route) => false);
                },
              );
            });
      }
      isLoading = false;
      setState(() {});
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refresh() async {
    getCertificateList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 150, right: 20),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchCertificate(client: widget.client)));
        },
        child: Container(
          height: 30,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.loginBlur),
          child: Row(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: Text(
              //     "Search",
              //     style: TextStyle(
              //       fontSize: 12,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Center(
                child: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 80, right: 5, bottom: 5),
                      child:  Center(
                          child: Icon(
                        Icons.search,
                        size: 18,
                      )),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget certificateListTile() {
    return Container(
        height: MediaQuery.of(context).size.height*0.70,
        width: 350,
        decoration: BoxDecoration(
          color: AppTheme.colors.loginWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: (_certificateList.isNotEmpty) ?
        ListView.builder(
            itemCount: _certificateList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4,vertical: 5 ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PDFViewer1(url: _certificateList[index].certificatePdf!,pdfName: _certificateList[index].certificateId!,certificate: _certificateList[index],)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*4,horizontal: SizeConfig.blockSizeHorizontal*2),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Certificate No   : ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].certificateId != null) ? _certificateList[index].certificateId! : '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),
                          ],
                        ),

                        SizedBox(
                            height: SizeConfig.blockSizeHorizontal*1
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Description       :  ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].certificateVersion != null) ? _certificateList[index].certificateVersion! : '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),
                          ],
                        ),

                        SizedBox(
                            height: SizeConfig.blockSizeHorizontal*1
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: SizeConfig.blockSizeHorizontal*27,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Date of Issue    :  ",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),

                            Container(
                                width: SizeConfig.blockSizeHorizontal*45,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  (_certificateList[index].createdAt != null) ? DateFormat('dd/MM/yyyy').format( _certificateList[index].createdAt!) : '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.colors.black),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }):
        (!isLoading) ?
        const Center(child: Text('List is empty!')) : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.colors.appDarkBlue,
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
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    /*Navigator.
                    push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManageCertificateHomePage()));*/
                  },
                  icon: Icon(
                    Icons.double_arrow,
                    size: 30,
                    color: AppTheme.colors.logoColor,
                  ),
                ),
              ))
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
              onRefresh: refresh,
              child: Stack(
                children: [
                  ListView(),

                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.81,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppTheme.colors.loginWhite,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                      child: Text(
                                        (widget.client!.name != null) ? widget.client!.name!.toUpperCase() : "COMPANY NAME",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      )),
                                ),
                                searchBar(),
                                const SizedBox(
                                  height: 10,
                                ),
                                certificateListTile(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  (isLoading)? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      color: Constants.primaryColor,
                      strokeWidth: 2,
                    ),
                  ): Container(),

                ],
              )
          ),
        ),
      ),

/*
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.81,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.colors.loginWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(
                        "COMPANY NAME",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                    searchBar(),
                    const SizedBox(
                      height: 10,
                    ),
                    certificateListTile(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
*/
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Company Name 01',
    'Company Name 02',
    'Company Name 03',
    'Company Name 04',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResult(BuildContext context) {
    List<String> matchQuery = [];
    for (var Company in searchTerms) {
      if (Company.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(Company);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: ((context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var Company in searchTerms) {
      if (Company.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(Company);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
// class CertificateListTile extends StatefulWidget {
//   const CertificateListTile({Key? key}) : super(key: key);
//
//   @override
//   State<CertificateListTile> createState() => _CertificateListTileState();
// }

// class _CertificateListTileState extends State<CertificateListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return  ListView.builder(
//         itemCount: 16,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.only(
//                 left: 16.0, right: 16, top: 16), child: Card(
//                 elevation: 1,
//                 color: AppTheme.colors.white,
//                 child:ListTile(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 const CertificateView()));
//                   },
//                   focusColor: AppTheme.colors.appBlue,
//
//                   title: Text(
//                     "certficate no",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.inter(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: AppTheme.colors.black),
//                   ),
//                   subtitle: Text(
//                     "date of issue",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.inter(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w400,
//                         color:
//                         AppTheme.colors.black.withOpacity(.6)),
//                   ),
//                   trailing: NeumorphicButton(
//                     style: NeumorphicStyle(
//                         shadowLightColor: AppTheme.colors.blue,
//                         color: AppTheme.colors.green,
//                         shape: NeumorphicShape.convex,
//                         depth: 0,
//                         surfaceIntensity: 0,
//                         boxShape: const NeumorphicBoxShape.circle(
//                         )
//                     ),
//
//                     child:const SizedBox(
//
//                       height: 5,
//                     ),
//                   ),
//
//                   // Container(
//                   //
//                   //   height: 15,
//                   //   width: 15,
//                   //   color: AppTheme.colors.green,
//                   // ),
//                   // dense: true,
//                   selectedColor: AppTheme.colors.shadowWhite,
//                 )
//             ),
//           );
//         }
//     );
//   }
// }
