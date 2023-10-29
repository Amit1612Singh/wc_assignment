import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants.dart';
import '../controllers/auth_notiefier.dart';
import '../utils/custom_snackbars.dart';
import '../utils/labeled_textfield.dart';
import '../utils/spacing.dart';

class SignUpView extends ConsumerWidget {
  SignUpView({super.key});

  final nameController = TextEditingController();
  final UsernameController = TextEditingController();
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
              vSpace(MediaQuery.of(context).size.height * .05),
              logo(),
              vSpace(20),
              labelTextField(
                label: 'Username',
                textController: nameController,
                hint: 'Username',
                validator: (value) {
                  final val = value?.trim();
                  if (val == null) {
                    return 'Please enter a name!';
                  }
                  if (val.length < 4) {
                    return 'Password should be atleast 4 characters';
                  }
                  return null;
                },
              ),
              vSpace(12),
              labelTextField(
                label: 'Email',
                textController: UsernameController,
                hint: 'Email',
                validator: (value) {
                  final val = value?.trim();
                  if (val == null) {
                    return 'Please enter a email!';
                  }
                  if (val.length < 6) {
                    return 'Please enter a valid Email';
                  }
                  return null;
                },
              ),
              vSpace(12),
              labelTextField(
                label: 'Password',
                textController: passwordController,
                hint: 'Password',
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
              createAccountButton(context, ref, formKey),
              vSpace(16),
              orDivider(),
              alreadyHaveAccountText(context),
              Spacer(),
              AccountTermsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Row createAccountButton(
      BuildContext context, WidgetRef ref, GlobalKey<FormState> formKey) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (!formKey.currentState!.validate()) {
                return;
              }
              try {
                await ref.read(authNotifierProvider.notifier).signUp(
                      email: UsernameController.text,
                      password: passwordController.text,
                    );
                Navigator.pushReplacementNamed(context, '/login');
                UsernameController.clear();
                passwordController.clear();
              } on Exception catch (e) {
                final snack = CustomSnackbars.dangerSnackbar(e.toString());
                ScaffoldMessenger.of(context).showSnackBar(snack);
              }
            },
            child: const Text('Create Account'),
          ),
        ),
      ],
    );
  }

  Row alreadyHaveAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?'),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  Row orDivider() {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: AppColors.blue,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'or',
            style:
                TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Divider(
          color: AppColors.blue,
        )),
      ],
    );
  }
}

class AccountTermsWidget extends StatelessWidget {
  const AccountTermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        children: <TextSpan>[
          const TextSpan(
            text: 'By creating an account you agree to our ',
          ),
          TextSpan(
            text: 'Terms & Conditions',
            style: const TextStyle(
              color: AppColors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('opened terms & conditions url');
              },
          ),
        ],
      ),
    );
  }
}
