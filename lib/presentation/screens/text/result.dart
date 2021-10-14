import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/presentation/screens/text/videoDisplay.dart';
import 'package:detector/presentation/themes/color_theme.dart';
import 'package:detector/presentation/widgets/primary_button.dart';
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
  double result = 0;
  @override
  void initState() {
    super.initState();
    result = widget.score*100/18;
    if(result < 24){
      _color =Color( 0xff00B0FF);
      _text ="Congratulation you are in normal condition";
      _image ="assets/icons/normal.svg";
    }
    else if(result <49){
      _color =Color( 0xff00BFA6);
      _text ="Mild mood disturbance";
      _image ="assets/icons/mildMood.svg";
    }
    else if(result <74){
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
  
  _viewDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          elevation: 16,
          child: Container(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 20.h),
                Center(
                  child:Text(
                    'Treatment',
                    style: TextStyle(
                      fontSize: Sizes.appBarTitleText,
                      color: ColorTheme.appBarTextColor,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      wordSpacing: 5,
                    ),
                  )
                ),
                SizedBox(height: 20.h),
                ListTile(
                  title: Text("Motivational Videos"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap:() async {
                    await Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => VideoPlayer(motiation:true),
                        opaque: false
                      ),
                    );
                    Navigator.pop(context);
                  }
                ),
                ListTile(
                  title: Text("Music treatment"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap:() async {
                    await Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => VideoPlayer(motiation:false),
                        opaque: false
                      ),
                    );
                    Navigator.pop(context);
                  }
                ),

              ],
            ),
          ),
        );
      }
    );
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
              
              result>50.0?
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 20.w),
                child: PrimaryButton(
                  text: "Treatment",
                  function: () {
                    _viewDialog();
                  },
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}