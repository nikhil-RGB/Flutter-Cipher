import 'dart:ui';

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
            Container(
              padding: const EdgeInsets.only(bottom: 31),
              child: Text(
                "Shuffle Cipher",
                style: TextStyle(
                    fontSize: 43,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.cyan,
              ),
              child: DropdownButton(
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: textarea,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  enabledBorder: createInputBorder(),
                  hintText: "Enter Remarks",
                  focusedBorder: createFocusBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: textarea,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  enabledBorder: createInputBorder(),
                  hintText: "Enter Remarks",
                  focusedBorder: createFocusBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.cyan), //<-- SEE HERE
                onPressed: () {},
                child: Text(
                  "Encrypt",
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
