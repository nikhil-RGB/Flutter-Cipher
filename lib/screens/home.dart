//import 'dart:html';
import 'dart:ui';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordfield/passwordfield.dart';

class home extends StatefulWidget {
  static const modes = ["Cipher", "Decipher"];
  String _currentMode = "Cipher";
  bool _psswd_enabled = false;
  BuildContext? _context;
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //Controller object for input text area.
  TextEditingController textarea1 = TextEditingController();
  //Controller object for output text area.
  TextEditingController textarea2 = TextEditingController();
  //Password field for password field.
  TextEditingController cipher_psswd_inp = TextEditingController();

  @override
  void initState() {
    //TODO: Initialize the state.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget._context = context;
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
                flex: 9,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      widget._psswd_enabled
                          ? "Secure Cipher"
                          : "Shuffle Cipher",
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
                child: Transform.scale(
                  scaleX: 0.85,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: DropdownButton(
                              borderRadius: BorderRadius.circular(12),
                              hint: const Padding(
                                padding: EdgeInsets.only(
                                  right: 5.0,
                                  left: 20.0,
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
                                  if (widget._currentMode == "Decipher") {
                                    widget._psswd_enabled = false;
                                  }
                                });
                              }),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(right: 10.0, left: 10.0),
                          child: Transform.scale(
                            scaleY: 1.25,
                            child: Card(
                              color: (widget._currentMode == "Decipher")
                                  ? Colors.grey
                                  : Colors.cyan,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (widget._currentMode == "Decipher") {
                                      return;
                                    }
                                    widget._psswd_enabled =
                                        !widget._psswd_enabled;
                                  });
                                },
                                splashColor: (widget._currentMode == "Decipher")
                                    ? Colors.transparent
                                    : Colors.blueAccent,
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.7,
                                      child: Checkbox(
                                          value: widget._psswd_enabled,
                                          onChanged: (changed) {}),
                                    ),
                                    Text(
                                      "Password Protection",
                                      style: GoogleFonts.dmSans(
                                          color: Colors.black, //<-- SEE HERE
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 14,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: TextField(
                    style: GoogleFonts.aldrich(
                      fontWeight: FontWeight.bold,
                      color:
                          (widget._psswd_enabled) ? Colors.cyan : Colors.white,
                    ),
                    controller: textarea1,
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        color: Colors.cyan,
                        focusColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            (Clipboard.getData(Clipboard.kTextPlain))
                                .then((value) {
                              String text = (value?.text) ?? "";
                              textarea1.text = text;
                            });
                          });
                        },
                        icon: const Icon(Icons.paste_rounded),
                      ),
                      enabledBorder: createInputBorder(),
                      hintText: "Enter text here",
                      focusedBorder: createFocusBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
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
                        _callCipherOperation(input).then((value) {
                          output = value;
                          setState(() {
                            textarea2.text = output;
                          });
                        });
                      } else {
                        _callDecipherOperation(input).then((value) {
                          output = value;
                          setState(() {
                            textarea2.text = output;
                          });
                        });
                      }
                    },
                    child: Text(
                      widget._currentMode,
                      style: GoogleFonts.dmSans(
                          fontSize: 16,
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
                    enableInteractiveSelection: false,
                    focusNode: AlwaysDisabledFocusNode(),
                    style: GoogleFonts.aldrich(
                      fontWeight: FontWeight.bold,
                      color:
                          (widget._psswd_enabled) ? Colors.cyan : Colors.white,
                    ),
                    controller: textarea2,
                    keyboardType: TextInputType.multiline,
                    maxLines: 11,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        color: Colors.cyan,
                        focusColor: Colors.white,
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: textarea2.text));
                        },
                        icon: const Icon(Icons.copy_all_rounded),
                      ),
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
  Future<String> _doCiphering(String input) async {
    if (input == "") {
      return "";
      //empty input validation
    }
    String output = "";
    try {
      input = _padding(input);
      input = _shuffle(input);
      output = _quickCipher(input);
    } catch (exception) {
      await openErrorDialog("Cipher Failure",
          "An error occurred while processing the input", true);
      return "";
    }
    return output;
  }

  //This function calls all other deciphering related functions.
  Future<String> _doDeciphering(String input) async {
    if (input == "") {
      return "";
      //empty input validation
    }
    try {
      String output = "";
      output = _quickDecipher(input);
      output = _unshuffle(output);
      return output.trim();
    } catch (exception) {
      await openErrorDialog(
          "Decipher failure",
          "This message cannot be Deciphered as it's format is unrecognized.",
          true);

      return "";
    }
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

  String _providePasswordLine(bool provide, String password) {
    String line = "";
    if (provide) {
      line = _quickCipher("true $password");
    } else {
      line = _quickCipher("false");
    }
    return line;
  }

  Future openPasswordDialog() => showDialog(
      context: widget._context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0))),
          title: Text(
            "${widget._currentMode} Operation Password",
            style: GoogleFonts.dmSans(
              color: Colors.cyan,
            ),
          ),
          backgroundColor: Color(0XFF004246),
          content: PasswordField(
            backgroundColor: Colors.black,
            color: Colors.cyan,
            controller: cipher_psswd_inp,
            maxLength: 10,
            passwordConstraint: r'^\w[a-zA-Z@#0-9.]*$',
            inputDecoration: PasswordDecoration(
              hintStyle: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
              inputStyle: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            hintText: 'Enter Password',
            border: PasswordBorder(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue.shade100,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue.shade100,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 2, color: Colors.red.shade200),
              ),
            ),
            errorMessage: 'must not contain spaces',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, "");
                cipher_psswd_inp.clear();
              },
              child: Text("Cancel", style: GoogleFonts.dmSans()),
            ),
            ElevatedButton(
              onPressed: () {
                if (cipher_psswd_inp.text.contains(" ") ||
                    cipher_psswd_inp.text == "") {
                  return;
                }

                Navigator.pop(context, cipher_psswd_inp.text);
                cipher_psswd_inp.clear();
              },
              child: Text("Confirm", style: GoogleFonts.dmSans()),
            ),
          ],
        );
      });

  Future openErrorDialog(String? error_title, String details, bool clear) =>
      showDialog(
        context: widget._context!,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              error_title ?? "An Error occurred",
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            content: Text(
              details,
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (clear) {
                    cipher_psswd_inp.clear();
                  }
                },
                child: Text("Ok", style: GoogleFonts.dmSans()),
              ),
            ],
            backgroundColor: Color(0XFF004246),
          );
        },
      );

  Future<String> _callCipherOperation(String input) async {
    String password_line = "";
    String result = "";
    String output = await _doCiphering(input);
    if (widget._psswd_enabled) {
      String password = await openPasswordDialog();
      if (password == "") {
        return "";
      }
      password_line = _providePasswordLine(true, password);
      result = "$password_line\n$output";
    } else {
      password_line = _providePasswordLine(false, "");
      result = "$password_line\n$output";
    }
    return result;
  }

  Future<String> _callDecipherOperation(String input) async {
    if (input == "") {
      return "";
    }
    List<String> lines = input.split("\n");
    String password_line = _quickDecipher(lines.removeAt(0));
    input = lines.join("\n");
    bool flag = password_line.split(" ")[0] == "true";

    if (flag) {
      String password = password_line.split(" ")[1];

      String userp;
      do {
        userp = await openPasswordDialog();
        if (userp == "") {
          return "";
        }
        if (userp != password) {
          await openErrorDialog(
              "Incorrect Password",
              "Password Entered was incorrect.\nPlease try again with a different password.",
              true);
        }
      } while (userp != password);
    }
    return _doDeciphering(input);
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
