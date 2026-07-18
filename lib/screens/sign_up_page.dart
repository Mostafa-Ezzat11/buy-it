import 'package:buy_it/constants.dart';
import 'package:buy_it/helpers/show_snack_bar.dart';
import 'package:buy_it/services/auth_service%20.dart';
import 'package:buy_it/widgets/custom_buttn.dart';
import 'package:buy_it/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String id = 'SignUp';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formstate = GlobalKey();

  String? email, password, name;

  bool isLouding = false;

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
                height: height * .24,
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

              SizedBox(height: height * .07),

              CustomTextFormField(
                hintText: 'Enter Your Name',
                icon: Icons.person,
                onchange: (data) {
                  name = data;
                },
              ),

              SizedBox(height: height * .015),

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
                password: true,
                onchange: (data) {
                  password = data;
                },
              ),

              SizedBox(height: height * .06),

              CustomButton(
                text: 'Sign Up',
                ontap: () async {
                  if (formstate.currentState!.validate()) {
                    isLouding = true;
                    setState(() {});
                    try {
                      await AuthService().register(
                        email: email!,
                        password: password!,
                      );
                      showSnackBar(context, 'Success !!');
                    } catch (e) {
                      showSnackBar(context, e.toString());
                    }
                  }
                  isLouding = false;
                  setState(() {});
                },
              ),

              SizedBox(height: height * .03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an accoutn? ',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
