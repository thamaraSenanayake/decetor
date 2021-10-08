import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/data/core/user_auth.dart';
import 'package:detector/data/provider/ui_support_provider.dart';
import 'package:detector/presentation/screens/login/login_screen.dart';
import 'package:detector/presentation/screens/text/text_answers_screen.dart';
import 'package:detector/presentation/screens/voice/voice_answers_screen.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:detector/presentation/widgets/big_button.dart';
import 'package:detector/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              backButton: false,
              title: "HOME",
            ),
            SizedBox(height: Sizes.defaultSpace),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
                  child: Column(
                    children: [
                      BigButton(
                        image: "assets/icons/microphone.png",
                        title: "Voice Depression Measurement",
                        function: () {
                          Provider.of<UiSupportProvider>(context, listen: false)
                              .setController();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return VoiceAnswersScreen();
                            },
                          ));
                        },
                      ),
                      SizedBox(height: Sizes.defaultSpace),
                      BigButton(
                        image: "assets/icons/keyboard.png",
                        title: "Type Text Depression Measurement",
                        function: () {
                          Provider.of<UiSupportProvider>(context, listen: false)
                              .setController();
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TextAnswersScreen();
                            },
                          ));
                        },
                      ),
                      SizedBox(height: Sizes.defaultSpace),
                      BigButton(
                        image: "assets/icons/image.png",
                        title: "Image & MCQ Depression Measurement",
                        function: () {},
                      ),
                      SizedBox(height: Sizes.defaultSpace),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Sizes.defaultPadding * 1.5),
                        child: Divider(
                          height: 2,
                          color: ColorTheme.accentColor1,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(height: Sizes.defaultSpace),
                      Row(
                        children: [
                          BigButton(
                            image: "assets/icons/profile.png",
                            title: "My Profile",
                            halfButton: true,
                            function: () {},
                          ),
                          SizedBox(width: Sizes.defaultSpace),
                          BigButton(
                            image: "assets/icons/sign-out.png",
                            title: "Logout",
                            halfButton: true,
                            function: () async {
                              await UserAuth().signOut();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            },
                          ),
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
    );
  }
}
