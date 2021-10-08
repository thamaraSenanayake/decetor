import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback function;
  final bool? halfButton;

  const BigButton({
    Key? key,
    required this.title,
    required this.image,
    required this.function,
    this.halfButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = (halfButton ?? false)
        ? MediaQuery.of(context).size.width - (3 * Sizes.defaultPadding)
        : MediaQuery.of(context).size.width - (2 * Sizes.defaultPadding);
    return Material(
      color: ColorTheme.accentColor1,
      elevation: 5,
      borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
        onTap: function,
        child: Ink(
          width: (halfButton ?? false) ? width / 2 : width,
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.defaultPadding,
            vertical: Sizes.defaultPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.buttonTextFieldRadius),
            color: ColorTheme.accentColor1,
          ),
          child: Column(
            children: [
              Image.asset(
                image,
                color: Colors.white,
              ),
              SizedBox(height: Sizes.halfSpace),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Sizes.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
