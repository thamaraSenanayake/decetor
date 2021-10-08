import 'dart:io';

import 'package:detector/common/clippers/back_clipper.dart';
import 'package:detector/common/clippers/front_clipper.dart';
import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/common/utils/toast_helper.dart';
import 'package:detector/data/core/user_auth.dart';
import 'package:detector/presentation/screens/login/login_screen.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:detector/presentation/widgets/form_text_box.dart';
import 'package:detector/presentation/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetRequestScreen extends StatefulWidget {
  @override
  _ResetRequestScreenState createState() => _ResetRequestScreenState();
}

class _ResetRequestScreenState extends State<ResetRequestScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: width,
          color: ColorTheme.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: ColorTheme.backgroundColor,
                height: 250.w,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(
                        width,
                        (width * 0.625).toDouble(),
                      ),
                      painter: BackClipper(),
                    ),
                    CustomPaint(
                      size: Size(
                        width,
                        (width * 0.625).toDouble(),
                      ),
                      painter: FrontClipper(),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "FORGOT PASSWORD?",
                          style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(
                              fontSize: Sizes.appBarTitleText,
                              color: ColorTheme.backgroundColor,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              wordSpacing: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.defaultPadding,
                    vertical: Sizes.defaultPadding,
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Sizes.defaultSpace * 2),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  FormTextBox(
                                    hintText: "Email",
                                    textController: emailController,
                                    keyboard: TextInputType.emailAddress,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Sizes.defaultSpace),
                            PrimaryButton(
                              loading: _loading,
                              text: "RESET PASSWORD",
                              function: () async {
                                FocusScope.of(context).unfocus();
                                var form = formKey.currentState;
                                if (form!.validate() && !_loading) {
                                  form.save();
                                  final emailRegX = RegExp(
                                      r'^([\w-\.]+)+@[a-zA-Z0-9]{2,}\.[a-zA-Z]{2,}');

                                  if (emailController.text.isEmpty) {
                                    ToastHelper.errorToast(
                                        "Email address required");
                                  } else if (!emailRegX
                                      .hasMatch(emailController.text)) {
                                    ToastHelper.errorToast("Email not valid");
                                  } else {
                                    setState(() {
                                      _loading = true;
                                    });

                                    var result = await UserAuth()
                                        .requestResetPassword(
                                            emailController.text);
                                    if (result
                                        .toLowerCase()
                                        .contains("email sent")) {
                                      ToastHelper.successToast(
                                          "Email sent successfully. Follow the email to reset your password");

                                      setState(() {
                                        _loading = false;
                                      });
                                      sleep(Duration(seconds: 1));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ));
                                    } else {
                                      setState(() {
                                        _loading = false;
                                      });

                                      ToastHelper.errorToast(result);
                                    }
                                  }
                                }
                              },
                            ),
                            SizedBox(height: Sizes.halfSpace),
                            Container(
                              child: RichText(
                                textAlign: TextAlign.right,
                                text: TextSpan(
                                    text: "Back to",
                                    style: TextStyle(
                                      color: ColorTheme.fadedTextColor,
                                      fontSize: Sizes.contentText,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return LoginScreen();
                                              },
                                            ));
                                          },
                                        text: " Login",
                                        style: TextStyle(
                                          color: ColorTheme.primaryColor,
                                          fontSize: Sizes.contentText,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: Sizes.defaultSpace),
                          ],
                        ),
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
