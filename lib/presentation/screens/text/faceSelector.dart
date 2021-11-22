import 'package:detector/data/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FaceSelector extends StatefulWidget {
  final Function(int,int) faceSelect;
  FaceSelector({Key? key,required this.faceSelect}) : super(key: key);

  @override
  _FaceSelectorState createState() => _FaceSelectorState();
}

class _FaceSelectorState extends State<FaceSelector> {
  List<Person> _faceList = [
    Person(name: "angry", url: "assets/images/face/angry.png", score: 3),
    Person(name: "happy", url: "assets/images/face/happy.png", score: 0),
    Person(name: "sad", url: "assets/images/face/sad.png", score: 5),
    Person(name: "suicide", url: "assets/images/face/suicide.png", score: 7),
  ];
 
  List<Person> _selectFaceList =[];
  String _faceError = "";

  _setScore(){
    int score = 0;
    for (var item in _selectFaceList) {
      score+=item.score;
    }
    widget.faceSelect(score,_selectFaceList.length);
  }

  @override
  void initState() {
    super.initState();
    _faceList.shuffle();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height-175.h,
      width: size.width,
      padding: EdgeInsets.all(25.h),
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing:10,
          children: List.generate(
            _faceList.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: (){
                        print("object");
                        
                        List<Person> _selectFaceTemp = [];
                        _selectFaceTemp.addAll(_selectFaceList);
                        if(_selectFaceTemp.contains(_faceList[index])){
                          _selectFaceTemp.remove(_faceList[index]);
                          if(_faceError.isNotEmpty){
                            setState(() {
                              _faceError = "";
                            });
                          }
                        }else{
                          if(_selectFaceList.length == 2){
                            setState(() {
                              _faceError = "Cant select more than 3 person";
                            });
                          }else{
                            _selectFaceTemp.add(_faceList[index]);
                          }
                        }
                        setState(() {
                          _selectFaceList = _selectFaceTemp;
                        });
                        _setScore();
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
                          image: DecorationImage(
                            image: AssetImage(
                              _faceList[index].url,
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                        child:Stack(
                          children: [
                            if(_selectFaceList.contains(_faceList[index]))
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topRight,
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
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.white.withOpacity(0.5),
                                child: Text(
                                  _faceList[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
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