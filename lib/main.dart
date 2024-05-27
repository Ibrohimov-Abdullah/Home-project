import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_learning_part2/firebase_options.dart';
import 'package:firebase_learning_part2/pages/auth_gate.dart';
import 'package:firebase_learning_part2/pages/auth_pages/check_email_page.dart';
import 'package:firebase_learning_part2/pages/home_page.dart';
import 'package:firebase_learning_part2/pages/auth_pages/register_page.dart';
import 'package:firebase_learning_part2/pages/auth_pages/upload_photo_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  FlutterError.onError = (errorDetail) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetail);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
