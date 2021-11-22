import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SleepingHours extends StatefulWidget {
  final Function(int) selectedHours;
  SleepingHours({Key? key,required this.selectedHours}) : super(key: key);

  @override
  _SleepingHoursState createState() => _SleepingHoursState();
}

class _SleepingHoursState extends State<SleepingHours> {
  List<String> _hourList = ["12-10 hours","10-8 hours","8-5 hours","5-3 hours","3-1 hours"];
  List _scoreList = [5,4,1,3,6];
  late int _selectHour = -1;


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
            _hourList.length,
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
                          _selectHour = index;
                        });
                        widget.selectedHours(_scoreList[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                            if(_selectHour == index)
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
                            )  ,
                            Center(
                              child: Text(
                                _hourList[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
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