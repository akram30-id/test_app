import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final double _padding = 16.0;

  final Color _primarySwatchColor = Colors.orange;
  final Color _titleAppBarColor = Colors.white;
  final Color _buttonColorGrey = Colors.grey[500];
  // final double 24 = 24.0;

  int valueA;
  int valueB;
  var sbValue = StringBuffer();
  String operator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sbValue.write("0");
    operator = "";
  }

  void appendValue(String str) => setState(() {
        bool isDoCalculate = false;
        if (str == "0" && sbValue.toString() == "0") {
          return;
        } else if (str == "=") {
          isDoCalculate = true;
        } else if (str == "/" || str == "x" || str == "-" || str == "+") {
          if (operator.isEmpty) {
            operator = str;
          } else {
            isDoCalculate = true;
          }
        }
        if (!isDoCalculate) {
          if (sbValue.toString() == "0" && str != "0") {
            sbValue.clear();
          }
          sbValue.write(str);
        } else {
          List<String> values = sbValue.toString().split(operator);
          if (values.length == 2 &&
              values[0].isNotEmpty &&
              values[1].isNotEmpty) {
            valueA = int.parse(values[0]);
            valueB = int.parse(values[1]);
            sbValue.clear();
            int total = 0;
            switch (operator) {
              case "/":
                total = valueA ~/ valueB;
                break;
              case "x":
                total = valueA * valueB;
                break;
              case "-":
                total = valueA - valueB;
                break;
              case "+":
                total = valueA + valueB;
            }
            sbValue.write(total);
            if (str == "/" || str == "x" || str == "-" || str == "+") {
              operator = str;
              sbValue.write(str);
            } else {
              operator = "";
            }
          } else {
            String strValue = sbValue.toString();
            String lastCharacter = strValue.substring(strValue.length - 1);
            if (str == "/" || str == "x" || str == "-" || str == "+") {
              sbValue.clear();
              sbValue
                  .write(strValue.substring(0, strValue.length - 1) + "" + str);
              operator = str;
            } else if (str == "=" &&
                (lastCharacter == "/" ||
                    lastCharacter == "x" ||
                    lastCharacter == "-" ||
                    lastCharacter == "+")) {
              operator = "";
              sbValue.clear();
              sbValue.write(strValue.substring(0, strValue.length - 1));
            }
          }
        }
      });

  void deleteValue() => setState(() {
        String strValue = sbValue.toString();
        if (strValue.length > 0) {
          String lastCharacter = strValue.substring(strValue.length - 1);
          if (lastCharacter == "/" ||
              lastCharacter == "x" ||
              lastCharacter == "-" ||
              lastCharacter == "+") {
            operator = "";
          }
          strValue = strValue.substring(0, strValue.length - 1);
          sbValue.clear();
          sbValue.write(strValue.length == 0 ? "0" : strValue);
        }
      });

  void clearValue() {
    setState(() {
      operator = "";
      sbValue.clear();
      sbValue.write("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: _primarySwatchColor),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text(
            "Basic Calculator",
            style: TextStyle(color: _titleAppBarColor),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              key: Key("expanded_bagian_atas"),
              flex: 1,
              child: Container(
                key: Key("expanded_container_bagian_atas"),
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(_padding),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          sbValue.toString(),
                          style: Theme.of(context).textTheme.headline2,
                          maxLines: 1,
                        ),
                        // AutoSizeText(
                        //   sbValue.toString(),
                        //   style: Theme.of(context).textTheme.headline2,
                        //   maxLines: 1,
                        // )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              key: Key("expanded_bagian_bawah"),
              flex: 1,
              child: Column(
                key: Key("expanded_container_bagian_bawah"),
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "C",
                              style: TextStyle(
                                color: _primarySwatchColor,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              clearValue();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Icon(
                              Icons.backspace,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              deleteValue();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "/",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("/");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "7",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("7");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "8",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("8");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "9",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("9");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "x",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("x");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "4",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("4");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "5",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("5");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "6",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("6");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "-",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("-");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "1",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("1");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("2");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("3");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("+");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 3,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text(
                              "0",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("0");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            // elevation: 1.0,
                            color: Colors.blue[900],
                            highlightColor: Colors.grey,
                            child: Text(
                              "=",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            onPressed: () {
                              appendValue("=");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
