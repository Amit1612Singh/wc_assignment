import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/auth_notiefier.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!'),
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
