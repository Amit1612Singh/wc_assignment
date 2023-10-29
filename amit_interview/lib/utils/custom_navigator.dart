import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../views/view.home.dart';
import '../views/view.login.dart';
import '../views/view.signup.dart';

Widget customNavigator(BuildContext context, Widget? child) => Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return _getPage(settings, context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          settings: settings,
        );
      },
    );

Widget _getPage(RouteSettings settings, BuildContext context) {
  if (settings.name == '/signup') {
    return SignUpView();
  } else if (settings.name == '/login') {
    return LoginView();
  } else if (settings.name == '/home') {
    return const HomeView();
  }
  // Add more routes as needed
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return SignUpView(); // Default page if route not found
  } else {
    return HomeView();
  }
}
