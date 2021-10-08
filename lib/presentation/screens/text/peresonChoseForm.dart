import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PersonSelect extends StatefulWidget {
  final Function(int) personSelect;
  PersonSelect({Key? key,required this.personSelect}) : super(key: key);

  @override
  _PersonSelectState createState() => _PersonSelectState();
}

class _PersonSelectState extends State<PersonSelect> {
  List<String> _personNameList = ["Mark Zuckerberg","Jack Ma","Shah Rukh Khan","Malala Yousafzai","Mahatma Gandhi","Nelson Mandela","Kusal Mendis","Gotabaya Rajapaksa","Sakvithi Ranasinghe","Osama bin Laden","Idi Amin","Adolf Hitler","Sushant Singh Rajput","Dasun Nishan","Marilyn Monroe"];
  List<String> _imageList = ["https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Mark_Zuckerberg_F8_2019_Keynote_%2847721886632%29_%28cropped%29.jpg/220px-Mark_Zuckerberg_F8_2019_Keynote_%2847721886632%29_%28cropped%29.jpg",
                             "https://image.cnbcfm.com/api/v1/image/104225995-_95A5004.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/6/6e/Shah_Rukh_Khan_graces_the_launch_of_the_new_Santro.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Shinz%C5%8D_Abe_and_Malala_Yousafzai_%281%29_Cropped.jpg/220px-Shinz%C5%8D_Abe_and_Malala_Yousafzai_%281%29_Cropped.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Mahatma-Gandhi%2C_studio%2C_1931.jpg/220px-Mahatma-Gandhi%2C_studio%2C_1931.jpg",
                             'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Nelson_Mandela_1994.jpg/220px-Nelson_Mandela_1994.jpg',
                             "https://img1.hscicdn.com/image/upload/f_auto/lsci/db/PICTURES/CMS/303800/303835.png",
                             "https://upload.wikimedia.org/wikipedia/commons/d/d0/Nandasena_Gotabaya_Rajapaksa.jpg",
                             "https://pbs.twimg.com/profile_images/1140153679275683840/6DO92spd_400x400.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Osama_bin_Laden_portrait.jpg/220px-Osama_bin_Laden_portrait.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Idi_Amin_at_UN_%28United_Nations%2C_New_York%29_gtfy.00132_%28cropped%29.jpg/800px-Idi_Amin_at_UN_%28United_Nations%2C_New_York%29_gtfy.00132_%28cropped%29.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Hitler_portrait_crop.jpg/220px-Hitler_portrait_crop.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/a/ab/Sushant_sr_Manish_M_B%27day_bash.jpg",
                             "https://gossip.hirufm.lk/data/gossip_images/v3imgpath/2017Sep/25/12976732_10209528903964384_4279525041107462994_o.jpg",
                             "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Monroecirca1953.jpg/800px-Monroecirca1953.jpg"
                            ];
  List<int> _scoreList = [0,0,0,0,0,0,1,1,1,2,2,2,3,3,3];
  List<int> _selectPerson =[];

  _setScore(){
    int score = 0;
    for (var item in _selectPerson) {
      score+=_scoreList[item];
    }
    widget.personSelect(score);
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
            _personNameList.length,
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
                        List<int> _selectPersonTemp = [];
                        _selectPersonTemp.addAll(_selectPerson);
                        if(_selectPersonTemp.contains(index)){
                          _selectPersonTemp.remove(index);
                        }else{
                          _selectPersonTemp.add(index);
                        }
                        setState(() {
                          _selectPerson = _selectPersonTemp;
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
                            image: NetworkImage(
                              _imageList[index],
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                        child:Stack(
                          children: [
                            if(_selectPerson.contains(index))
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
                                  _personNameList[index],
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