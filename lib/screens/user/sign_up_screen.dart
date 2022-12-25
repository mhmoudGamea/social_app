import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/screens/user/sign_in_screen.dart';
import 'package:social_app/services/authentications.dart';

import '../../constants.dart';
import '../../providers/user_data_provider.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_text_button_row.dart';
import '../../widgets/custom_text_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String rn = '/sign_up_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? name;
  String? phone;
  String? password;
  var isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void submitForm() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await Authentications.createUserByEmailAndPassword(
          email: email!, name: name!, phone: phone!, password: password!);
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
                text: 'Already have an account?',
                buttonText: 'Sign in',
                navigate: () {
                  Navigator.of(context).pushNamed(SignInScreen.rn);
                },
              ),
              const SizedBox(height: 45),
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
                            'Get started free.',
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
                                  borderColor:
                                      darkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter email';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextForm(
                                  hint: 'Your name',
                                  onChange: (value) => name = value,
                                  borderColor:
                                      darkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                CustomTextForm(
                                  hint: 'Your phone',
                                  type: TextInputType.number,
                                  onChange: (value) => phone = value,
                                  borderColor:
                                      darkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'please enter phone';
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
                                  borderColor:
                                      darkMode ? Colors.grey.withOpacity(0.5) : Colors.black,
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
                                        text: 'Sign up',
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
