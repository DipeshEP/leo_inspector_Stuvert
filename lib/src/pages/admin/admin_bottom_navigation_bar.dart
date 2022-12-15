
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leo_inspector/Services2/Repository/admin_repo.dart';
import 'package:leo_inspector/src/appcolors/colors.dart';
import 'package:leo_inspector/src/pages/admin/home/admin_home_page.dart';
import 'package:leo_inspector/src/pages/admin/notification/admin_notification.dart';
import 'package:leo_inspector/src/pages/admin/qr/admin_qrcode_scanner.dart';
import 'package:leo_inspector/src/pages/admin/settings/admin_settings_page.dart';
import 'package:leo_inspector/src/pages/home_page.dart';

import 'custom_widgets/dialogs/custom_dialog.dart';

class AdminBottomNavigationBarPage extends StatefulWidget {
  const AdminBottomNavigationBarPage({Key? key}) : super(key: key);

  @override
  State<AdminBottomNavigationBarPage> createState() => _AdminBottomNavigationBarPageState();
}

int _selectedIndex = 0;

class _AdminBottomNavigationBarPageState extends State<AdminBottomNavigationBarPage> {

  final AdminRepository adminRepository = AdminRepository();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    const AdminHomePage(),
    const AdminQrView(),
    const AdminBottomNavigationNotificationPage(),
    const AdminSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
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
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(
                                "Do you wish to logout?",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.colors.appDarkBlue),
                              ),
                              backgroundColor: AppTheme.colors.loginWhite,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      adminRepository.clear();
                                      adminRepository.setAdminLoggedIn(false);

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) => const HomePage()),
                                              (Route<dynamic> route) => false);
                                    },
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.colors.appDarkBlue),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color:
                                            AppTheme.colors.appDarkBlue)))
                              ],
                            ));
                      },
                      icon: Icon(
                        Icons.power_settings_new_sharp,
                        color: AppTheme.colors.logoColor,
                      ),
                    ))
              ],
            ),
          ),
          backgroundColor: AppTheme.colors.loginWhite,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppTheme.colors.appDarkBlue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code_scanner),
                label: "Qr Code",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: "Notifications",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded),
                label: "Settings",
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppTheme.colors.appDarkBlue,
            unselectedItemColor: AppTheme.colors.grey,
            elevation: 1,
            onTap: _onItemTapped,
          ),
          body: screens[_selectedIndex],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() async{
    return showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (_) {
          return CustomDialog(
            title: 'Exit!',
            subtitle: 'Do you want to exit app?',
            yesTitle: 'Yes',
            noTitle: 'No',
            yes: () {
              Navigator.pop(context, true);
              return true;
            },
            no: () {
              Navigator.pop(context, false);
              return false;
            },
          );
        }).then((x) => x ?? false);
  }
}
