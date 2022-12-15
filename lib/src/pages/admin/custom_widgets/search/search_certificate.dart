import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leo_inspector/Services2/size_config.dart';

import '../../../../../Model/certificate_model.dart';
import '../../../../../Model/client_model.dart';
import '../../../../../Services2/Repository/admin_repo.dart';
import '../../../../../data/constants.dart';
import '../../../../appcolors/colors.dart';
import '../../../home_page.dart';
import '../../home/manage_certificate/pdf_viewer.dart';
import '../dialogs/info_dialog.dart';


class SearchCertificate extends StatefulWidget {
  final Client? client;
  const SearchCertificate({Key? key,required this.client}) : super(key: key);

  @override
  _SearchCertificateState createState() => _SearchCertificateState();
}

class _SearchCertificateState extends State<SearchCertificate> {

  late bool isLoading;

  late List<Certificate> _certificateList;
  final AdminRepository adminRepository = AdminRepository();
  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    textEditingController = TextEditingController();
    _certificateList = [];
  }

  getCertificateList(String q) async{
    try{

      if(q != "" || q != null){
        setState(() {
          isLoading = true;
        });
        Response? response = await adminRepository.getCertificateList(widget.client!.clientId!,q);
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
      }
      else{
        _certificateList.clear();
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

  Widget certificateListTile() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: SizeConfig.blockSizeVertical*80,
      child: ListView.builder(
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
          }),
    );
  }

  Widget searchBar(){
    return Container(
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.blockSizeHorizontal * 92,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        controller: textEditingController,
        autofocus: false,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 14,
        ),
        onFieldSubmitted: (val) {

        },
        onChanged: (v) {
          EasyDebounce.debounce('Search-Debounce', const Duration(milliseconds: 500), () {
            getCertificateList(v);
          });
        },
        decoration: InputDecoration(
          hintText: 'Search here ...',
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
          suffixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(
              top: SizeConfig.blockSizeHorizontal * 5,
              bottom: SizeConfig.blockSizeHorizontal * 5,
              right: SizeConfig.blockSizeHorizontal * 2,
              left: SizeConfig.blockSizeHorizontal * 5),
          errorStyle: const TextStyle(color: Colors.red),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              borderSide:
              BorderSide(color: Colors.red[400]!, width: 2)),
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              borderSide:
              BorderSide(color: Colors.red[400]!, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              borderSide:
              BorderSide(color: Colors.transparent, width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              borderSide:
              BorderSide(color: Colors.transparent, width: 1)),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              borderSide:
              BorderSide(color: Colors.transparent, width: 1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppTheme.colors.appDarkBlue,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(
                height: SizeConfig.blockSizeVertical*3,
              ),

              searchBar(),

              SizedBox(
                height: SizeConfig.blockSizeVertical*3,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.blockSizeVertical*80,
                child: Stack(
                  children: [
                    certificateListTile(),

                    (isLoading)? Container(
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.blockSizeVertical*80,
                      color: Colors.black.withOpacity(0.3),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ): Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
