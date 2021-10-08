import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

class ResultView extends StatefulWidget {
  final int score;
  ResultView({Key? key,required this.score}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  Color? _color;
  String _text="";
  String _image="";
  @override
  void initState() {
    super.initState();
    if(widget.score ==0){
      _color =Color( 0xff00B0FF);
      _text ="Congratulation you are in normal condition";
      _image ="assets/icons/normal.svg";
    }
    else if(widget.score ==1){
      _color =Color( 0xff00BFA6);
      _text ="Mild mood disturbance";
      _image ="assets/icons/mildMood.svg";
    }
    else if(widget.score ==2){
      _color =Color( 0xffF9A826);
      _text ="Severe Depression";
      _image ="assets/icons/severeDepression.svg";
    }
    else{
      _color =Color( 0xffF50057);
      _text ="Extreme Depression";
      _image ="assets/icons/extreamDepression.svg";
    }
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height-85.h,
      width: size.width,
      color: _color!.withOpacity(0.1),
      child: AnimationLimiter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Text(
                _text,
                style: TextStyle(
                  color: _color,
                  fontSize: 25,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: SvgPicture.asset(
                  _image
                )
              ),
              SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}