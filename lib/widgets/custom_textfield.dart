import 'package:buy_it/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.hintText,
    super.key,
    this.onchange,
    this.icon,
    this.password = false,
  });
  final String hintText;
  final IconData? icon;
  Function(String)? onchange;
  bool password;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        obscureText: password,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Field is required');
          }
          return null;
        },
        onChanged: onchange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xffFFE5A9),
          prefixIcon: Icon(icon),
          prefixIconColor: kmaincolor,
          hintText: hintText,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFFE5A9)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFFE5A9)),
            borderRadius: BorderRadius.circular(15),
          ),

          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffFFE5A9)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
