import 'package:bot_toast/bot_toast.dart';
import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  static void errorToast(String message) {
    BotToast.showText(
        text: message,
        duration: Duration(seconds: 4),
        onlyOne: true,
        clickClose: true,
        crossPage: true,
        backButtonBehavior: BackButtonBehavior.none,
        align: Alignment(0, 0.9),
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        textStyle: TextStyle(
            color: ColorTheme.whiteColorText, fontSize: Sizes.contentText),
        borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        backgroundColor: Colors.transparent,
        contentColor: Colors.redAccent);
  }

  static void successToast(String message) {
    BotToast.showText(
        text: message,
        duration: Duration(seconds: 3),
        onlyOne: true,
        clickClose: true,
        crossPage: true,
        backButtonBehavior: BackButtonBehavior.none,
        align: Alignment(0, 0.9),
        animationDuration: Duration(milliseconds: 200),
        animationReverseDuration: Duration(milliseconds: 200),
        textStyle: TextStyle(
            color: ColorTheme.primaryColor, fontSize: Sizes.contentText),
        borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        backgroundColor: Colors.transparent,
        contentColor: Colors.greenAccent);
  }
}
