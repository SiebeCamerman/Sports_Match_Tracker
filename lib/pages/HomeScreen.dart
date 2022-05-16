import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sports_match_tracker/services/CreateMatch.dart';
import 'package:sports_match_tracker/services/CreateSport.dart';
import 'dart:ui';
//import 'package:hexcolor/hexcolor.dart';
import 'package:sports_match_tracker/services/ColorHex.dart';
import 'package:sports_match_tracker/services/choice_chip_data.dart';
import 'package:sports_match_tracker/data/choice_chips.dart';
import 'package:intl/intl.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool createdLastMatch = false;

  final double spacing = 8;

  List<ChoiceChipData> choiceChips = ChoiceChips.all;

  var chosenSport = "";
  var chosenSportsColor = "";
  var errorSport = "Create";

  Map data = {};

  List<CreateMatch> lastMatches = [
    //CreateMatch("Basketball", 33, 14, "28/03/2022","FFAA33"),
    // CreateMatch("Tennis", 45, 15, "31/03/2022","FDDA0D"),
    // CreateMatch("Basketball", 33, 14, "28/03/2022","FFAA33"),
    // CreateMatch("Soccer", 33, 14, "28/03/2022","52c72e"),
    // CreateMatch("Soccer", 33, 14, "28/03/2022","52c72e"),
    //CreateMatch("Badminton", 0, 100, "01/04/2022","0E4BFF"),
  ];

  List<CreateSport> sportsList = [
    CreateSport("Basketball"),
    CreateSport("Tennis"),
    CreateSport("Soccer"),
  ];

  void selectedSport(){
    for (var i = 0; i<choiceChips.length;i++){
      if (choiceChips[i].isSelected == true){
        chosenSport = choiceChips[i].label.toString();
        chosenSportsColor = choiceChips[i].iconColor.toString();
      }
    }
  }

  void createLastMatch(){
    debugPrint(lastMatches.length.toString());
    if (data['Loaded'] != 1){
      data['Loaded'] = 0;
      createdLastMatch = data['createdLastMatch'];
      if (createdLastMatch == true) {
        data['createdLastMatch'] = false;
        String sport = data['sport'];
        int pointsRed = data['pointsRed'];
        int pointsBlue = data['pointsBlue'];
        String sportsColor = data['color'];
        CreateMatch createMatch = CreateMatch(sport, pointsRed, pointsBlue,
            DateFormat('dd-MM-yyyy').format(DateTime.now()).toString(),
            sportsColor);
        lastMatches.add(createMatch);

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    debugPrint(data.toString());
    createLastMatch();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 760,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 35.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'What do you want',
                    style: GoogleFonts.poppins(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Text(
                    'to play today?',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  child: Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          runSpacing: spacing,
                          spacing: spacing,
                          children: choiceChips
                              .map((choiceChip) => ChoiceChip(
                            label: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(choiceChip.label),
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 16),
                            onSelected: (isSelected) => setState(() {
                              choiceChips = choiceChips.map((otherChip) {
                                final newChip = otherChip.copy(isSelected: false);

                                return choiceChip == newChip
                                    ? newChip.copy(isSelected: isSelected)
                                    : newChip;
                              }).toList();
                            }),
                            selected: choiceChip.isSelected,
                            selectedColor: Color(0xffffc107),
                            backgroundColor: Colors.grey[300],
                          ))
                              .toList(),
                        ),
                      )),
                ),
                SizedBox(height: 40.0),
                Card(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Container(
                    height: 150,
                    width: 350,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0,20.0,0.0,0.0),
                                child: Text(
                                  "New Match",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 35),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedSport();
                                      debugPrint(chosenSport);
                                    });
                                    if (chosenSport.length != 0){
                                      Navigator.pushNamed(context, '/CreateMatch', arguments: {
                                        'sport': chosenSport,
                                        'color': chosenSportsColor,
                                      });
                                    }
                                    else{
                                      errorSport = 'Choose a sport';
                                    }
                                  },
                                    // onPressed: () async{
                                    //   dynamic result = await Navigator.pushNamed(context, '/CreateMatch',arguments: {
                                    //   'sport':_chosenSport,
                                    //
                                    //   });debugPrint("onPressed"+_chosenSport);
                                    //   setState(() {
                                    //     debugPrint("setState"+_chosenSport);
                                    //     lastMatches.add(CreateMatch(result['sport'],result['score1'],result['score2'], result['date'],result['color']));
                                    //   });
                                    // },
                                  child: Text(errorSport),
                                  style: ElevatedButton.styleFrom(
                                    //shape: StadiumBorder(),
                                    primary: Colors.white,
                                    onPrimary: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Image.asset('assets/athlete.png')),
                      ],
                    ),
                  ),
                  elevation: 10,
                  shadowColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  color: Colors.purple[600],
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0),
                  child: Text(
                    "History",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: lastMatches.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(8.0,8.0,8.0,0.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.grey[200],
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 25.0, 0.0),
                                          height: 55,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(15)),
                                            color: ColorHex.fromHex(lastMatches[index].color),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              'assets/${lastMatches[index].sport}.png',
                                              height: 50.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${lastMatches[index].sport}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              '${lastMatches[index].date}',
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0.0,6.0,0.0,0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${lastMatches[index].score1}",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                " : ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${lastMatches[index].score2}",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
      ),
    );
  }
}

