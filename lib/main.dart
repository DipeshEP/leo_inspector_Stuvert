import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leo_inspector/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setupServiceLocator();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp( MyApp());
}
