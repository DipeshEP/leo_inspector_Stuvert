import 'package:avatar_view/avatar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_client/manage_client_home_page.dart';

import '../../../../../Model/client_model.dart';
import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';


class ClientDetailPage extends StatefulWidget {

  final Client? client;
  final Function() onDelete;
  final Function() onBackPressed;

  const ClientDetailPage({Key? key,required this.client,required this.onDelete,required this.onBackPressed}) : super(key: key);

  @override
  State<ClientDetailPage> createState() => _ClientDetailPageState();
}
// fetchData(context) async {
// await BlocProvider.of<ManageClientCubit>(context).fetchManageClientDetails();}

class _ClientDetailPageState extends State<ClientDetailPage> {

  late bool isLoading;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  deleteClient() async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.deleteClient(widget.client!.clientId!);

      isLoading = false;
      setState(() {});

      if(response!.statusCode == 200){
        Navigator.pop(context);
        widget.onDelete();
      }
      else if(response.statusCode == 303 || response.statusCode == 401 ){
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

  @override
  Widget build(BuildContext context) {

    print(widget.client!.name);
    print(widget.client!.email);
    print(widget.client!.phone);
    print(widget.client!.clientId);
    print(widget.client!.cmpId);
    print(widget.client!.profileImageUrl);

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
                                  const SizedBox(height: 37),
                                  Center(
                                    child: Text(
                                      (widget.client!.name != null) ? widget.client!.name!.toUpperCase() : '',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18
                                      ),),
                                  ),
                                  const SizedBox(height: 30),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Text("Company Id                :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),
                                          ),
                                          Text(
                                            (widget.client!.cmpId != null) ? widget.client!.cmpId! : '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Text("Company Email          :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),
                                          Text(
                                            (widget.client!.email != null ) ? widget.client!.email! : '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Text("Contact Number         :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),

                                          Text(
                                            (widget.client!.phone != null) ? widget.client!.phone! : '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13
                                            ),),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Center(
                                            child: Text("Name of \nContact Person    ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13
                                              ),),
                                          ),
                                          const Center(
                                            child: Text("       :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13
                                              ),),
                                          ),
                                          Center(
                                            child: Text(
                                              (widget.client!.company != null && widget.client!.company!.contactPerson != null) ? widget.client!.company!.contactPerson! : '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Center(
                                            child: Text("Company Address      :",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13
                                              ),),
                                          ),
                                          Center(
                                            child: Text(
                                              (widget.client!.company != null && widget.client!.company!.address != null) ? widget.client!.company!.address! : '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13
                                              ),),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30,),

                                  NeumorphicButton(
                                    style: NeumorphicStyle(
                                        color: AppTheme.colors.loginWhite,
                                        shape: NeumorphicShape.concave,
                                        depth: 15,
                                        surfaceIntensity: .5,
                                        boxShape: const NeumorphicBoxShape.circle(
                                        )
                                    ),
                                    onPressed: (){
                                      deleteClient();
                                    },
                                    child:SizedBox(
                                        height: 55,
                                        child: Image.asset("assets/icons/delete.png")
                                    ),
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
                                (widget.client!.profileImageUrl != null) ? widget.client!.profileImageUrl! : 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg',
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
}
