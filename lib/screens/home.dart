import 'dart:ui';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  static const modes = ["Cipher", "Decipher"];
  String _currentMode = "Cipher";
  bool _sudo = false;
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //Controller object for input text area.
  TextEditingController textarea1 = TextEditingController();
  //Controller object for output text area.
  TextEditingController textarea2 = TextEditingController();
  @override
  void initState() {
    //TODO: Initialize the state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Widget  tree for home widget
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                      widget._sudo ? "!Sudo Mode!" : "Shuffle Cipher",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 44,
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
                      hint: Padding(
                        padding: const EdgeInsets.only(
                          right: 5.0,
                          left: 5.0,
                        ),
                        child: Text(
                          "Select Mode",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      dropdownColor: Colors.cyan,
                      style: GoogleFonts.dmSans(
                          color: Colors.black, //<-- SEE HERE
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Colors.black,
                        size: 16,
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
                          _modeSwitch();
                        });
                      }),
                ),
              ),
              Expanded(
                flex: 14,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextField(
                    style: GoogleFonts.aldrich(
                      fontWeight: FontWeight.bold,
                      color: (widget._sudo) ? Colors.cyan : Colors.white,
                    ),
                    controller: textarea1,
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    decoration: InputDecoration(
                      enabledBorder: createInputBorder(),
                      hintText: "Enter text here",
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
                      backgroundColor: Colors.cyan,
                    ),
                    onPressed: () {
                      String input = textarea1.text;
                      String output = "";
                      if (widget._currentMode == "Cipher") {
                        output = _doCiphering(input);
                      } else {
                        output = _doDeciphering(input);
                      }
                      setState(() {
                        textarea2.text = output;
                      });
                    },
                    child: Text(
                      widget._currentMode,
                      style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    style: GoogleFonts.aldrich(
                      fontWeight: FontWeight.bold,
                      color: (widget._sudo) ? Colors.cyan : Colors.white,
                    ),
                    controller: textarea2,
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    decoration: InputDecoration(
                      enabledBorder: createInputBorder(),
                      hintText: "Output text here",
                      focusedBorder: createFocusBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  //A basic cipher function which ciphers plain String value
  //"input" by boosting each value in the String by integer value "key"
  String _quickCipher(String input) {
    String output = "";
    Random generator = Random();
    int key = generator.nextInt(10000) + 200;
    for (int i = 0; i < input.length; i++) {
      output += String.fromCharCode(input.codeUnitAt(i) + key);
    }
    output += String.fromCharCode(key);
    return output;
  }

  //A basic implementation of a quick decipher function, this
  //function works by reducing the value of each character in the String by ASCII value "key"
  String _quickDecipher(String input) {
    String output = "";
    int key = input.codeUnitAt(input.length - 1);
    for (int i = 0; i < input.length - 1; i++) {
      output += String.fromCharCode(input.codeUnitAt(i) - key);
    }
    return output;
  }

  //This function calls all other cipher-related functions.
  String _doCiphering(String input) {
    String output = "";
    input = _padding(input);
    input = _shuffle(input);
    output = _quickCipher(input);
    return output;
  }

  //This function calls all other deciphering related functions.
  String _doDeciphering(String input) {
    String output = "";
    output = _quickDecipher(input);
    output = _unshuffle(output);
    return output.trim();
  }

  //This function helps in clearing
  //the text-boxes on a switch between cipher and
  //decipher modes- does not call setState() itself.
  void _modeSwitch() {
    textarea1.clear();
    textarea2.clear();
  }

  //This function shuffles characters in the
  //string.
  String _shuffle(String input) {
    String output = "";
    for (int i = 0; i < input.length; i++) {
      int ch = input.codeUnitAt(i);
      if (i % 2 == 0) {
        ++ch;
      } else {
        --ch;
      }
      output += String.fromCharCode(ch);
    }

    int pos = 0;

    Random r = Random();
    pos = r.nextInt(output.length - 1);
    if (pos == 0) {
      ++pos;
    }
    //pos is the index anchor around which the first part of the string is reversed.
    String part1 = output.substring(0, pos);
    String part2 = output.substring(pos);

    part1 = String.fromCharCodes(part1.codeUnits.reversed);
    output = part1 + part2;
    return (output + String.fromCharCode(pos));
  }

  String _unshuffle(String input) {
    String output = "";
    int kindex = input.codeUnitAt(input.length - 1);
    output = input.substring(0, input.length - 1);
    String sp = output.substring(0, kindex);
    String pp = output.substring(kindex);
    sp = String.fromCharCodes(sp.codeUnits.reversed);
    output = sp + pp;
    String temp = "";
    for (int i = 0; i < output.length; i++) {
      int ch = output.codeUnitAt(i);
      if (i % 2 == 0) {
        --ch;
      } else {
        ++ch;
      }
      temp += String.fromCharCode(ch);
    }
    output = temp;
    return output;
  }

  //Concatenates 4 spaces to the beginning of the
  //String
  String _padding(String input) {
    return "    $input";
  }
}
