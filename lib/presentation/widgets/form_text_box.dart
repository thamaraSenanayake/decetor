import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class FormTextBox extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final int maxLength;
  final int maxLines;
  final String? Function(String?)? validation;
  final TextInputType? keyboard;

  const FormTextBox({
    Key? key,
    required this.textController,
    required this.hintText,
    this.maxLength = 50,
    this.maxLines = 1,
    this.validation,
    this.keyboard = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboard,
      style: TextStyle(
        color: ColorTheme.primaryColor,
        fontSize: Sizes.contentText,
      ),
      decoration: InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorTheme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorTheme.primaryColor,
          ),
          borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorTheme.accentColor1,
          ),
          borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorTheme.accentColor1,
          ),
          borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        ),
        hintStyle: TextStyle(
          color: ColorTheme.secondaryColor,
          fontSize: Sizes.contentText,
        ),
        labelStyle: TextStyle(
          color: ColorTheme.secondaryColor,
          fontSize: Sizes.contentText,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizes.contentHorizontal,
          vertical: Sizes.contentVertical,
        ),
        hintText: hintText,
        labelText: hintText,
        errorStyle: TextStyle(
          color: ColorTheme.accentColor1,
        ),
      ),
      validator: validation,
      onSaved: (val) => textController.text = val ?? "",
    );
  }
}
