import 'package:amit_interview/utils/custom_snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../controllers/auth_notiefier.dart';
import '../utils/labeled_textfield.dart';
import '../utils/spacing.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logo(),
              vSpace(20),
              labelTextField(
                label: 'Email',
                textController: emailController,
                hint: "Email",
                validator: (value) {
                  final val = value?.trim();
                  if (val == null) {
                    return 'Please enter a email!';
                  }
                  if (val.length < 6) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              vSpace(12),
              labelTextField(
                label: 'Password',
                textController: passwordController,
                hint: " Password",
                validator: (value) {
                  final val = value?.trim();
                  if (val == null) {
                    return 'Please enter a password!';
                  }
                  if (val.length < 6) {
                    return 'Password should be atleast 6 characters';
                  }
                  return null;
                },
              ),
              vSpace(20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        try {
                          await ref.read(authNotifierProvider.notifier).signIn(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                          await Navigator.pushReplacementNamed(
                              context, '/home');
                          emailController.clear();
                          passwordController.clear();
                        } on Exception catch (e) {
                          final snack =
                              CustomSnackbars.dangerSnackbar(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
              vSpace(16),
              orDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signup');
                    },
                    child: const Text('Create new'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Row orDivider() {
    return Row(
      children: [
        const Expanded(
            child: Divider(
          color: AppColors.blue,
        )),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'or',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        const Expanded(
            child: Divider(
          color: AppColors.blue,
        )),
      ],
    );
  }
}
