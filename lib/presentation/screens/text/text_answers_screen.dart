import 'dart:async';

import 'package:detector/common/constants/size_constants.dart';
import 'package:detector/data/provider/data_provider.dart';
import 'package:detector/data/provider/ui_support_provider.dart';
import 'package:detector/presentation/screens/text/colorChoseForm.dart';
import 'package:detector/presentation/screens/text/emojiSelector.dart';
import 'package:detector/presentation/screens/text/faceSelector.dart';
import 'package:detector/presentation/screens/text/peresonChoseForm.dart';
import 'package:detector/presentation/screens/text/result.dart';
import 'package:detector/presentation/screens/text/sleepingHour.dart';
import 'package:detector/presentation/widgets/custom_app_bar.dart';
import 'package:detector/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class TextAnswersScreen extends StatefulWidget {
  @override
  _TextAnswersScreenState createState() => _TextAnswersScreenState();
}

class _TextAnswersScreenState extends State<TextAnswersScreen> {
  
  int _colorScore =0;
  int _personScore =0;
  int _emojiScore =0;
  int _emojiCount =0;
  int _hoursScore =0;
  // int _hoursCount =0;
  int _faceScore =0;
  int _faceCount =0;
  int _currentForm = 0;
  Timer? timer;
  int _initSec = 10;
  int _personCount = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _initSec -=1; 
      });
      if(_initSec == 0){
        timer?.cancel();
        _colorScore = 9;
        _currentForm = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Consumer2<UiSupportProvider, DataProvider>(
          builder: (context, UiSupportProvider uiProvider,DataProvider dataProvider, child) =>
          Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.halfSpace),
                  child: CustomAppBar(
                    backButton: true,
                    title: _currentForm == 0?"Choose a color":
                    _currentForm == 1?"Choose a Person":
                    _currentForm == 2?"Select favorite emoji":
                    _currentForm == 3?"Select Face type":
                    _currentForm == 4?"Select Sleeping hours":
                    "Result",
                  ),
                ),

                _currentForm == 0?
                Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        (_initSec<10? ":0":":")+"$_initSec",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight:FontWeight.w600
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    SelectColor(
                      selectedColor: (val){
                        setState(() {
                          _colorScore = val;
                        });
                      }
                    ),
                  ],
                ):
                _currentForm == 1?
                PersonSelect(
                  personSelect: (val,count){
                    print(val);
                    setState(() {
                      _personScore = val;
                      _personCount = count;
                    });
                  }
                ):
                _currentForm == 2?
                EmojiSelector(
                  emojiSelect: (val,count){
                    print(val);
                    setState(() {
                      _emojiScore = val;
                      _emojiCount = count;
                    });
                  }
                ):
                _currentForm == 3?
                FaceSelector(
                  faceSelect: (val,count){
                    print(val);
                    setState(() {
                      _faceScore = val;
                      _faceCount = count;
                    });
                  }
                ):
                _currentForm == 4?
                SleepingHours(
                  selectedHours: (val){
                    print(val);
                    setState(() {
                      _hoursScore = val;
                    });
                  }
                ):
                ResultView(score: _personScore+_colorScore + _emojiScore+_faceScore+_hoursScore,),
                
                (_currentForm == 1 && _personCount>0) || 
                (_currentForm == 0 && _colorScore>0) ||
                (_currentForm == 2 && _emojiCount>0) ||
                (_currentForm == 3 && _faceCount>0) ||
                (_currentForm == 4 && _hoursScore>0) 
                ?
                Padding(
                  padding:EdgeInsets.symmetric(horizontal: Sizes.defaultPadding),
                  child: PrimaryButton(
                    text: _currentForm==4
                        ? "SUBMIT"
                        : "NEXT",
                    function: () {
                      timer?.cancel();
                      setState(() {
                        _currentForm++;
                      });
                    },
                  ),
                ):SizedBox(),
                _currentForm == 1 || _currentForm == 0?
                SizedBox(height: Sizes.defaultSpace):SizedBox(height: 0,),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
