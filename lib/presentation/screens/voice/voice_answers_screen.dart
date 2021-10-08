import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/common/utils/converter.dart';
import 'package:detector/data/provider/data_provider.dart';
import 'package:detector/data/provider/ui_support_provider.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:detector/presentation/widgets/custom_app_bar.dart';
import 'package:detector/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VoiceAnswersScreen extends StatefulWidget {
  @override
  _VoiceAnswersScreenState createState() => _VoiceAnswersScreenState();
}

class _VoiceAnswersScreenState extends State<VoiceAnswersScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer2<UiSupportProvider, DataProvider>(
          builder: (context, UiSupportProvider uiProvider,
                  DataProvider dataProvider, child) =>
              Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.halfSpace),
                  child: CustomAppBar(
                    backButton: true,
                    title: "VOICE QUESTIONS",
                  ),
                ),
                SizedBox(height: Sizes.defaultSpace),
                Expanded(
                  child: Container(
                    width: size.width - (2 * Sizes.defaultPadding),
                    padding:
                        EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
                    decoration: BoxDecoration(
                      color: ColorTheme.fadedBgColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                        Sizes.buttonTextFieldRadius,
                      ),
                    ),
                    child: PageView.builder(
                      controller: uiProvider.pageController,
                      itemCount: dataProvider.questions.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Sizes.defaultSpace),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Question Number: ${Converter().questionNumber(dataProvider.questions[index].number)}",
                                    style: TextStyle(
                                      fontSize: Sizes.buttonText,
                                      color: ColorTheme.textColor,
                                    ),
                                  ),
                                  SizedBox(height: Sizes.defaultSpace),
                                  Text(
                                    "${dataProvider.questions[index].question}",
                                    style: TextStyle(
                                      fontSize: Sizes.buttonText,
                                      color: ColorTheme.textColor,
                                    ),
                                  ),
                                  SizedBox(height: Sizes.defaultSpace),
                                ],
                              ),
                            ),
                            SizedBox(height: Sizes.defaultSpace),
                            Align(
                              alignment: Alignment.center,
                              child: Material(
                                color: ColorTheme.accentColor1,
                                borderRadius: BorderRadius.circular(50.w),
                                elevation: 5,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(50.w),
                                  child: Ink(
                                    height: 65.w,
                                    width: 65.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.w),
                                      color: ColorTheme.primaryColor,
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 45.w,
                                        width: 45.w,
                                        child: Image.asset(
                                          "assets/icons/microphone.png",
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Sizes.defaultSpace),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: Sizes.defaultSpace),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
                  child: PrimaryButton(
                    text: (uiProvider.selectedMenuIndex + 1) ==
                            dataProvider.questions.length
                        ? "SUBMIT"
                        : "NEXT",
                    function: () {
                      if ((uiProvider.selectedMenuIndex + 1) ==
                          dataProvider.questions.length) {
                      } else {
                        uiProvider.nextQuestion();
                      }
                    },
                  ),
                ),
                SizedBox(height: Sizes.defaultSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
