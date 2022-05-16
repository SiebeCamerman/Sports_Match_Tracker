import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_match_tracker/services/CreatePlayer.dart';
import 'package:sports_match_tracker/services/filter_chip_data.dart';
import 'package:sports_match_tracker/data/filter_chip_data.dart';
import 'dart:async';
import 'dart:math';

//bug je kan niet meer dan 9 uur instellen
//optie om break after every: uitzetten bijmaken

class CreateMatch extends StatefulWidget {
  const CreateMatch({Key? key}) : super(key: key);

  @override
  State<CreateMatch> createState() => _CreateMatchState();
}

class _CreateMatchState extends State<CreateMatch> {
  bool generated = false;
  String errorGenerated = "Create match";

  Map data = {};

  final double spacing = 8;

  List<FilterChipData> filterChip1 = FilterChip1.all;
  List<FilterChipData> filterChip2 = FilterChip2.all;

  List<FilterChipData> selectedPlayers = [

  ];
  var rng = Random();

  var valueM = "";
  var valueB = "";

  List<CreatePlayer> players = [
    CreatePlayer('Jens'),
    CreatePlayer('player1'),
    CreatePlayer('player2'),
    CreatePlayer('player3'),
    CreatePlayer('player4'),
    CreatePlayer('player5'),
    CreatePlayer('player6'),
    CreatePlayer('player7'),
    CreatePlayer('player8'),
  ];

  List<String> teamRed = [

  ];

  List<String> teamBlue = [

  ];

  void generateTeam(){
    teamRed = [];
    teamBlue = [];
    selectedPlayers = [];
    for (var i = 0; i < filterChip1.length; i++) {
        if (filterChip1[i].isSelected == true) {
          selectedPlayers.add(filterChip1[i]);
          filterChip1[i].isSelected = false;
        }
      }
      for (var i = 0; i < filterChip2.length; i++) {
        if (filterChip2[i].isSelected == true) {
          selectedPlayers.add(filterChip2[i]);
          filterChip2[i].isSelected = false;
        }
      }
      selectedPlayers.shuffle();
      selectedPlayers.shuffle();
      selectedPlayers.shuffle();
    for (var i = 0; i < ((selectedPlayers.length) ~/2)+(selectedPlayers.length) %2; i++) {
      teamRed.add(selectedPlayers[i].label);
      selectedPlayers[i].color = Colors.red;
    }
    for (var i = 0; i < (selectedPlayers.length) ~/2; i++) {
      teamBlue.add(selectedPlayers[i+((selectedPlayers.length) ~/2)+(selectedPlayers.length) %2].label);
      selectedPlayers[i+((selectedPlayers.length) ~/2)+(selectedPlayers.length) %2].color = Colors.blue;
    }

      // for (var i = 0; i < filterChip1.length; i++) {
      //   if (filterChip1[i].isSelected == true) {
      //     selectedPlayers.add(filterChip1[i].label);
      //     filterChip1[i].isSelected = false;
      //     int randomNumber = rng.nextInt(2);
      //     if (randomNumber == 0) {
      //       teamRed.add(filterChip1[i].label);
      //       filterChip1[i].color = Colors.red;
      //     }
      //     else if (randomNumber == 1) {
      //       teamBlue.add(filterChip1[i].label);
      //       filterChip1[i].color = Colors.blue;
      //     }
      //   }
      // }
      // for (var i = 0; i < filterChip2.length; i++) {
      //   if (filterChip2[i].isSelected == true) {
      //     selectedPlayers.add(filterChip2[i].label);
      //     filterChip2[i].isSelected = false;
      //     int randomNumber = rng.nextInt(2);
      //     if (randomNumber == 0) {
      //       teamRed.add(filterChip2[i].label);
      //       filterChip2[i].color = Colors.red;
      //     }
      //     else if (randomNumber == 1) {
      //       teamBlue.add(filterChip2[i].label);
      //       filterChip2[i].color = Colors.blue;
      //     }
      //   }
      // }


  debugPrint('test'+selectedPlayers.length.toString());
    debugPrint(teamRed.length.toString());
    debugPrint(teamBlue.length.toString());
    // while(teamRed.length>0 && teamBlue.length>0 && teamRed.length==(selectedPlayers.length/2)&& teamBlue.length==(selectedPlayers.length/2)) {
    //   selectedPlayers.remove;
    //   for (var i = 0; i < selectedPlayers.length; i++) {
    //     int randomNumber = rng.nextInt(2);
    //     if (randomNumber == 0) {
    //       teamRed.add(selectedPlayers[i]);
    //     }
    //     else if (randomNumber == 1) {
    //       teamBlue.add(selectedPlayers[i]);
    //     }
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    debugPrint(data.toString());
    return Scaffold(
      //backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        title: Text('Create a new match'),
        centerTitle: true,
        //elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: 680,
          child: Column(
            children: [
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    //runSpacing: spacing,
                    //spacing: spacing,
                    children: filterChip1
                        .map((filterChip) => Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10.0, 0.0, 0.0),
                          child: FilterChip(
                      label: Text(filterChip.label),
                      labelStyle: TextStyle(
                          color: filterChip.color,
                      ),
                      backgroundColor: filterChip.color.withOpacity(0.1),
                      onSelected: (isSelected) => setState(() {
                          filterChip1 = filterChip1.map((otherChip) {
                            return filterChip == otherChip
                                ? otherChip.copy(isSelected: isSelected)
                                : otherChip;
                          }).toList();
                      }),
                      selected: filterChip.isSelected,
                      checkmarkColor: filterChip.color,
                      selectedColor: Color(0xffeadffd),
                    ),
                        ))
                        .toList(),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    //runSpacing: spacing,
                    //spacing: spacing,
                    children: filterChip2
                        .map((filterChip) => Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 0.0),
                          child: FilterChip(
                      label: Text(filterChip.label),
                      labelStyle: TextStyle(
                          color: filterChip.color,
                      ),
                      backgroundColor: filterChip.color.withOpacity(0.1),
                      onSelected: (isSelected) => setState(() {
                          filterChip2 = filterChip2.map((otherChip) {
                            return filterChip == otherChip
                                ? otherChip.copy(isSelected: isSelected)
                                : otherChip;
                          }).toList();
                      }),
                      selected: filterChip.isSelected,
                      checkmarkColor: filterChip.color,
                      selectedColor: Color(0xffeadffd),
                    ),
                        ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    generateTeam();
                    if(teamRed.length > 0){
                      generated = true;
                    }
                    debugPrint(teamRed.toString());
                    debugPrint(teamBlue.toString());

                  });
                },
                child: Text('Generate Team'),
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  //shape: StadiumBorder(),
                  primary: Colors.purple[600],
                  onPrimary: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SizedBox(height: 40),
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
                              'Total match time:',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(height:10),
                            SizedBox(
                              height: 100,
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hms,
                                initialTimerDuration: Duration(hours: 0, minutes:0, seconds: 0),
                                onTimerDurationChanged: (value){
                                  setState(() {
                                    this.valueM = value.toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
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
                              'break after every:',
                              style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 22.0,),
                            ),

                            SizedBox(height:10),
                            SizedBox(
                              height: 100,
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.ms,
                                initialTimerDuration: Duration(minutes:0, seconds: 0),
                                onTimerDurationChanged: (value){
                                  setState(() {
                                    this.valueB = value.toString();
                                  });
                                },
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
                                if (generated == true){
                                  Navigator.pushNamed(context, '/ActiveMatch', arguments: {
                                    'teamRed':teamRed,
                                    'teamBlue':teamBlue,
                                    'total':valueM,
                                    'break':valueB,
                                    'sport':data['sport'],
                                    'color':data['color']
                                  });
                                }
                                else{
                                  setState(() {
                                    errorGenerated = "Generate a team";
                                  });
                                }
                              },
                              child: Text(errorGenerated),
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                //shape: StadiumBorder(),
                                  primary: Colors.greenAccent[700],
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
              )
              //SizedBox(height: 650)
            ],
          ),
        ),
      ),
    );
  }
}
class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key? key, required this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {

  List<String> test = [

  ];

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(color: Colors.black,fontSize: 15.0),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            30.0),),
      backgroundColor: Colors.grey[300],
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          _isSelected ? test.add(widget.chipName): test.remove(widget.chipName);
          debugPrint('$_isSelected'+widget.chipName);
          debugPrint(test.toString());
        });
      },
      selectedColor: Color(0xffeadffd),);
  }
}