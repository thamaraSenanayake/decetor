import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class FormPasswordBox extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final String? Function(String?)? validation;

  const FormPasswordBox({
    Key? key,
    required this.textController,
    required this.hintText,
    this.validation,
  }) : super(key: key);

  @override
  _FormPasswordBoxState createState() => _FormPasswordBoxState();
}

class _FormPasswordBoxState extends State<FormPasswordBox> {
  bool _hidePassword = true;

  void inContact(TapDownDetails details) {
    setState(() {
      _hidePassword = false;
    });
  }

  void outContact(TapUpDetails details) {
    setState(() {
      _hidePassword = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _hidePassword,
      enableInteractiveSelection: false,
      style: TextStyle(
        color: ColorTheme.primaryColor,
        fontSize: Sizes.contentText,
      ),
      decoration: InputDecoration(
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
        hintText: widget.hintText,
        labelText: widget.hintText,
        errorStyle: TextStyle(
          color: ColorTheme.accentColor1,
        ),
        suffix: GestureDetector(
          onTapDown: inContact,
          onTapUp: outContact,
          child: Icon(
            _hidePassword ? Icons.visibility : Icons.visibility_off,
            color: ColorTheme.secondaryColor,
            size: Sizes.contentText,
          ),
        ),
      ),
      validator: widget.validation,
      onSaved: (val) => widget.textController.text = val ?? "",
    );
  }
}
