import 'package:flutter/material.dart';
import 'package:sports_match_tracker/services/CreateMatch.dart';


class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}
extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
class _testState extends State<test> {

  List<CreateMatch> lastMatches = [
    CreateMatch("Basketball", 33, 14, "28/03/2022","0xFF42A5F5"),
    CreateMatch("Basketball", 20, 14, "28/03/2022","0xFF42A5F5"),
    CreateMatch("Basketball", 33, 44, "28/03/2022","0xFF42A5F5"),
    CreateMatch("Basketball", 69, 69, "28/03/2022","0xFF42A5F5"),
  ];

  List<String> chipList = [
    "Recycled",
    "Vegetarian",
    "Skilled",
    "Energetic",
    "Friendly",
    "Luxurious"
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.timelapse,
              color: Colors.black,
            ),
            onPressed: () {}),
        title: Text(
          "Synonym Flashcards",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.panorama_photosphere,
                color: Colors.black,
              ),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Center(
        child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          shadowColor: Color(0x802196F3),
          child: Container(
            width: 380,
            height: 400,
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  //color: new Color(0xffffc107),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color(0xffffc107),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Question 3',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'Find the synonym of',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'Adroit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 42.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                Container(
                    child: Wrap(
                      spacing: 5.0,
                      runSpacing: 5.0,
                      children: <Widget>[
                        choiceChipWidget(chipList),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    child: RaisedButton(
                        color: Color(0xffffbf00),
                        child: new Text(
                          'Next',
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
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

class choiceChipWidget extends StatefulWidget {
  final List<String> reportList;

  choiceChipWidget(this.reportList);

  @override
  _choiceChipWidgetState createState() => new _choiceChipWidgetState();
}

class _choiceChipWidgetState extends State<choiceChipWidget> {
  String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Color(0xffededed),
          selectedColor: Color(0xffffc107),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}