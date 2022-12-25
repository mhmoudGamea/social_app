import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/screens/user/sign_up_screen.dart';
import 'package:social_app/services/authentications.dart';
import 'package:social_app/widgets/button_widget.dart';

import '../../providers/user_data_provider.dart';
import '../../widgets/custom_text_button_row.dart';
import '../../widgets/custom_text_form.dart';

class SignInScreen extends StatefulWidget {
  static const String rn = '/sign_in_screen';

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  var isLoading = false;

  void submitForm() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await Authentications.signInUserByEmailAndPassword(email!, password!);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = Provider.of<UserDataProvider>(context).getDarkMode;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.white]),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            children: [
              CustomTextButtonRow(
                text: 'Don\'t have an account?',
                buttonText: 'Get Started',
                navigate: () {
                  Navigator.of(context).pushNamed(SignUpScreen.rn);
                },
              ),
              const SizedBox(height: 40),
              Text(
                'Htchat',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Welcome Back',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextForm(
                                  hint: 'Your email',
                                  type: TextInputType.emailAddress,
                                  onChange: (value) => email = value,
                                  borderColor: darkMode ? Colors.grey.withOpacity(0.5): Colors.black,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextForm(
                                  hint: 'Your password',
                                  type: TextInputType.visiblePassword,
                                  isObscure: true,
                                  onChange: (value) => password = value,
                                  borderColor: darkMode ? Colors.grey.withOpacity(0.5): Colors.black,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter password';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 15),
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                      )
                                    : ButtonWidget(
                                        radius: 8,
                                        firstGradient: Colors.black,
                                        secondGradient: Colors.grey.withOpacity(0.6),
                                        text: 'Sign in',
                                        textSize: 17,
                                        textColor: Colors.white,
                                        function: submitForm,
                                      ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
