import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:sports_match_tracker/services/PopWithResults.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';



class ActiveScreen extends StatefulWidget {
  const ActiveScreen({Key? key}) : super(key: key);

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  final playerAudio = AudioCache();
  int secondsTotal = 0;
  int minutesTotal = 0;
  int hoursTotal = 0;
  String outputSecTotal = "00";
  String outputMinTotal = "00";
  String outputHourTotal = "00";
  Timer? timerTotal;

  int secondsBreak = 0;
  int minutesBreak = 0;
  Timer? timerBreak;

  void startTimerTotal(){
    timerTotal = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsTotal > 0) {
        setState(() {
          secondsTotal--;
        });
      }
      else if (minutesTotal > 0){
        setState(() {
          minutesTotal--;
          secondsTotal = 59;
        });
      }
      else if (hoursTotal > 0){

        setState(() {
          hoursTotal--;
          secondsTotal = 59;
          minutesTotal = 59;
        });
      }
      else{
        stopTimerTotal();
        stopTimerBreak();
        playerAudio.play("Track6.mp3");
        Future.delayed(const Duration(seconds: 10), () {
          Navigator.pushReplacementNamed(context, '/HomeScreen',arguments: {
            'pointsRed': pointRed,
            'pointsBlue': pointBlue,
            'sport':data['sport'],
            'color':data['color'],
            'createdLastMatch':true,
          });
        });
      }
    });
  }

  void startTimerBreak(){
    timerBreak = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsBreak > 0) {
        setState(() {
          secondsBreak--;
        });
      }
      else if (minutesBreak > 0){
        setState(() {
          minutesBreak--;
          secondsBreak = 59;
        });
      }
      else{
        stopTimerBreak();
        if (data['break'].toString().length != 0){
          stopTimerTotal();
        }
        playerAudio.play('Track4.mp3');
        Future.delayed(const Duration(minutes: 5), () {
          startTimerTotal();
          initBreak();
        });
      }
    });
  }
  // void outputTimer(){
  //   if (seconds<10){
  //     outputSecTotal = "0$seconds";
  //   }
  //   else if (seconds>10){
  //     setState(() {
  //       outputSecTotal = "$seconds";
  //     });
  //   }
  //   if (minutes<10){
  //     setState(() {
  //       outputSecTotal = "0$minutes";
  //     });
  //   }
  //   else if (minutes>10){
  //     setState(() {
  //       outputSecTotal = "$minutes";
  //     });
  //   }
  //   if (hours<10){
  //     setState(() {
  //       outputSecTotal = "0$hours";
  //     });
  //   }
  //   else if (hours>10){
  //     setState(() {
  //       outputSecTotal = "$hours";
  //     });
  //   }
  // }
  void stopTimerTotal(){
    timerTotal?.cancel();
  }

  void stopTimerBreak(){
    timerBreak?.cancel();
  }

  void initTotal(){
    setState(() {
      secondsTotal = int.parse(data['total'].toString().substring(5,7));
      minutesTotal= int.parse(data['total'].toString().substring(2,4));
      hoursTotal = int.parse(data['total'].toString().substring(0,1));
      debugPrint('$hoursTotal:$minutesTotal:$secondsTotal');
    });
    startTimerTotal();
  }

  void initBreak(){
    setState(() {
      secondsBreak = int.parse(data['break'].toString().substring(5,7));
      minutesBreak= int.parse(data['break'].toString().substring(2,4));
      debugPrint('$minutesBreak:$secondsBreak');
    });
    startTimerBreak();
  }

  var pointRed = 0;
  var pointBlue = 0;
  var timeBreak = "test";
  var timeTotal = "test";


  List<String> teamRed = [

  ];

  List<String> teamBlue = [

  ];

  Map data = {};



  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (data['break'].toString().length != 0 && data['break'].toString() != "0:00:00.000000"){
        initBreak();
      }
    initTotal();
    debugPrint('initialized');
    debugPrint(data['break'].toString());
    debugPrint(data['total'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;
    debugPrint(data.toString());
    debugPrint('break'+data['break'].toString().length.toString());
    teamRed = data['teamRed'];
    teamBlue = data['teamBlue'];
    //debugPrint(data.toString());
    //timeBreak = data['break'];
    //timeTotal = data['total'];



    // final test1 = data['total'].toString();
    // Timer(
    //     Duration(seconds: 1), (){
    //   setState(() {
    //     debugPrint('kut'+test1);
    //     timeTotal = "0:00:00";
    //     debugPrint(timeTotal);
    //   });
    // });
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 764,
          child: SafeArea(
            child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      Card(
                        elevation: 10,
                        shadowColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 350,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time Remaining:',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '$hoursTotal:$minutesTotal:$secondsTotal',
                                //timeTotal,
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0.0,6.0,0.0,0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Add points',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      pointRed = pointRed +3;
                                                    });
                                                  },
                                                  child: Text('+3'),
                                                  style: ElevatedButton.styleFrom(
                                                    //shape: StadiumBorder(),
                                                    primary: Color(0xffffc107),
                                                    elevation: 0,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      pointRed = pointRed +2;
                                                    });
                                                  },
                                                  child: Text('+2'),
                                                  style: ElevatedButton.styleFrom(
                                                    //shape: StadiumBorder(),
                                                    primary: Color(0xffffc107),
                                                    elevation: 0,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      pointRed = pointRed -1;
                                                    });
                                                  },
                                                  child: Text('-1'),
                                                  style: ElevatedButton.styleFrom(
                                                    //shape: StadiumBorder(),
                                                    primary: Color(0xffffc107),
                                                    elevation: 0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      //shape: StadiumBorder(),
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      pointRed.toString(),
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),


                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0.0,8.0,0.0),
                                child: Text(
                                  " : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                  'Add points',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ElevatedButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            pointBlue = pointBlue +3;
                                                          });
                                                        },
                                                        child: Text('+3'),
                                                      style: ElevatedButton.styleFrom(
                                                        //shape: StadiumBorder(),
                                                        primary: Color(0xffffc107),
                                                        elevation: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ElevatedButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          pointBlue = pointBlue +2;
                                                        });
                                                      },
                                                      child: Text('+2'),
                                                      style: ElevatedButton.styleFrom(
                                                        //shape: StadiumBorder(),
                                                        primary: Color(0xffffc107),
                                                        elevation: 0,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ElevatedButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          pointBlue = pointBlue -1;
                                                        });
                                                      },
                                                      child: Text('-1'),
                                                      style: ElevatedButton.styleFrom(
                                                        //shape: StadiumBorder(),
                                                        primary: Color(0xffffc107),
                                                        elevation: 0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: Text(
                                                        'Cancel',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                ),
                                              ],
                                            ),
                                        );
                                      },
                                    style: ElevatedButton.styleFrom(
                                      //shape: StadiumBorder(),
                                      primary: Colors.transparent,
                                      elevation: 0,
                                    ),
                                      child: Text(
                                        pointBlue.toString(),
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 60,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0,0.0,0.0,0.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        reverse: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ((teamRed.length) ~/2)+(teamRed.length) %2,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(2.5, 0.0, 2.5, 0.0),
                                              child: Container(
                                                //width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.red[300],
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                //margin: EdgeInsets.all(10),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.5),
                                                  child: Text(
                                                    teamRed[index],
                                                      textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    SizedBox(height: 15),
                                    Expanded(
                                      child: ListView.builder(
                                        reverse: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ((teamRed.length) ~/2),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(2.5, 0.0, 2.5, 0.0),
                                              child: Container(
                                                //width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[300],
                                                      border: Border.all(
                                                        color: Colors.transparent,
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.5),
                                                    child: Text(
                                                      teamRed[index+((teamRed.length) ~/2)+(teamRed.length) %2],
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(2.5,0.0,10.0,0.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ((teamBlue.length) ~/2)+(teamBlue.length) %2,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(2.5, 0.0, 2.5, 0.0),
                                              child: Container(
                                                //width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue[300],
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                                ),
                                                //margin: EdgeInsets.all(10),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.5),
                                                  child: Text(
                                                    teamBlue[index],
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                    SizedBox(height: 15),
                                    Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: ((teamBlue.length) ~/2),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.fromLTRB(2.5, 0.0, 2.5, 0.0),
                                              child: Container(
                                                  //width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue[300],
                                                      border: Border.all(
                                                        color: Colors.transparent,
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                                  ),
                                                  child:
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.5),
                                                    child: Text(
                                                      teamBlue[index+((teamBlue.length) ~/2)+(teamBlue.length) %2],
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 55),
                      Card(
                        elevation: 10,
                        shadowColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 350,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Till Break:',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height:10),
                              Text(
                                '$minutesBreak:$secondsBreak',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,40.0,0.0,40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, '/HomeScreen',arguments: {
                                    'pointsRed': pointRed,
                                    'pointsBlue': pointBlue,
                                    'sport':data['sport'],
                                    'color':data['color'],
                                    'createdLastMatch':true,
                                  });
                                  stopTimerTotal();
                                  stopTimerBreak();
                                },
                                child: Text('Stop match'),
                                style: ElevatedButton.styleFrom(
                                  elevation: 5,
                                  //shape: StadiumBorder(),
                                  primary: Colors.red,
                                  onPrimary: Colors.black,
                                  textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
