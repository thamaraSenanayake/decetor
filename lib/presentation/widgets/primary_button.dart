import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final bool loading;
  final bool altStyle;
  final double scale;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.function,
    this.loading = false,
    this.altStyle = false,
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius * scale),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(Sizes.buttonTextFieldRadius * scale),
        onTap: function,
        child: Ink(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.contentHorizontal * scale,
            vertical: Sizes.contentVertical * scale,
          ),
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(Sizes.buttonTextFieldRadius * scale),
            color:
                altStyle ? ColorTheme.fadedTextColor : ColorTheme.buttonColor,
          ),
          child: Center(
            child: !loading
                ? Text(
                    text,
                    style: GoogleFonts.bebasNeue(
                      textStyle: TextStyle(
                        color: altStyle
                            ? ColorTheme.buttonTextColor
                            : ColorTheme.buttonTextColor,
                        fontSize: Sizes.buttonText * scale,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        wordSpacing: 5,
                      ),
                    ),
                  )
                : Container(
                    height: Sizes.buttonText * scale + 3.sp,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballBeat,
                      color: altStyle
                          ? ColorTheme.primaryColor
                          : ColorTheme.buttonTextColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
