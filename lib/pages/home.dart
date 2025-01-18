// ignore_for_file: deprecated_member_use

import 'package:Calculator/services/system.dart';
import 'package:Calculator/services/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "C") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
    String buttonText,
    double buttonHeight,
    Color buttonTextColor,
    Color buttonColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(
            Radius.circular(23),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(90.0),
            ),
            padding: EdgeInsets.all(16.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: buttonTextColor,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModal themeNotifier, child) {
      !themeNotifier.isDark ? setLightTheme() : setDarkTheme();
      return Scaffold(
        backgroundColor:
            !themeNotifier.isDark ? Colors.white : Color(0xFF22252D),
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              !themeNotifier.isDark ? Colors.white : Color(0xFF22252D),
          title: Text(
            "Calculator",
            style: TextStyle(
              color: themeNotifier.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Transform.scale(
              scale: 0.8,
              child: ToggleSwitch(
                minWidth: 70.0,
                minHeight: 60.0,
                initialLabelIndex: !themeNotifier.isDark ? 0 : 1,
                cornerRadius: 20.0,
                activeFgColor:
                    themeNotifier.isDark ? Colors.white : Colors.black,
                inactiveBgColor: themeNotifier.isDark
                    ? Color(0xFF2A2D37)
                    : Color(0xFFF9F9F9),
                inactiveFgColor: Colors.grey,
                activeBgColor: [
                  themeNotifier.isDark ? Color(0xFF2A2D37) : Color(0xFFF9F9F9),
                ],
                totalSwitches: 2,
                icons: [
                  Icons.wb_sunny_rounded,
                  Icons.mode_night_outlined,
                ],
                iconSize: 30.0,
                animate: false,
                curve: Curves.bounceInOut,
                onToggle: (value) {
                  if (themeNotifier.isDark) {
                    themeNotifier.isDark = false;
                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark,
                        systemNavigationBarColor: Color(0xFFF9F9F9),
                        systemNavigationBarIconBrightness: Brightness.dark,
                      ),
                    );
                  } else {
                    themeNotifier.isDark = true;
                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        statusBarColor: Color(0xFF22252D),
                        statusBarIconBrightness: Brightness.light,
                        systemNavigationBarColor: Color(0xFF2A2D37),
                        systemNavigationBarIconBrightness: Brightness.light,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: Container()),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 30,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: 60,
                  color: themeNotifier.isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.transparent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? Color(0xFF2A2D37)
                        : Color(0xFFF9F9F9),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                  ),
                  width: MediaQuery.of(context).size.width * .75,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Table(
                        children: [
                          TableRow(children: [
                            buildButton(
                                "AC",
                                1,
                                Color(0xFF9FFEF8),
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "C",
                                1,
                                Color(0xFF9FFEF8),
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "%",
                                1,
                                Color(0xFF9FFEF8),
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                          ]),
                          TableRow(children: [
                            buildButton(
                                "7",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "8",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "9",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                          ]),
                          TableRow(children: [
                            buildButton(
                                "4",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "5",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "6",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                          ]),
                          TableRow(children: [
                            buildButton(
                                "1",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "2",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                              "3",
                              1,
                              themeNotifier.isDark
                                  ? Colors.white
                                  : Colors.black,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                          TableRow(children: [
                            buildButton(
                                ".",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                                "0",
                                1,
                                themeNotifier.isDark
                                    ? Colors.white
                                    : Colors.black,
                                themeNotifier.isDark
                                    ? Color(0xFF282B33)
                                    : Color(0xFFF7F7F7)),
                            buildButton(
                              "00",
                              1,
                              themeNotifier.isDark
                                  ? Colors.white
                                  : Colors.black,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? Color(0xFF2A2D37)
                        : Color(0xFFF9F9F9),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(50)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      Table(
                        children: [
                          TableRow(children: [
                            buildButton(
                              "×",
                              1,
                              Colors.redAccent,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                          TableRow(children: [
                            buildButton(
                              "-",
                              1,
                              Colors.redAccent,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                          TableRow(children: [
                            buildButton(
                              "+",
                              1,
                              Colors.redAccent,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                          TableRow(children: [
                            buildButton(
                              "÷",
                              1,
                              Colors.redAccent,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                          TableRow(children: [
                            buildButton(
                              "=",
                              1,
                              Colors.redAccent,
                              themeNotifier.isDark
                                  ? Color(0xFF282B33)
                                  : Color(0xFFF7F7F7),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
