import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;
  final bool backButton;

  const CustomAppBar({
    Key? key,
    this.title,
    this.backButton = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.w,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          backButton
              ? Container(
                  width: 30.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorTheme.appBarTextColor,
                      size: 32.w,
                    ),
                  ),
                )
              : Container(),
          title != null
              ? Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        title ?? "",
                        style: GoogleFonts.bebasNeue(
                          textStyle: TextStyle(
                            fontSize: Sizes.appBarTitleText,
                            color: ColorTheme.appBarTextColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                            wordSpacing: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Container(),
                ),
          backButton
              ? Container(
                  width: 30.w,
                )
              : Container(),
        ],
      ),
    );
  }
}
