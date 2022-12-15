
import 'package:avatar_view/avatar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Services2/Repository/inspector_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/inspector/home/trash/view_trash.dart';

import '../../../../data/constants.dart';
import '../../admin/custom_widgets/dialogs/info_dialog.dart';
import '../../home_page.dart';
import '../../../../../Model/inspector_model2.dart';
import 'package:leo_inspector/Model/notification_model.dart' as m;

class InspectorSettingsPage extends StatefulWidget {
  const InspectorSettingsPage({Key? key}) : super(key: key);

  @override
  State<InspectorSettingsPage> createState() => _InspectorSettingsPageState();
}

//
// fetchData(context) async {
//   await BlocProvider.of<AdminProfileCubit>(context).fetchAdminDetails();
//   // await BlocProvider.of<CompanyProfileCubit>(context).fetchComanyProfile();
// }

class _InspectorSettingsPageState extends State<InspectorSettingsPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InspectorRepository inspectorRepository = InspectorRepository();
  late Inspector? _inspector;
  late TextEditingController emailController;
  late TextEditingController passwordController1;
  late TextEditingController passwordController2;
  late bool isLoading;

  late List<m.Notification> _notificationList;

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget profile() {
    return Card(
      color: AppTheme.colors.loginWhite,
      child: ExpansionTile(
        backgroundColor: AppTheme.colors.loginWhite,
        title: Text(
          "Profile",
          style: TextStyle(color: AppTheme.colors.appDarkBlue),
        ),
        leading: Icon(
          Icons.person_rounded,
          color: AppTheme.colors.appDarkBlue,
        ),
        trailing: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.colors.appDarkBlue,
            )),
        children: [
          Container(
            height: 470,
            child: Card(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  AvatarView(
                    radius: 70,
                    borderWidth: 3,
                    borderColor: Colors.yellow,
                    avatarType: AvatarType.CIRCLE,
                    backgroundColor: Colors.red,
                    imagePath: (_inspector != null && _inspector!.profileImageUrl != null)
                        ? _inspector!.profileImageUrl! : "assets/images/bgimage.png",
                    placeHolder: Container(
                      child: const Icon(
                        Icons.person,
                        size: 60,
                      ),
                    ),
                    errorWidget: const Icon(
                      Icons.error,
                      size: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      (_inspector != null && _inspector!.name != null) ? _inspector!.name! :" --  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.colors.appDarkBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (_inspector != null && _inspector!.empId != null) ? _inspector!.empId! :" --  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppTheme.colors.appDarkBlue,
                          // fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: AppTheme.colors.appDarkBlue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            (_inspector != null && _inspector!.phone != null) ? _inspector!.phone! :" --  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.colors.appDarkBlue,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.alternate_email,
                          color: AppTheme.colors.appDarkBlue,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            (_inspector != null && _inspector!.email != null) ? _inspector!.email! :" --  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppTheme.colors.appDarkBlue,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      child: (_inspector!.signatureUrl != null) ? Image.network(_inspector!.signatureUrl!) : null,
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget trashList() {
    return Card(
      color: AppTheme.colors.loginWhite,
      elevation: 2,
      child: InkWell(
        onTap: (){
          print('notification');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewTrash(
                    notificationList: _notificationList,
                  )));
        },
        child: ListTile(
          tileColor: AppTheme.colors.appDarkBlue,
          title: Text(
            "notification",
            style: TextStyle(color: AppTheme.colors.loginWhite),
          ),
          trailing: IconButton(
              onPressed: () async{
                print('delete notification');
                _notificationList.clear();
                await inspectorRepository.storeTrashNotificationList([]);
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                color: AppTheme.colors.loginWhite,
              )),
        ),
      ),
    );
  }

  Widget passwordButton() {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 15,
        surfaceIntensity: .2,
        intensity: 5,
        shadowLightColor: AppTheme.colors.loginBlur.withOpacity(.3),
        lightSource: LightSource.topLeft,
        color: AppTheme.colors.loginWhite,
      ),
      child: Container(
        height: 60,
        width: 157,
        decoration: BoxDecoration(
            color: AppTheme.colors.loginWhite,
            borderRadius: BorderRadius.circular(10)),
        child: TextButton(
            onPressed: () {
              validate();
            },
            child: Text(
              "Reset ",
              style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.colors.black),
            )),
      ),
    );
  }

  Widget changePassword() {
    return Card(
      color: AppTheme.colors.loginWhite,
      child: ExpansionTile(
          backgroundColor: AppTheme.colors.loginWhite,
          title: Text(
            "Change Password",
            style: TextStyle(color: AppTheme.colors.appDarkBlue),
          ),
          leading: Container(
              width: 30,
              height: 30,
              child: Image.asset("assets/icons/change_password.png",
                  color: AppTheme.colors.appDarkBlue)),
          trailing: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.colors.appDarkBlue,
              )),
          children: [
            SizedBox(
              height: 350,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppTheme.colors.black)),
                              border: const OutlineInputBorder(),
                              labelText: "Email",
                              focusColor: AppTheme.colors.white,
                              labelStyle: GoogleFonts.inter(
                                  color: AppTheme.colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppTheme.colors.black)),
                              border: const OutlineInputBorder(),
                              labelText: "Old Password",
                              focusColor: AppTheme.colors.white,
                              labelStyle: GoogleFonts.inter(
                                  color: AppTheme.colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController2,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              fillColor: AppTheme.colors.white,
                              filled: true,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: AppTheme.colors.black)),
                              border: const OutlineInputBorder(),
                              labelText: "New Password",
                              focusColor: AppTheme.colors.white,
                              labelStyle: GoogleFonts.inter(
                                  color: AppTheme.colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      passwordButton(),
                    ],
                  ),
                ),
              ),
            ),
          ]),
    );
  }

  Widget privacyPolicy() {
    return Card(
      color: AppTheme.colors.loginWhite,
      child: ExpansionTile(
          backgroundColor: AppTheme.colors.loginWhite,
          title: Text(
            "Privacy Policy",
            style: TextStyle(color: AppTheme.colors.appDarkBlue),
          ),
          leading: Icon(
            Icons.privacy_tip_rounded,
            color: AppTheme.colors.appDarkBlue,
          ),
          trailing: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.colors.appDarkBlue,
              )),
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.colors.white,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        border: Border.all(color: AppTheme.colors.white),
                      ),
                      height: 300,
                      child: Column(
                        children: const [
                          Expanded(
                              child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      // data!.company.length
                                      //
                                      " How to access, correct, delete or exercise other rights regarding your Personal Information If you would like to request to access, correct, object to the use, restrict or delete personal information that you have previously provided to us, or if you would like to request to receive an electronic copy of your personal information for purposes of transmitting it to another company, you may contact us at support@russruffino.com with the subject line “Data Subject Request.” We will attempt to comply with your request. However, the nature of our business, along with the applicable law governing our business, requires us to retain your information for several years. Please also note that we may need to retain certain information for recordkeeping purposes and/or to complete any transactions that you began prior to requesting a change or deletion (e.g., when you make a purchase or enter a promotion, you may not be able to change or delete the personal information provided until after the completion of such purchase or promotion). There may also be residual information that will remain within our databases and other records, which will not be removed.As a result, we cannot guarantee the deletion of all your information. But, when we receive a deletion request, we will remove your applicable information from our marketing and billing systems accordingly. This will ensure that there are no further mailings or billings directed towards you.As we continue to refine our systems, we will establish a method for the complete removal of all user information from the system without compromising our legal and ethical duties. This document will evolve as these new methods are defined and tested for permanent account deletion.For your protection, we may only implement requests with respect to the personal information associated with the particular email address that you use to send us your request, and we may need to verify your identity before implementing your request. We will try to comply with your request as soon as reasonably practicable Your choices regarding our use and disclosure of informatio We may use the information you provide for marketing purposes such as promotional emailing, direct mail, and sales contacts. We give you many choices regarding our use and disclosure of your personal information for marketing purposes. You may opt-out from receiving electronic communications from us if you are a user of products or services and no longer want to receive marketing-related emails from us on a going-forward basis, you may opt-out of receiving these marketing-related emails by sending a request for list removal to support@russruffino.com. If you have provided your information to us, and opt-out, we will put in place processes to honor your request. This may entail keeping some information for the purpose of remembering that you have opted-out.We will try to comply with your request(s) as soon as reasonably practicable. Please also note that if you do opt-out of receiving marketing-related emails from us, we may still send you messages for administrative or other purposes directly relating to your use of the products or services, and you cannot opt-out from receiving those messages    Data Retention We will retain your personal information for as long as needed or permitted in light of the purpose(s) for which it was obtained and consistent with applicable law. The criteria used to determine our retention periods includ",
                                      textAlign: TextAlign.start,
                                    ),
                                  ))),
                        ],
                      )),
                ),
              ),
            )
          ]),
    );
  }

  Widget termsCondition() {
    return Card(
      color: AppTheme.colors.loginWhite,
      child: ExpansionTile(
        backgroundColor: AppTheme.colors.loginWhite,
        title: Text(
          "Terms & Conditions",
          style: TextStyle(color: AppTheme.colors.appDarkBlue),
        ),
        leading: Icon(
          Icons.gavel,
          color: AppTheme.colors.appDarkBlue,
        ),
        trailing: RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.colors.appDarkBlue,
            )),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.colors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      border: Border.all(color: AppTheme.colors.white),
                    ),
                    height: 300,
                    child: Column(
                      children: const [
                        Expanded(
                            child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    " How to access, correct, delete or exercise other rights regarding your Personal Information If you would like to request to access, correct, object to the use, restrict or delete personal information that you have previously provided to us, or if you would like to request to receive an electronic copy of your personal information for purposes of transmitting it to another company, you may contact us at support@russruffino.com with the subject line “Data Subject Request.” We will attempt to comply with your request. However, the nature of our business, along with the applicable law governing our business, requires us to retain your information for several years. Please also note that we may need to retain certain information for recordkeeping purposes and/or to complete any transactions that you began prior to requesting a change or deletion (e.g., when you make a purchase or enter a promotion, you may not be able to change or delete the personal information provided until after the completion of such purchase or promotion). There may also be residual information that will remain within our databases and other records, which will not be removed.As a result, we cannot guarantee the deletion of all your information. But, when we receive a deletion request, we will remove your applicable information from our marketing and billing systems accordingly. This will ensure that there are no further mailings or billings directed towards you.As we continue to refine our systems, we will establish a method for the complete removal of all user information from the system without compromising our legal and ethical duties. This document will evolve as these new methods are defined and tested for permanent account deletion.For your protection, we may only implement requests with respect to the personal information associated with the particular email address that you use to send us your request, and we may need to verify your identity before implementing your request. We will try to comply with your request as soon as reasonably practicable Your choices regarding our use and disclosure of informatio We may use the information you provide for marketing purposes such as promotional emailing, direct mail, and sales contacts. We give you many choices regarding our use and disclosure of your personal information for marketing purposes. You may opt-out from receiving electronic communications from us if you are a user of products or services and no longer want to receive marketing-related emails from us on a going-forward basis, you may opt-out of receiving these marketing-related emails by sending a request for list removal to support@russruffino.com. If you have provided your information to us, and opt-out, we will put in place processes to honor your request. This may entail keeping some information for the purpose of remembering that you have opted-out.We will try to comply with your request(s) as soon as reasonably practicable. Please also note that if you do opt-out of receiving marketing-related emails from us, we may still send you messages for administrative or other purposes directly relating to your use of the products or services, and you cannot opt-out from receiving those messages    Data Retention We will retain your personal information for as long as needed or permitted in light of the purpose(s) for which it was obtained and consistent with applicable law. The criteria used to determine our retention periods includ",
                                    textAlign: TextAlign.start,
                                  ),
                                ))),
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: unFocus,
        child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppTheme.colors.appDarkBlue,
              body: Stack(
                  children: [

                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: [
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: profile()),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Card(
                              color: AppTheme.colors.loginWhite,
                              child: ExpansionTile(
                                  backgroundColor: AppTheme.colors.loginWhite,
                                  title: Text(
                                    "Trash",
                                    style: TextStyle(color: AppTheme.colors.appDarkBlue),
                                  ),
                                  leading: Icon(
                                    Icons.delete_forever_rounded,
                                    color: AppTheme.colors.appDarkBlue,
                                  ),
                                  trailing: RotatedBox(
                                      quarterTurns: 1,
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppTheme.colors.appDarkBlue,
                                      )),
                                  children: [
                                    trashList(),
                                  ]),
                            ),
                          ),
                          //changepassword
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: changePassword()),
                          //terms&condition
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: termsCondition()),
                          //privacypolicy
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: privacyPolicy()),
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
                  ]
              )
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    emailController = TextEditingController();
    passwordController1 = TextEditingController();
    passwordController2 = TextEditingController();
    _inspector = Inspector();
    _notificationList = [];
    getContactDetails();
    getTrashNotifications();
  }

  getTrashNotifications() async{
    try{
      _notificationList = await inspectorRepository.getTrashNotificationList();
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }


  getContactDetails() async{
    try{
      _inspector = await inspectorRepository.getInspectorDetailsLocal();
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }

  validate() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        changePasswordApi();
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  changePasswordApi() async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await inspectorRepository.changePassword(
          emailController.text,passwordController1.text,passwordController2.text
      );

      if(response!.statusCode == 200 || response.statusCode == 201 ){
        Fluttertoast.showToast(msg: 'Password reset success');
      }
      else if(response.statusCode == 303 || response.statusCode == 401 ){
        inspectorRepository.clear();
        inspectorRepository.setInspectorLoggedIn(false);
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
      else if(response.statusCode == 400){
        Fluttertoast.showToast(msg: 'Password reset error');
      }
      else{
        Fluttertoast.showToast(msg: 'Password reset error');
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: 'Password reset error , ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }
}
