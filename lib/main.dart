import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pwd_generator/toggleSwitch.dart';
import 'package:random_string/random_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String randomStr = 'No Password Generated';
  bool includeNumbers = false;
  bool includeLowercase = true;
  bool includeUppercase = true;
  bool includeSymbols = false;
  double length = 12;
  int roundedLength = 12;

  // bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFfffcf9),
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Driod',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                TextSpan(
                  text: 'Pass',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xfff2f2ee),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'PASSWORD -',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          // 'dsfs',
                          randomStr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: () async {
                            await Clipboard.setData(
                                ClipboardData(text: randomStr));
                            // copied successfully
                          },
                          icon: Icon(Icons.content_copy_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                '- - - -   SETTINGS   - - - -',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xfff2f2ee)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LENGTH: $roundedLength',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              activeColor: Colors.blue,
                              inactiveColor: Colors.blue[100],
                              value: length,
                              onChanged: (value) {
                                setState(() {
                                  length = value;
                                  roundedLength = length.round();
                                });
                              },
                              max: 50,
                              min: 0,
                            ),
                          ),
                          Text(
                            '50',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    toggleSwitch(
                      textConstraint: '(0-9)',
                      constraintVar: includeNumbers,
                      onChanged: (value) {
                        setState(() {
                          includeNumbers = value;
                        });
                      },
                    ),
                    toggleSwitch(
                      textConstraint: '(A-Z)',
                      constraintVar: includeUppercase,
                      onChanged: (value) {
                        setState(() {
                          includeUppercase = value;
                        });
                      },
                    ),
                    toggleSwitch(
                      textConstraint: '(a-z)',
                      constraintVar: includeLowercase,
                      onChanged: (value) {
                        setState(() {
                          includeLowercase = value;
                        });
                      },
                    ),
                    toggleSwitch(
                      textConstraint: '(&*_)',
                      constraintVar: includeSymbols,
                      onChanged: (value) {
                        setState(() {
                          includeSymbols = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Spacer(),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                padding: EdgeInsets.all(20.0),
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    randomStr = generatePassword(
                      roundedLength,
                      includeNumbers,
                      includeLowercase,
                      includeUppercase,
                      includeSymbols,
                    )!;
                    // randomStr = randomAlphaNumeric(10);
                  });

                  // e.g., 'A1B2C3D4E5'
                },
                child: Text(
                  'Generate Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? generatePassword(int roundedLength, bool includeNumbers,
    bool includeLowercase, bool includeUppercase, bool includeSymbols) {
  String numbers = '0123456789';
  String lowercase = 'abcdefghijklmnopqrstuvwxyz';
  String uppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  String symbols = '!@#\$&*_+[]';
  String selectedChar = '';
  if (includeNumbers) selectedChar += numbers;
  if (includeLowercase) selectedChar += lowercase;
  if (includeUppercase) selectedChar += uppercase;
  if (includeSymbols) selectedChar += symbols;
  if (selectedChar == '') selectedChar += randomAlphaNumeric(10);
  print(selectedChar);
  List pwdGenerated = [];
  if (includeNumbers) {
    pwdGenerated.add(numbers[Random().nextInt(numbers.length)]);
  }
  if (includeLowercase) {
    pwdGenerated.add(lowercase[Random().nextInt(lowercase.length)]);
  }
  if (includeUppercase) {
    pwdGenerated.add(uppercase[Random().nextInt(uppercase.length)]);
  }
  if (includeSymbols) {
    pwdGenerated.add(symbols[Random().nextInt(symbols.length)]);
  }
  while (pwdGenerated.length < roundedLength) {
    pwdGenerated.add(selectedChar[Random().nextInt(selectedChar.length)]);
  }
  pwdGenerated.shuffle();
  String actualPwd = pwdGenerated.join('');
  // print(actualPwd);
  return actualPwd;
}
