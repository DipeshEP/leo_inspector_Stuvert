import 'package:avatar_view/avatar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';
import '../../../../../Model/inspector_model2.dart';

class InspectorProfilePage extends StatefulWidget {

  final Inspector? inspector;
  final Function() onDelete;
  final Function() onBackPressed;

  const InspectorProfilePage({Key? key,required this.inspector,required this.onDelete,required this.onBackPressed}) : super(key: key);

  @override
  State<InspectorProfilePage> createState() => _InspectorProfilePageState();
}

class _InspectorProfilePageState extends State<InspectorProfilePage> {

  late bool isLoading;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    print('image url');
    print(widget.inspector!.profileImageUrl);

    print('signature url');
    print(widget.inspector!.signatureUrl);
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar:  AppBar(
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
                    widget.onBackPressed();
                  },
                    icon: Icon(Icons.double_arrow,
                      size: 30,
                      color: AppTheme.colors.logoColor,),),
                )

            )
          ],
        ),
        backgroundColor: AppTheme.colors.appDarkBlue,

        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [

                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const  SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding:const  EdgeInsets.only(top: 80,left: 20,right: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height*0.70,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius:const  BorderRadius.all(Radius.circular(20)),
                                color: AppTheme.colors.loginWhite,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 90,
                                  ),

                                  Divider(color: AppTheme.colors.black,thickness: 01),
                                  Text(
                                    (widget.inspector!.name != null) ? widget.inspector!.name! : '',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                        color: AppTheme.colors.black
                                    ),),

                                  Text(
                                    (widget.inspector!.empId != null) ? widget.inspector!.empId! : '',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                        color: AppTheme.colors.black
                                    ),),
                                  Divider(color: AppTheme.colors.black,thickness: 01),

                                  const SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Row(
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                        Icon(Icons.phone,color: AppTheme.colors.appDarkBlue,),
                                        const SizedBox(width: 10,),
                                        Text(
                                          (widget.inspector!.phone != null) ? widget.inspector!.phone! : '',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: AppTheme.colors.black
                                          ),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(

                                    height: 20,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 40.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.email,color: AppTheme.colors.appDarkBlue,),
                                        const SizedBox(width: 10,),
                                        Text(
                                          (widget.inspector!.email != null) ? widget.inspector!.email! : '',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 20,
                                              color: AppTheme.colors.black
                                          ),),
                                      ],
                                    ),
                                  ),
                                  const  SizedBox(

                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    width: 150,
                                    child: Image.network(
                                      (widget.inspector!.signatureUrl != null) ? widget.inspector!.signatureUrl! : '',
                                    ),
                                  ),

                                  const  SizedBox(

                                    height: 40,
                                  ),
                                  NeumorphicButton(
                                      style: const NeumorphicStyle(
                                        shadowLightColor: Color(0XFFF8F5F2),
                                        color: Color(0XFFE0DDDB),
                                        shape: NeumorphicShape.concave,
                                        depth: 15,
                                        surfaceIntensity: .3,
                                        boxShape: NeumorphicBoxShape.circle(),
                                      ),
                                      onPressed: (){
                                        deleteInspector();
                                      },
                                      child: SizedBox(
                                        height: 55,
                                        child: Image.asset("assets/icons/delete.png"),)),

                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: AvatarView(
                                radius: 70,
                                borderColor: Colors.yellow,
                                isOnlyText: false,
                                text: const Text('Name', style: TextStyle(color: Colors.white, fontSize: 50),),
                                avatarType: AvatarType.CIRCLE,
                                backgroundColor: Colors.blue,
                                imagePath:
                                (widget.inspector!.profileImageUrl != null) ? widget.inspector!.profileImageUrl! : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
                                placeHolder: const Icon(Icons.person, size: 70,),
                                errorWidget: const Icon(Icons.person_rounded, size: 70,),
                              ),

                            ),
                          ),
                        ],
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
            ),
          ),
        ),
      ),
    );
  }

  deleteInspector() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.deleteInspector(widget.inspector!.inspectorId!);

      isLoading = false;
      setState(() {});

      if(response!.statusCode == 200){
       Navigator.pop(context);
       widget.onDelete();
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
      else{
        Fluttertoast.showToast(msg: 'Error deleting profile');
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}
