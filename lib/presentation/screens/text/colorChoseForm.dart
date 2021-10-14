import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SelectColor extends StatefulWidget {
  final Function(int) selectedColor;
  SelectColor({Key? key,required this.selectedColor}) : super(key: key);

  @override
  _SelectColorState createState() => _SelectColorState();
}

class _SelectColorState extends State<SelectColor> {
  List _colorsList = [Colors.orange,Colors.brown,Colors.yellow,Colors.purple,Colors.blue[900],Colors.lightBlue,Colors.blue,Colors.grey,Colors.green,Colors.black];
  List _scoreList = [2,2,2,2,3,4,6,8,1,6];
  int _selectColor =-1;
  


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height-223.h,
      width: size.width,
      padding: EdgeInsets.all(25.h),
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing:10,
          children: List.generate(
            _colorsList.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _selectColor = index;
                        });
                        widget.selectedColor(_scoreList[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _colorsList[index],
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: [
                            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15)),
                            BoxShadow(
                              color:  Color.fromRGBO(0, 0, 0, 0.15),
                              blurRadius: 11.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            )
                          ],
                        ),
                        child:Stack(
                          children: [
                            if(_selectColor == index)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.lightGreenAccent[400],
                                    shape: BoxShape.circle
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )     
                          ],  
                        ) ,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}