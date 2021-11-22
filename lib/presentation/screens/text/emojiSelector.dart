import 'package:detector/data/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EmojiSelector extends StatefulWidget {
  final Function(int,int) emojiSelect;
  EmojiSelector({Key? key,required this.emojiSelect}) : super(key: key);

  @override
  _EmojiSelectorState createState() => _EmojiSelectorState();
}

class _EmojiSelectorState extends State<EmojiSelector> {
  List<Person> _emojiList = [
    Person(name: "angry", url:"assets/images/emoji/angry.png", score: 4),
    Person(name: "happy", url:"assets/images/emoji/happy.png", score: 0),
    Person(name: "lowsad", url:"assets/images/emoji/lowsad.png", score: 3),
    Person(name: "midHappy", url:"assets/images/emoji/midHappy.png", score: 1),
    Person(name: "sad", url:"assets/images/emoji/sad.png", score: 5),
    Person(name: "unHappy", url:"assets/images/emoji/unHappy.png", score: 2),
  ];
  
 
  late List<Person> _selectEmoji = [];

  _setScore(){
    int score = 0;
    for (var item in _selectEmoji) {
      score+=item.score;
    }
    widget.emojiSelect(score,1);
  }
  String _emojiError = '';

  @override
  void initState() {
    super.initState();
    _emojiList.shuffle();
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
            _emojiList.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: 3,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: (){

                        List<Person> _selectEmojiTemp = [];
                        _selectEmojiTemp.addAll(_selectEmoji);
                        if(_selectEmojiTemp.contains(_emojiList[index])){
                          _selectEmojiTemp.remove(_emojiList[index]);
                          if(_emojiError.isNotEmpty){
                            setState(() {
                              _emojiError = "";
                            });
                          }
                        }else{
                          if(_selectEmoji.length == 2){
                            setState(() {
                              _emojiError = "Cant select more than 2 emoji";
                            });
                          }else{
                            _selectEmojiTemp.add(_emojiList[index]);
                          }
                        }
                        setState(() {
                          _selectEmoji = _selectEmojiTemp;
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
                              _emojiList[index].url,
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                        child:Stack(
                          children: [
                            if(_selectEmoji.contains( _emojiList[index]) )
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
                                  _emojiList[index].name,
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