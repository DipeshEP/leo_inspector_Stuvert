import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/Services2/size_config.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_certificate/manage_company_certificate_list_page.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';
import '../../custom_widgets/search/search_client.dart';

class ManageCertificateHomePage extends StatefulWidget {
  final String? companyId;

  const ManageCertificateHomePage({Key? key,required this.companyId}) : super(key: key);

  @override
  State<ManageCertificateHomePage> createState() => _ManageCertificateHomePageState();
}

class _ManageCertificateHomePageState extends State<ManageCertificateHomePage> {

  late bool isLoading;
  late List<Client> _clientList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _clientList = [];
    getClientList();
  }

  getClientList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.getClientList("",widget.companyId);
      _clientList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        ClientModel clientModel = clientModelFromJson(s1);
        _clientList = clientModel.client!;
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
    getClientList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 150,right: 20),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchClient(companyId: widget.companyId,)));
        },
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width/1.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.loginBlur),
          child: Row(
            children: [

              Center(
                child: IconButton(
                    onPressed: () {
                    },
                    icon: const Padding(
                      padding:  EdgeInsets.only(left:80,right: 5,bottom: 5),
                      child:  Center(child: Icon(Icons.search,size: 18,)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget clientLists(){
           return Container(
              height: MediaQuery.of(context).size.height*0.65,
              width:  MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
              color: AppTheme.colors.loginWhite,
              borderRadius: BorderRadius.circular(20),),
             child: (_clientList.isNotEmpty) ?
             ListView.builder(
                itemCount: _clientList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context ,int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4,vertical: 5 ),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CompanyCertificatePage(client: _clientList[index],)));
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
                                    width: SizeConfig.blockSizeHorizontal*29,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                                    child: Text(
                                      "COMPANY NAME: ",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.colors.black),
                                    )
                                ),

                                Container(
                                    width: SizeConfig.blockSizeHorizontal*45,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2,bottom: SizeConfig.blockSizeHorizontal*2),
                                    child: Text(
                                      (_clientList[index].name != null) ? _clientList[index].name! : '',
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
                                    width: SizeConfig.blockSizeHorizontal*29,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                    child: Text(
                                      "COMPANY Id       :",
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
                                      (_clientList[index].clientId != null) ? _clientList[index].clientId! : '',
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
             const Center(
                 child: Text('List is empty!')) : Container(),
                );
              }

@override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
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
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminBottomNavigationBarPage()));*/
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.76,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppTheme.colors.loginWhite,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:  Column(
                            children: [
                              const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(child: Text("COMPANY LIST",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),)),
                            ),
                            searchBar(),
                            const SizedBox(height: 10,),
                            clientLists()
                          ],
                        ),
                        ),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                height: MediaQuery.of(context).size.height*0.76,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppTheme.colors.loginWhite,
                  borderRadius: BorderRadius.circular(20),
                ),child:  Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(child: Text("COMPANY LIST",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),)),
                    ),
                    searchBar(),
                    const SizedBox(height: 10,),
                    companyLists()
                  ],
                ),
          ),
        ),
),
*/
      ),
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
