
import 'dart:io';


import 'package:avatar_view/avatar_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leo_inspector/Model/inspector_model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/manage_inspector/inspector_profile_page.dart';

import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../home_page.dart';
import '../../custom_widgets/dialogs/info_dialog.dart';
import '../../../../../Model/inspector_model2.dart';


class AddInspectorScreen extends StatefulWidget {

  final Function() onBackPressed;
  const AddInspectorScreen({Key? key,required this.onBackPressed}) : super(key: key);

  @override
  State<AddInspectorScreen> createState() => _AddInspectorScreenState();
}
// final data = Provider.of<InspectorPost>(context);

//final formKey = GlobalKey<FormState>();


class _AddInspectorScreenState extends State<AddInspectorScreen> {

  // Initial Selected Value
  String dropdownvalue = 'InspectorOnly';

  // List of items in our dropdown menu
  var items = [
    'InspectorOnly',
    'InspectorSignetory',
  ];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool isLoading,toggle,isEnabled;
  File ? _proImage;
  File ? _signatureImage;

  late TextEditingController _nameField;
  late TextEditingController _empIdField;
  late TextEditingController _contactNumberField;
  late TextEditingController _emailAddressField;

  final AdminRepository adminRepository = AdminRepository();

  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget selectInspectorType(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration:   BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        //borderRadius: BorderRadius.all( Radius.circular(SizeConfig.blockSizeVertical*5)),
      ),
      child: Center(
        child: DropdownButton(

          // Initial Value
          value: dropdownvalue,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          underline: SizedBox(),
          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items,style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      ),
    );

  }

  Widget inspectorNameField() {
    return TextFormField(
      controller: _nameField,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(

        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        // ),
        fillColor: Colors.white,
        filled: true,
        labelText: "Name",
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "required";
        }
        else if(value.length<=3)
        {
          return "4 character required ";
        }
        null;
        return null;
      },
    );
  }

  Widget inspectorEmpId() {
    return TextFormField(

      controller: _empIdField,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        // ),
        fillColor: Colors.white,
        filled: true,
        labelText: "Emp Id",
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "required";
        }
        else if(value.length<=3)
        {
          return "4 character required ";
        }
        null;
        return null;
      },
    );
  }

  Widget inspectorConNum() {
    return TextFormField(
      controller: _contactNumberField,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        // ),
        fillColor: Colors.white,
        filled: true,
        labelText: "Contact Number",
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "required";
        }
        else if(value.length<=3)
        {
          return "4 character required ";
        }
        null;
        return null;
      },
    );
  }

  Widget inspectorEmail(){
    return TextFormField(

      controller: _emailAddressField,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // enabledBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        // ),
        fillColor: Colors.white,
        filled: true,
        labelText: "Email Address",
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "email required";
        }

        null;
        return null;
      },
    );
  }

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality: 60);
      if(image == null){
        return;
      }
      final imageTemporary = File(image.path);
      setState(()=> this._signatureImage=imageTemporary);
    }
    on PlatformException {

      return "Failed to Pick";
    }
  }

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


// Widget editButton(context){
//   return NeumorphicButton(
//     style: NeumorphicStyle(
//       shadowLightColor: AppTheme.colors.buttonWhite,
//         color:AppTheme.colors.loginWhite,
//       shape: NeumorphicShape.concave,
//       depth: 15,
//       surfaceIntensity: 0.5,
//       boxShape: NeumorphicBoxShape.circle()),
//     onPressed: (){
//       // Navigator.push(
//       // context,
//       // MaterialPageRoute(
//       //
//       // builder: (context) => const InspectorProfilePage()));
//   },
//
// child: SizedBox(
// height: 55,
// child: Icon(Icons.edit,color: AppTheme.colors.appDarkBlue,size: 35,)
// ) );
//
// }

  Widget saveButtonField(context) {
    return NeumorphicButton(
        style: NeumorphicStyle(
            shadowLightColor: AppTheme.colors.buttonWhite,
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
          child: Image.asset("assets/icons/save.png",height: 35,width: 35),
        ) );

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEnabled = true;
    isLoading = false;
    toggle = false;
    _nameField = TextEditingController();
    _empIdField = TextEditingController();
    _contactNumberField = TextEditingController();
    _emailAddressField = TextEditingController();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocus,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppTheme.colors.appDarkBlue,
            appBar: AppBar(
              backgroundColor: AppTheme.colors.appDarkBlue,
              leadingWidth: 400,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 2, bottom: 3),
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
                    child:

                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(onPressed: (){
                        Navigator.pop(context);
                        widget.onBackPressed();
                        // push(context,MaterialPageRoute(builder: (context)=>const ManageInpectorHomePage()));
                      },
                        icon: Icon(Icons.double_arrow,
                          size: 30,
                          color: AppTheme.colors.logoColor,),),
                    )
                ),
              ],
            ),
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
                                    height: 50,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 38, left: 20, right: 20),
                                    child: inspectorNameField(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    child: inspectorEmpId(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    child: inspectorConNum(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    child: inspectorEmail(),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    child: selectInspectorType(),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 35, right: 35),
                                    child: SizedBox(
                                        height: 50,
                                        width: 300,
                                        child: _signatureImage!=null ?Image.file(_signatureImage!):Icon(Icons.image,color: AppTheme.colors.appDarkBlue,size:50 ,)
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 35, right: 35),
                                    child: InkWell(
                                      onTap: (){
                                        pickImage();
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AppTheme.colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppTheme.colors.white,
                                        ),
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children:[

                                              Icon(
                                                Icons.cloud_upload,
                                                size: 30,
                                                color: AppTheme.colors.appDarkBlue,
                                              ),

                                              // const  SizedBox(height: 5,),
                                              Text("Upload Signature", style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: AppTheme.colors.black
                                              ),)
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      saveButtonField(context),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),


                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  /*Positioned(
                    top: 20,
                    left: 140,
                    child: AvatarView(
                      radius: 60,
                      borderColor: Colors.yellow,
                      avatarType: AvatarType.CIRCLE,
                      backgroundColor: Colors.red,
                      imagePath:
                      "https://images.pexels.com/ptos/415829/pexels-photo-415829.jpeg?cs=srgb&dl=pexels-pixabay-415829.jpg",
                      placeHolder: Container(
                        child: Icon(Icons.person, size: 50,),
                      ),
                      errorWidget: Container(
                        child: Icon(Icons.error, size: 50,),
                      ),
                    ),
                  ),*/

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
        ),
      ),
    );

  }

  validate() async{
    try{
      if ( _formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        if(_proImage != null && _signatureImage != null){
          addInspector();
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

  addInspector() async{
    try{
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).requestFocus(FocusNode());

      Response? response = await adminRepository.addInspector(
        _nameField.text,_contactNumberField.text,_signatureImage!,_proImage!,_emailAddressField.text,_empIdField.text,dropdownvalue
      );

      if(response!.statusCode == 200 || response.statusCode == 201 ){

        Fluttertoast.showToast(msg: 'Success');
        InspectorModel inspectorResponseModel = InspectorModel.fromJson(response.data);

        _nameField.text = '';
        _contactNumberField.text = '';
        _signatureImage = null;
        _proImage = null;
        _emailAddressField.text = '';
        _empIdField.text = '';

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InspectorProfilePage(
              inspector: inspectorResponseModel.inspector,
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
      else if(response.statusCode == 400 || response.statusCode == 404){
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
