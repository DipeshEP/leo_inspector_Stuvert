

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/Services2/Repository/admin_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/admin_bottom_navigation_bar.dart';
import 'package:leo_inspector/src/pages/admin/custom_widgets/tiles/inspector_tile.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_inspector/add_inspector_page.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_inspector/inspector_profile_page.dart';
import 'package:leo_inspector/src/pages/home_page.dart';

import '../../../../../data/constants.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';
import '../../../../../Model/inspector_model2.dart';

class ManageInspectorHomePage extends StatefulWidget {

  final String? companyId;

  const ManageInspectorHomePage({Key? key,required this.companyId}) : super(key: key);

  @override
  State<ManageInspectorHomePage> createState() => _ManageInspectorHomePageState();
}

class _ManageInspectorHomePageState extends State<ManageInspectorHomePage> {

  late bool isLoading;
  late List<Inspector> _inspectList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _inspectList = [];
    getInspectorList();
  }

  getInspectorList() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.getInspectorList(widget.companyId);
      _inspectList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        InspectorListModel inspectorModel = inspectorListModelFromJson(s1);
        _inspectList = inspectorModel.inspectors!;
      }
      else if((response.statusCode == 303 || response.statusCode == 401 )){
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
    getInspectorList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child:RotatedBox(
                quarterTurns: 2,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
/*
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const AdminBottomNavigationBarPage()));
*/
                },
                  icon: Icon(Icons.double_arrow,
                    size: 30,
                    color: AppTheme.colors.logoColor,),),
              ))
        ],
      ),
      body: SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
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
                          padding:const  EdgeInsets.symmetric(vertical: 10.0,horizontal: 23.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height/1.5,
                            width: MediaQuery.of(context).size.width,
                            decoration:const  BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: Color(0XFFECE9E6),
                            ),
                            padding: const EdgeInsets.only(top: 10),
                            child: (_inspectList.isNotEmpty) ? ListView.builder(
                                itemCount: _inspectList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context,index){
                                  return (_inspectList[index] != null ) ?
                                  InspectorListTile(
                                    inspector: _inspectList[index],
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> InspectorProfilePage(
                                        inspector: _inspectList[index],
                                        onDelete: (){
                                          refresh();
                                        },
                                        onBackPressed: (){
                                          refresh();
                                        },
                                      )));
                                    },
                                  ) : Container();
                                }
                            )  : (!isLoading) ? const Center(
                              child: Text('List is empty!'),
                            ) : Container(),
                          ),
                        ),
                        const  SizedBox(
                          height: 20,
                        ),
                        NeumorphicButton(
                          style: NeumorphicStyle(
                              shadowLightColor: AppTheme.colors.blue,
                              color: AppTheme.colors.appDarkBlue,
                              shape: NeumorphicShape.concave,
                              depth: 15,
                              surfaceIntensity: .5,
                              boxShape: const NeumorphicBoxShape.circle(
                              )
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddInspectorScreen(
                              onBackPressed: (){
                                refresh();
                              },
                            )));
                          },
                          child:SizedBox(
                            height: 55,
                            child: Icon(Icons.add,color: AppTheme.colors.loginWhite,size: 50,),
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
    ),

/*
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:const  EdgeInsets.symmetric(vertical: 10.0,horizontal: 23.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  width: 313,
                  decoration:const  BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: Color(0XFFECE9E6),
                  ),
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index){return
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 23),
                          child: Card(
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const InspectorProfilePage()));
                              },
                              title: Text('Name:$index'),
                              subtitle: Text('EID:$index'),
                              leading: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Color(0XFFD9D9D9),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 10
                  ),
                ),
              ),
              const  SizedBox(
                height: 20,
              ),
              NeumorphicButton(
                style: NeumorphicStyle(
                    shadowLightColor: AppTheme.colors.blue,
                    color: AppTheme.colors.appDarkBlue,
                    shape: NeumorphicShape.concave,
                    depth: 15,
                    surfaceIntensity: .5,
                    boxShape: const NeumorphicBoxShape.circle(
                    )
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddInspectorScreen()));
                },
                child:SizedBox(
                  height: 55,
                  child: Icon(Icons.add,color: AppTheme.colors.loginWhite,size: 50,),
                ),
              ),
              // NeumorphicFloatingActionButton(
              //   onPressed: (){
              //    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => addInspector()));
              //     },
              //   child: SizedBox(
              //       height:85,
              //       width: 85,
              //       child: Icon(Icons.add,color: Color(0XFFECE9E6),size: 40,)),
              //   style: NeumorphicStyle(
              //       shape: NeumorphicShape.concave,
              //       boxShape: NeumorphicBoxShape.circle(),
              //       color: Color(0XFF055E98),
              //       depth: 15,
              //       intensity: .3
              //       ,
              //       shadowDarkColor: AppTheme.colors.appBlue
              //
              //   ),
              //   // child: FloatingActionButton(onPressed: (){},
              //   //   backgroundColor: Color(0XFF055E98),
              //   //   child: Icon(Icons.add,size: 40,),
              //   // ),
              // ),
            ],
          ),
        ),
      ),
*/
    );
  }
}
