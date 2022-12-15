import 'package:flutter/material.dart';
import 'package:leo_inspector/Model/notification_model.dart' as m;
import 'package:leo_inspector/src/appcolors/colors.dart';
import '../../../../../data/constants.dart';


class ViewTrash extends StatefulWidget {
  final List<m.Notification> notificationList;
  const ViewTrash({Key? key,required this.notificationList}) : super(key: key);

  @override
  State<ViewTrash> createState() =>
      _ViewTrashState();
}

class _ViewTrashState
    extends State<ViewTrash> {

  late bool isLoading;
  late List<m.Notification> _notificationList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
    _notificationList = widget.notificationList;
  }

  Widget inspectorNotificationList() {
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
      child: ListView.builder(
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
              ),
            ),
          );
        },
        // itemCount: data!.notification!.length,
      ),
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
                                inspectorNotificationList()
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
            ),
          ),
        ),
      ),
    );
  }
}
