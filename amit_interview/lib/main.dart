import 'package:amit_interview/controllers/auth_notiefier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_theme.dart';
import 'firebase_options.dart';
import 'homescreen.dart';
import 'utils/custom_navigator.dart';
import 'views/view.signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: Consumer(
        builder: (context, watch, child) {
          final user = watch.read(authNotifierProvider.notifier).user;
          print(user);
          if (user == null) {
            return SignUpView();
          } else {
            return HomeScreen();
          }
        },
      ),
      builder: customNavigator,
    );
  }
}
