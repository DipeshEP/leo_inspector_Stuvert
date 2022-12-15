import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Model/request_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/custom_widgets/search/search_request.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_request/request_detial_page.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../Services2/size_config.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';


class ManageRequest extends StatefulWidget {
  final String? companyId;
  const ManageRequest({Key? key,required this.companyId}) : super(key: key);

  @override
  State<ManageRequest> createState() => _ManageRequestState();
}

class _ManageRequestState extends State<ManageRequest> {

  late bool isLoading;
  late List<ManegeRequest> _requestList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _requestList = [];
    getRequestList();
  }

  getRequestList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.getRequestList("",widget.companyId);
      _requestList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        RequestModel requestModel = requestModelFromJson(s1);
        _requestList = requestModel.manegeRequest!;
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
    getRequestList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 150,right: 20),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchRequest(companyId: widget.companyId,)));
        },
        child: Container(
          height: 30,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.loginBlur),
          child: Row(
            children: [
              Center(
                child: IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),
                      );
                    },
                    icon: const Padding(
                      padding:  EdgeInsets.only(left:113,right: 5,bottom: 5),
                      child:  Center(child: Icon(Icons.search,size: 18,)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestList(){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.68,
        width: 313,
        decoration: BoxDecoration(
          color: AppTheme.colors.loginWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: (_requestList.isNotEmpty) ?
        ListView.builder(
            itemCount: _requestList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeHorizontal*2 ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestDetailPage(request: _requestList[index],)));
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
                                padding: EdgeInsets.only(left: 5,top: SizeConfig.blockSizeHorizontal*2),
                                child: Text(
                                  "Company                 :",
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
                                  (_requestList[index].company!.name != null) ? _requestList[index].company!.name! : '',
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
                                  "Date of Inspection  : ",
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
                                  (_requestList[index].inspectionDate != null) ? DateFormat('dd-MM-yyyy').format(_requestList[index].inspectionDate!) : '',
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
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
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                    // push(context,MaterialPageRoute(builder: (context)=> const AdminHomePage()));
                  },
                    icon: Icon(Icons.double_arrow,
                      size: 30,
                      color: AppTheme.colors.logoColor,),),
                )

            )
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

                            const SizedBox(
                              height: 20,
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                height: MediaQuery.of(context).size.height*0.80,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppTheme.colors.loginWhite,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    const Center(child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text("LIST OF REQUEST",style: TextStyle(
                                        fontSize: 18,fontWeight: FontWeight.bold,
                                      ),),
                                    )),
                                    searchBar(),
                                    requestList()
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
       /*   body:  Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
              height: MediaQuery.of(context).size.height*0.80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppTheme.colors.loginWhite,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Center(child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("LIST OF REQUEST",style: TextStyle(
                      fontSize: 18,fontWeight: FontWeight.bold,
                    ),),
                  )),
                  searchBar(),
                  requestList()
                ],
              ),

          ),
        )*/
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

