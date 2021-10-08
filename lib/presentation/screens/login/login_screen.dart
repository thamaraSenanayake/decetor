import 'package:detector/common/clippers/back_clipper.dart';
import 'package:detector/common/clippers/front_clipper.dart';
import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/common/utils/toast_helper.dart';
import 'package:detector/data/core/firebase_database.dart';
import 'package:detector/data/core/user_auth.dart';
import 'package:detector/data/provider/data_provider.dart';
import 'package:detector/presentation/screens/home/home_screen.dart';
import 'package:detector/presentation/screens/recovery/reset_request_screen.dart';
import 'package:detector/presentation/screens/register/register_screen.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:detector/presentation/widgets/form_password_box.dart';
import 'package:detector/presentation/widgets/form_text_box.dart';
import 'package:detector/presentation/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    _checkAutoLogin();
    super.initState();
  }

  void _checkAutoLogin() async {
    bool signedIn = await UserAuth().isSignedIn();
    if (signedIn) {
      setState(() {
        _loading = true;
      });
      var user = await UserAuth().getUser();
      var questions = await FirebaseDatabase().getQuestions();
      Provider.of<DataProvider>(context, listen: false).setClient(user!);
      Provider.of<DataProvider>(context, listen: false).setQuestions(questions);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

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
                          "LOGIN TO ACCOUNT",
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
                                  SizedBox(height: Sizes.defaultSpace),
                                  FormPasswordBox(
                                    hintText: "Password",
                                    textController: passwordController,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Sizes.halfSpace),
                            Container(
                              width: width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ResetRequestScreen();
                                    },
                                  ));
                                },
                                child: Text(
                                  "Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: ColorTheme.fadedTextColor,
                                    fontSize: Sizes.contentText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Sizes.defaultSpace),
                            PrimaryButton(
                              loading: _loading,
                              text: "LOGIN",
                              function: () async {
                                FocusScope.of(context).unfocus();
                                var form = formKey.currentState;
                                if (form!.validate() && !_loading) {
                                  form.save();

                                  if (emailController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    ToastHelper.errorToast(
                                        "All fields required");
                                  } else {
                                    setState(() {
                                      _loading = true;
                                    });

                                    var result = await UserAuth().signIn(emailController.text,passwordController.text);
                                    if (result.toLowerCase().contains("success")) {
                                      var user = await UserAuth().getUser();
                                      var questions = await FirebaseDatabase().getQuestions();
                                      Provider.of<DataProvider>(context,listen: false).setClient(user!);
                                      Provider.of<DataProvider>(context,listen: false).setQuestions(questions);

                                      setState(() {
                                        _loading = false;
                                      });
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        )
                                      );
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
                                    text: "Don't have an account?",
                                    style: TextStyle(
                                      color: ColorTheme.fadedTextColor,
                                      fontSize: Sizes.contentText,
                                    ),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(context,MaterialPageRoute(
                                              builder: (context) {
                                                return RegisterScreen();
                                              },
                                            ));
                                          },
                                        text: " Register",
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
