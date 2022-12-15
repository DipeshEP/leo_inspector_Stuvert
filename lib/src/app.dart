import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leo_inspector/bloc/login/admin/admin_login_cubit.dart';
import 'package:leo_inspector/bloc/login/client/client_login_cubit.dart';
import 'package:leo_inspector/bloc/login/guest/guest_login_cubit.dart';
import 'package:leo_inspector/bloc/login/inspector/inspector_login_cubit.dart';
import 'package:leo_inspector/data/login/admin/api.dart';
import 'package:leo_inspector/data/login/admin/repository.dart';
import 'package:leo_inspector/data/login/client/api.dart';
import 'package:leo_inspector/data/login/client/repository.dart';
import 'package:leo_inspector/data/login/guest/api.dart';
import 'package:leo_inspector/data/login/guest/repository.dart';
import 'package:leo_inspector/data/login/inspector/api.dart';
import 'package:leo_inspector/data/login/inspector/repository.dart';
import 'package:leo_inspector/src/pages/splash_screen.dart';

import '../services/dio/dioservices.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final adminLoginRepository = AdminLoginRepository(AdminLoginApi(DioClient()));
  final inspectorLoginRepository = InspectorLoginRepository(InspectorLoginApi(DioClient()));
  final clientLoginRepository = ClientLoginRepository(ClientLoginApi(DioClient()));
  final guestLoginRepository = GuestLoginRepository(GuestLoginApi(DioClient()));
  // final adminProfileRepository = AdminProfileRepository(AdminProfileApi(DioClient()));
  // final manageInspectorRepository = ManageInspectorRepository(ManageInspectorApi(DioClient()));
  // final manageClientRepository = ManageClientRepository(ManageClientApi(DioClient()));

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AdminLoginCubit(adminLoginRepository)),
        BlocProvider(
            create: (context) => InspectorLoginCubit(inspectorLoginRepository)),
        BlocProvider(
            create: (context) => ClientLoginCubit(clientLoginRepository)),
        BlocProvider(
            create: (context) => GuestLoginCubit(guestLoginRepository)),
        // BlocProvider(
        //     create: (context) => AdminProfileCubit(adminProfileRepository)),
        // // BlocProvider(
        // create: (context) => ManageInspectorCubit(manageInspectorRepository)),
        // BlocProvider(
        //     create: (context) => ManageClientCubit(manageClientRepository)),


      ],
      // MultiProvider(
      // providers: [
      //   ChangeNotifierProvider(create: (context) => getIt<AuthManager>()),
      //   ChangeNotifierProvider(create: (context) => getIt<ClientLoginManager>()),
      //   ChangeNotifierProvider(create: (context) => getIt<GuestManager>()),
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //
      // ],
      child: MaterialApp(
        title: 'LEO',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
// home:Check()  ,
        home: const SplashScreen(),
        //   home:PdfGeneratedPreview(),
        //    home:PdffView(),
      ),
    );
  }
}
