import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  static const modes = ["Cipher", "Decipher"];
  String _currentMode = "Cipher";
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController textarea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Widget  tree for home widget
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "Shuffle Cipher",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 53,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: Colors.cyan,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                child: DropdownButton(
                    borderRadius: BorderRadius.circular(12),
                    hint: Text(
                      "Select Mode",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    dropdownColor: Colors.cyan,
                    style: const TextStyle(
                        color: Colors.black, //<-- SEE HERE
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    icon: Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.black,
                    ),
                    items: home.modes.map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget._currentMode = newValue!;
                      });
                    }),
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: textarea,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  decoration: InputDecoration(
                    enabledBorder: createInputBorder(),
                    hintText: "Enter Remarks",
                    focusedBorder: createFocusBorder(),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.cyan), //<-- SEE HERE
                  onPressed: () {},
                  child: Text(
                    "Encrypt",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: textarea,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  decoration: InputDecoration(
                    enabledBorder: createInputBorder(),
                    hintText: "Enter Remarks",
                    focusedBorder: createFocusBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //returns the alternate mode of the cipher's current state.
  switchMode(String mode) {
    return (mode == "Cipher") ? "Decipher" : "Cipher";
  }

  OutlineInputBorder createInputBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.cyan,
          width: 3,
        ));
  }

  OutlineInputBorder createFocusBorder() {
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        ));
  }
}
