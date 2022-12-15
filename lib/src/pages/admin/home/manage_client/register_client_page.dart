import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_inspector/Model/client_model.dart';
import 'package:leo_inspector/Model/company_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';
import 'client_detail_page.dart';


class RegisterClientPage extends StatefulWidget {
  final Function() onBackPressed;

  const RegisterClientPage({Key? key,required this.onBackPressed}) : super(key: key);

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isLoading,toggle,isEnabled;
  final AdminRepository adminRepository = AdminRepository();

  late Company? _company;
  File ? _proImage;

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  late TextEditingController _compNameField;
  late TextEditingController _compIdField ;
  late TextEditingController _compEmailField ;
  late TextEditingController _compContField ;
  late TextEditingController _compConPersonField ;
  late TextEditingController _compAddField ;


  Future proPickImage() async{
    try{
      final proImage = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality: 60);
      if(proImage == null){
        return;
      }
      final imageTemporary=File(proImage.path);
      setState(()=> _proImage=imageTemporary);
    }
    on PlatformException {

      return "Failed to Pick";
    }
  }


  Widget companyNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _compNameField,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        disabledBorder: InputBorder.none,
        focusColor: AppTheme.colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.white)),
        filled: true,
        fillColor: AppTheme.colors.white,
        label: Text(
          "Company Name",
          style: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      ),
      validator: (name) {
        if (name?.length == 0) {
          return "Please Enter Your Name";
        } else if (name?.length == 1 || name?.length == 2 || name?.length == 3) {
          return "Please Enter Atleast Four Letters";
        }
        null;
      },
    );
  }

  Widget companyIdField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _compIdField,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        disabledBorder: InputBorder.none,
        focusColor: AppTheme.colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.white)),
        filled: true,
        fillColor: AppTheme.colors.white,
        label: Text(
          "Company Id",
          style: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      ),
      validator: (id) {
        if (id?.length == 0) {
          return "Please Enter Your Employee ID";
        } else if (id?.length == 1 || id?.length == 2 || id?.length == 3) {
          return "Please Enter Atleast Four Letters";
        }
        null;
      },
    );
  }

  Widget companyEmailIdField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _compEmailField,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        disabledBorder: InputBorder.none,
        focusColor: AppTheme.colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.white)),
        filled: true,
        fillColor: AppTheme.colors.white,
        label: Text(
          "Company Email Address",
          style: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      ),
      validator: (mail) {
        if (mail?.length == 0) {
          return "Please Enter Your Email ID";
        } else if (mail?.length == 1 || mail?.length == 2 || mail?.length == 3) {
          return "Please Enter Correct Email ID";
        }
        null;
      },
    );
  }

  Widget companyContactField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: _compContField,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        disabledBorder: InputBorder.none,
        focusColor: AppTheme.colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.colors.white)),
        filled: true,
        fillColor: AppTheme.colors.white,
        label: Text(
          "Contact Number",
          style: GoogleFonts.inter(
              color: AppTheme.colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      ),
      validator: (num) {
        if (num?.length == 0) {
          return "Please Enter Your Number";
        } else if (num?.length == 1 || num?.length == 2 || num?.length == 3) {
          return "Please Enter Correct Number";
        }
        null;
      },
    );
  }

  // Widget contactPersonField() {
  //   return TextFormField(
  //     textInputAction: TextInputAction.next,
  //     controller: _compConPersonField,
  //     keyboardType: TextInputType.name,
  //     decoration: InputDecoration(
  //       contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
  //       disabledBorder: InputBorder.none,
  //       focusColor: AppTheme.colors.white,
  //       focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: AppTheme.colors.white)),
  //       filled: true,
  //       fillColor: AppTheme.colors.white,
  //       label: Text(
  //         "Name of the Contact Person",
  //         style: GoogleFonts.inter(
  //             color: AppTheme.colors.black,
  //             fontSize: 13,
  //             fontWeight: FontWeight.w400),
  //       ),
  //       border: OutlineInputBorder(
  //           borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
  //     ),
  //     validator: (persName) {
  //       if (persName?.length == 0) {
  //         return "Please Enter The Name";
  //       } else if (persName?.length == 1 ||
  //           persName?.length == 2 ||
  //           persName?.length == 3) {
  //         return "Please Enter Atleast Four Letters";
  //       }
  //       null;
  //     },
  //   );
  // }
  //
  // Widget companyAddressField() {
  //   return TextFormField(
  //     textInputAction: TextInputAction.done,
  //     controller: _compAddField,
  //     style: TextStyle(
  //         color: AppTheme.colors.black,
  //         fontWeight: FontWeight.w400,
  //         fontSize: 15),
  //     maxLines: 5,
  //     maxLength: 500,
  //     decoration: InputDecoration(
  //       disabledBorder: InputBorder.none,
  //       focusColor: AppTheme.colors.white,
  //       focusedBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: AppTheme.colors.white)),
  //       filled: true,
  //       fillColor: AppTheme.colors.white,
  //       label: Text(
  //         "Company Address",
  //         style: GoogleFonts.inter(
  //             color: AppTheme.colors.black,
  //             fontSize: 13,
  //             fontWeight: FontWeight.w400),
  //       ),
  //       border: OutlineInputBorder(
  //           borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
  //     ),
  //     validator: (addrss) {
  //       if (addrss?.length == 0) {
  //         return "Please Enter The Company Address";
  //       } else if (addrss?.length == 1 ||
  //           addrss?.length == 2 ||
  //           addrss?.length == 3 ||
  //           addrss?.length == 4) {
  //         return "Please Enter Full Address";
  //       }
  //       null;
  //     },
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEnabled = true;
    isLoading = false;
    toggle = false;
    _compNameField = TextEditingController();
    _compIdField = TextEditingController();
    _compEmailField = TextEditingController();
    _compContField = TextEditingController();
    _compConPersonField = TextEditingController();
    _compAddField = TextEditingController();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    getCompanyDetails();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocus,
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
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onBackPressed();
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
        backgroundColor: AppTheme.colors.appDarkBlue,
          body: Stack(
              children: [
                Positioned(
                  top: 70,
                  left: 10,
                  right: 10,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(10),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.75,
                          width:  MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            color: Color(0XFFECE9E6),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 80,
                                ),

                                Text(
                                  "Add Client",
                                  style: GoogleFonts.inter(
                                      fontSize: 26, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                  child: companyNameField(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                  child: companyIdField(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                  child: companyEmailIdField(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                  child: companyContactField(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                //   child: contactPersonField(),
                                // ),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                //   child: companyAddressField(),
                                // ),
                                const SizedBox(
                                  height: 0,
                                ),
                                NeumorphicButton(
                                  style: NeumorphicStyle(
                                      color: AppTheme.colors.loginWhite,
                                      shape: NeumorphicShape.concave,
                                      depth: 15,
                                      surfaceIntensity: .5,
                                      boxShape: const NeumorphicBoxShape.circle()),
                                  onPressed: () {
                                    validate();
                                  },
                                  child: SizedBox(
                                      height: 55,
                                      child: Image.asset("assets/icons/save.png")),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),


                              ],
                            ),
                          )),
                    ),
                  ),
                ),

                Positioned(
                    top: 20,
                    left: 140,
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                        ),
                        child: _proImage != null ?
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(_proImage!),
                                  fit: BoxFit.cover
                              )
                          ),
                        )
                            : Icon(Icons.person,color: AppTheme.colors.appDarkBlue,size:50)
                    )
                ),

                Positioned(
                  top: 100,
                  left: 210,
                  child: ElevatedButton(
                    onPressed: () {
                      proPickImage();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: const Color(0XFFA5A5A5)),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: AppTheme.colors.appDarkBlue,
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
              ]
          )

/*          body: Stack(
              children: [

                Center(
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        color: AppTheme.colors.loginWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Add Client",
                                style: GoogleFonts.inter(
                                    fontSize: 26, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: companyNameField(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: companyIdField(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: companyEmailIdField(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: companyContactField(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: contactPersonField(),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 35.5, right: 35.5),
                                child: companyAddressField(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              NeumorphicButton(
                                style: NeumorphicStyle(
                                    color: AppTheme.colors.loginWhite,
                                    shape: NeumorphicShape.concave,
                                    depth: 15,
                                    surfaceIntensity: .5,
                                    boxShape: const NeumorphicBoxShape.circle()),
                                onPressed: () {
                                  validate();
                                },
                                child: SizedBox(
                                    height: 55,
                                    child: Image.asset("assets/icons/save.png")),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                            ],
                          ),
                        ),
                      )),
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
          )*/
      ),
    );
  }

  getCompanyDetails() async{
    try{
      _company = await adminRepository.getCompanyDetailsLocal();
      if(_company != null && _company!.companyId != null){
        _compIdField.text = _company!.companyId.toString();
      }
    }
    catch(e){
      print(e.toString());
    }
  }

  validate() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if(_proImage != null){
          addClient();
        }
        else{
          Fluttertoast.showToast(msg: 'Please upload necessary images');
        }
      }
    }
    catch(e){
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  addClient() async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await adminRepository.addClient(
        // _compNameField.text,_compContField.text,_compEmailField.text,_compConPersonField.text,_compAddField.text,_compIdField.text,_proImage!
        _compNameField.text,_compContField.text,_compEmailField.text,_compIdField.text,_proImage!
      );
      if(response!.statusCode == 200 || response.statusCode == 201 ){
        Fluttertoast.showToast(msg: 'Success');
        ClientListModel clientModel = ClientListModel.fromJson(response.data);

        _compNameField.text = '';
        _compEmailField.text = '';
        _compContField.text = '';
        _proImage = null;
        _compAddField.text = '';
        _compConPersonField.text = '';

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ClientDetailPage(
              client: clientModel.client,
              onDelete: (){
                Navigator.pop(context);
              },
              onBackPressed: (){

              },
            )));
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
      else if(response.statusCode == 404){
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Error!',
                subtext: (response.data['message'] != null) ? response.data['message'].toString().toUpperCase() : '',
                ok: () {
                  Navigator.pop(context, true);
                  return true;
                },
              );
            });
      }
      else if(response.statusCode == 500 ){
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Error!',
                subtext: (response.data['error'] != null) ? response.data['error'].toString().toUpperCase() : '',
                ok: () {
                  Navigator.pop(context, true);
                  return true;
                },
              );
            });
      }
      else{
        //print(response.data);
        showDialog(
            context: context,
            //barrierDismissible: false,
            builder: (_) {
              return InfoDialog(
                message: 'Error!',
                subtext: 'Please try again',
                ok: () {
                  Navigator.pop(context, true);
                  return true;
                },
              );
            });
      }
      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e.toString());
      showDialog(
          context: context,
          //barrierDismissible: false,
          builder: (_) {
            return InfoDialog(
              message: 'Error !',
              subtext: e.toString(),
              ok: () {
                Navigator.pop(context, true);
                return true;
              },
            );
          });
      setState(() {
        isLoading = false;
      });
    }
  }
}
