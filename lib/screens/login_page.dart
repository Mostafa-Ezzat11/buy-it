import 'dart:async';
import 'package:buy_it/constants.dart';
import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/screens/admin/admin_home.dart';
import 'package:buy_it/screens/sign_up_page.dart';
import 'package:buy_it/screens/user/home_page.dart';
import 'package:buy_it/services/auth_service%20.dart';
import 'package:buy_it/widgets/custom_buttn.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'Login Page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  bool isLouding = false, isAdmin = false, rememberme = false;

  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: isLouding,
      child: Scaffold(
        backgroundColor: kmaincolor,

        body: Form(
          key: formstate,
          child: ListView(
            children: [
              SizedBox(
                height: height * .25,
                child: Stack(
                  alignment: AlignmentGeometry.center,
                  children: [
                    Image.asset('assets/images/icons8-buy-100.png'),
                    Positioned(
                      top: 150,
                      child: Text(
                        'Buy it',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .06),

              CustomTextFormField(
                hintText: 'Enter Your Email',
                icon: Icons.email,
                onchange: (data) {
                  email = data;
                },
              ),
              SizedBox(height: height * .015),

              CustomTextFormField(
                hintText: 'Enter Your Password',
                icon: Icons.lock,
                onchange: (data) {
                  password = data;
                },
                password: true,
              ),
              SizedBox(height: height * .05),

              CustomButton(
                text: 'Login',
                ontap: () async {
                  // if (rememberme) {
                  //   keeplogin();
                  // }
                  await onTapLogin(context);
                },
              ),
              SizedBox(height: height * .01),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Checkbox(
              //       value: rememberme,
              //       activeColor: Colors.blue,
              //       onChanged: (value) {
              //         setState(() {
              //           rememberme = value ?? false;
              //         });
              //       },
              //     ),
              //     Text(
              //       'Remember me ',
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: height * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont\'have an accoutn? ',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isAdmin = true;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: isAdmin
                                ? kmaincolor
                                : Colors.black,
                          ),
                          height: 40,
                          child: Center(
                            child: Text(
                              'Iam an Admin',
                              style: TextStyle(
                                fontSize: 18,
                                color: isAdmin
                                    ? kmaincolor
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          isAdmin = false;
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: isAdmin
                                ? Colors.black
                                : kmaincolor,
                          ),
                          height: 40,
                          child: Center(
                            child: Text(
                              'Iam a User',
                              style: TextStyle(
                                fontSize: 18,
                                color: isAdmin
                                    ? Colors.white
                                    : kmaincolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapLogin(BuildContext context) async {
    if (formstate.currentState!.validate()) {
      isLouding = true;
      setState(() {});

      if (isAdmin) {
        if (password == kadminPassword) {
          try {
            await AuthService().login(
              email: email!.trim(),
              password: password!.trim(),
            );
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            showSnackBar(context, e.toString());
          }
        } else {
          showSnackBar(context, 'Your Admin Password is Wrong !');
        }
      } else {
        try {
          await AuthService().login(
            email: email!,
            password: password!,
          );
          Navigator.pushNamed(
            context,
            HomePage.id,
            arguments: {'email': email, 'password': password},
          );
        } catch (e) {
          showSnackBar(context, e.toString());
        }
      }
    }
    isLouding = false;
    setState(() {});
  }

  // void keeplogin() async {
  //   SharedPreferences preferences =
  //       await SharedPreferences.getInstance();
  //   preferences.setBool('keepmelogin', rememberme);
  // }
}
