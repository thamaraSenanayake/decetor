import 'package:detector/data/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class PersonSelect extends StatefulWidget {
  final Function(int,int) personSelect;
  PersonSelect({Key? key,required this.personSelect}) : super(key: key);

  @override
  _PersonSelectState createState() => _PersonSelectState();
}

class _PersonSelectState extends State<PersonSelect> {
  List<Person> _persenList = [
    Person(name: "Mark Zuckerberg", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Mark_Zuckerberg_F8_2019_Keynote_%2847721886632%29_%28cropped%29.jpg/220px-Mark_Zuckerberg_F8_2019_Keynote_%2847721886632%29_%28cropped%29.jpg", score: 0),
    Person(name: "Jack Ma", url: "https://image.cnbcfm.com/api/v1/image/104225995-_95A5004.jpg", score: 0),
    Person(name: "Shah Rukh Khan", url: "https://upload.wikimedia.org/wikipedia/commons/6/6e/Shah_Rukh_Khan_graces_the_launch_of_the_new_Santro.jpg", score: 0),
    Person(name: "Malala Yousafzai", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Shinz%C5%8D_Abe_and_Malala_Yousafzai_%281%29_Cropped.jpg/220px-Shinz%C5%8D_Abe_and_Malala_Yousafzai_%281%29_Cropped.jpg", score: 0),
    Person(name: "Mahatma Gandhi", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Mahatma-Gandhi%2C_studio%2C_1931.jpg/220px-Mahatma-Gandhi%2C_studio%2C_1931.jpg", score: 0),
    Person(name: "Nelson Mandela", url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/Nelson_Mandela_1994.jpg/220px-Nelson_Mandela_1994.jpg', score: 0),
    Person(name: "Kusal Mendis", url: "https://img1.hscicdn.com/image/upload/f_auto/lsci/db/PICTURES/CMS/303800/303835.png", score: 1),
    Person(name: "Gotabaya Rajapaksa", url: "https://upload.wikimedia.org/wikipedia/commons/d/d0/Nandasena_Gotabaya_Rajapaksa.jpg", score: 1),
    Person(name: "Sakvithi Ranasinghe", url: "https://pbs.twimg.com/profile_images/1140153679275683840/6DO92spd_400x400.jpg", score: 1),
    Person(name: "Osama bin Laden", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Osama_bin_Laden_portrait.jpg/220px-Osama_bin_Laden_portrait.jpg", score: 2),
    Person(name: "Idi Amin", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Idi_Amin_at_UN_%28United_Nations%2C_New_York%29_gtfy.00132_%28cropped%29.jpg/800px-Idi_Amin_at_UN_%28United_Nations%2C_New_York%29_gtfy.00132_%28cropped%29.jpg", score: 2),
    Person(name: "Adolf Hitler", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Hitler_portrait_crop.jpg/220px-Hitler_portrait_crop.jpg", score: 2),
    Person(name: "Sushant Singh Rajput", url: "https://upload.wikimedia.org/wikipedia/commons/a/ab/Sushant_sr_Manish_M_B%27day_bash.jpg", score: 3),
    Person(name: "Dasun Nishan", url: "https://gossip.hirufm.lk/data/gossip_images/v3imgpath/2017Sep/25/12976732_10209528903964384_4279525041107462994_o.jpg", score: 3),
    Person(name: "Marilyn Monroe", url: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Monroecirca1953.jpg/800px-Monroecirca1953.jpg", score: 3),
  ];
 
  List<Person> _selectPerson =[];
  String _personError = "";

  _setScore(){
    int score = 0;
    for (var item in _selectPerson) {
      score+=item.score;
    }
    widget.personSelect(score,_selectPerson.length);
  }

  @override
  void initState() {
    super.initState();
    _persenList.shuffle();
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
            _persenList.length,
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
                        
                        List<Person> _selectPersonTemp = [];
                        _selectPersonTemp.addAll(_selectPerson);
                        if(_selectPersonTemp.contains(_persenList[index])){
                          _selectPersonTemp.remove(_persenList[index]);
                          if(_personError.isNotEmpty){
                            setState(() {
                              _personError = "";
                            });
                          }
                        }else{
                          if(_selectPerson.length == 3){
                            setState(() {
                              _personError = "Cant select more than 3 person";
                            });
                          }else{
                            _selectPersonTemp.add(_persenList[index]);
                          }
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
                              _persenList[index].url,
                            ),
                            fit: BoxFit.fill
                          )
                        ),
                        child:Stack(
                          children: [
                            if(_selectPerson.contains(_persenList[index]))
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
                                  _persenList[index].name,
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