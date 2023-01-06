
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final bool secure;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTapShowPassword;
  final bool validation;
  final bool containsSuffixIcon;
  final bool containsPrefixIcon;
  final IconData prefixIconPath;
  final String suffixIconPath;
  final bool showPassword;
  final bool isEnabled;
  final int maxLines;
  final bool isSiffixMore;
  final bool isPrefixIconComplex;
  final bool isSearchTextField;
  final TextEditingController? controller;
  final TextInputType inputType;
  final VoidCallback? onTapTextField;
  CustomTextField(
      {this.validator,
      this.onTapTextField,
      this.isEnabled: true,
      this.showPassword: false,
      this.validation: true,
      this.onTapShowPassword,
      this.secure: false,
      this.maxLines: 1,
      this.isSiffixMore: false,
      this.isPrefixIconComplex: false,
      this.hint: "",
      this.inputType: TextInputType.text,
      this.containsPrefixIcon: false,
      this.containsSuffixIcon: false,
      this.isSearchTextField: false,
      this.controller,
      this.prefixIconPath: Icons.pages,
      this.suffixIconPath: ""});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorMessage(String str) {
    switch (widget.hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width(context) * .8,
      // height: isLandscape(context) ? 2 * height * .12 : height * .11,
      child: TextFormField(
        validator: widget.validator,
        maxLines: widget.maxLines,
        onTap: widget.onTapTextField,
        enabled: widget.isEnabled,
        controller: widget.controller,
        keyboardType: widget.inputType,
        style: TextStyle(
            color: blackColor,
            fontSize: isLandscape(context) ? 2 * height * .02 : height * .02),
        obscureText: widget.secure,
        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          focusColor: mainColor,
          hoverColor: mainColor,
          errorMaxLines: 3,
          prefixIcon: Icon(
            widget.prefixIconPath,
            color: greyColor,
            size: height * .03,
          ),
          errorText:
              widget.validation == false ? "This field can\'t be epty" : null,
          hintText: translator.translate(widget.hint),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: mainColor)),
          hintStyle: TextStyle(
              color: greyColor.withOpacity(.5),
              fontWeight: FontWeight.bold,
              fontFamily: "sanaiey",
              fontSize:
                  isLandscape(context) ? 2 * height * .018 : height * .018),
        ),
      ),
    );
  }
}
