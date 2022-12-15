import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leo_inspector/Model/notification_model.dart' as m;
import 'package:leo_inspector/data/login/admin/model.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';

import '../../../../Services2/Repository/admin_repo.dart';
import '../../../../data/constants.dart';
import '../../home_page.dart';
import '../custom_widgets/dialogs/info_dialog.dart';


class AdminBottomNavigationNotificationPage extends StatefulWidget {
  const AdminBottomNavigationNotificationPage({Key? key}) : super(key: key);

  @override
  State<AdminBottomNavigationNotificationPage> createState() =>
      _AdminBottomNavigationNotificationPageState();
}

class _AdminBottomNavigationNotificationPageState
    extends State<AdminBottomNavigationNotificationPage> {

  late bool isLoading;
  late List<m.Notification> _notificationList;
  late List<m.Notification> _trashNotificationList;
  final AdminRepository adminRepository = AdminRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _notificationList = [];
    _trashNotificationList = [];
    getNotificationList();
    getTrashNotifications();
  }

  getTrashNotifications() async{
    try{
      _trashNotificationList = await adminRepository.getTrashNotificationList();
      setState(() {});
    }
    catch(e){
      print(e.toString());
    }
  }

  getNotificationList() async{
    try{
      setState(() {
        isLoading = true;
      });

      AdminLoginModel? adminLoginModel = await adminRepository.getAdminLoginResponse();
      Response? response = await adminRepository.getNotificationList(adminLoginModel!.userId);
      // _notificationList.clear();
      if(response!.statusCode == 200){
        var s1 = json.encode(response.data);
        // m.NotificationsModel? notificationModel = m.notificationsModelFromJson(s1);
        m.NotificationsModel notificationsModel=m.notificationsModelFromJson(s1) ;
        // _notificationList = notificationModel.notification!;
        _notificationList=notificationsModel.notification!;
        print("................admin.............");
        print(s1);
        print(_notificationList);
        return s1;
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
    getNotificationList();
    await Future.delayed(const Duration(seconds: 2), () {});
  }

  Widget adminNotificationPage() {
    return Container(
      height: MediaQuery.of(context).size.height*0.63,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0XFFECE9E6),
      ),
      child: (_notificationList.isNotEmpty) ?
      ListView.builder(
        itemCount: _notificationList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 1),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text(
                  (_notificationList[index].message != null) ? _notificationList[index].message! : '',
                ),
                /*subtitle: Text(
                    '_notificationList[index].message'
                ),*/
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          elevation: 2,
                          backgroundColor: AppTheme.colors.appDarkBlue,
                          title: const Text('Delete Notification',
                              style: TextStyle(
                                  color: Color.fromRGBO(236, 233, 230, 1))),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'Would you like to Delete of this Notification?',
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            236, 233, 230, 1))),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    color:
                                    Color.fromRGBO(236, 233, 230, 1)),
                              ),
                              onPressed: () {
                                setState(() {
                                  deleteNotification(_notificationList[index].notificationId!);
                                  _trashNotificationList.add(_notificationList[index]);
                                  _notificationList.removeAt(index);
                                  adminRepository.storeTrashNotificationList(_trashNotificationList);
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      color: Color.fromRGBO(
                                          236, 233, 230, 1))),
                            ),
                          ],
                        ));

                    //
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          );
        },
        // itemCount: data!.notification!.length,
      ): (!isLoading) ? const Center(
        child: Text('List is empty!'),
      ) : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.colors.appDarkBlue,
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
                            height: 10,
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Container(
                                height: MediaQuery.of(context).size.height*0.70,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0XFFECE9E6),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Text(
                                            "Notification",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 24),
                                          ),
                                        )),
                                    adminNotificationPage()
                                  ],
                                )),
                          ),

                          const  SizedBox(
                            height: 20,
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
    );
  }

  deleteNotification(String id) async{
    try{
      setState(() {
        isLoading = true;
      });
      Response? response = await adminRepository.deleteNotification(id);

      isLoading = false;
      setState(() {});

      if(response!.statusCode == 200){
        Fluttertoast.showToast(msg: 'Notification deleted');
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
        Fluttertoast.showToast(msg: 'Error deleting notification');
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
