import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rainbow Colors Mixer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Rainbow Colors Mixer',
        logo: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const RadialGradient(
              tileMode: TileMode.repeated,
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Color.fromARGB(255, 138, 43, 226),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.logo,
  });

  final String title;
  final Widget logo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, Object>> rainbowColors = [
    {
      "colorValue": Colors.red.value,
      "colorName": "red",
    },
    {
      "colorValue": Colors.orange.value,
      "colorName": "orange",
    },
    {
      "colorValue": Colors.yellow.value,
      "colorName": "yellow",
    },
    {
      "colorValue": Colors.green.value,
      "colorName": "green",
    },
    {
      "colorValue": Colors.blue.value,
      "colorName": "blue",
    },
    {
      "colorValue": Colors.indigo.value,
      "colorName": "indigo",
    },
    {
      "colorValue": const Color.fromARGB(255, 138, 43, 226).value,
      "colorName": "Violet",
    },
  ];
  bool _showColors = false;
  int rainbowColor = 0;
  final myFocusNode = FocusNode();
  int colorIndexLeft = 0;
  int colorIndexRight = 0;
  int mixedColor = 0;
  bool showloadingSpinner = false;
  bool showResults = false;
  int result = 0;
  String newColor = "";
  int rainbowColorRight = 0;
  bool _showColorsRight = false;

  void _pickColor() {
    setState(() {
      _showColorsRight = !_showColorsRight;
    });
  }

  void _pickColorRight() {
    setState(() {
      _showColors = !_showColors;
    });
  }

  void _mixColors() {
    result = (rainbowColors[colorIndexLeft]['colorValue'] as int) +
        (rainbowColors[colorIndexRight]['colorValue'] as int);
    print(rainbowColors[colorIndexLeft]['colorValue'] as int);
    print(rainbowColors[colorIndexRight]['colorValue'] as int);
    print(result);
    setState(() {
      showloadingSpinner = true;
      if (colorIndexLeft == colorIndexRight) {
        mixedColor = rainbowColors[colorIndexLeft]['colorValue'] as int;
      } else {
        mixedColor = result;
      }
      newColor = (Color(mixedColor).toString()).substring(6, 16);
      print(Color(mixedColor));
      print((Color(mixedColor).toString()).substring(6, 16));
      showResults = true;
      Timer(const Duration(seconds: 1), () {
        setState(() {
          showloadingSpinner = false;
        });
      });
    });
  }

  void _restColors() {
    setState(() {
      showloadingSpinner = true;
      showResults = false;
      colorIndexLeft = 0;
      colorIndexRight = 0;
      result = 0;
      mixedColor = 0;
      Timer(const Duration(seconds: 1), () {
        setState(() {
          showloadingSpinner = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: widget.logo,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Center(
            child: showloadingSpinner
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            showResults
                                ? Column(
                                    children: [
                                      Container(
                                        width: 400,
                                        height: 400,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Color(mixedColor),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(1.5, 2.5),
                                              color: Colors.black12,
                                              blurRadius: 2,
                                              spreadRadius: 1,
                                              blurStyle: BlurStyle.normal,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Color code:",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            newColor,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              wordSpacing: 20,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(
                                                rainbowColor,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(1.5, 2.5),
                                                  color: Colors.black12,
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  blurStyle: BlurStyle.normal,
                                                ),
                                              ],
                                            ),
                                            width: 320,
                                            height: 320,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          OutlinedButton(
                                            onPressed: _pickColor,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.list_rounded),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text("pick a color!!!"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _showColorsRight
                                              ? SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ...(rainbowColors).map(
                                                          (color) {
                                                            return InkWell(
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    maxRadius:
                                                                        8,
                                                                    backgroundColor:
                                                                        Color(color['colorValue']
                                                                            as int),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(color[
                                                                          'colorName']
                                                                      as String)
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                myFocusNode
                                                                    .requestFocus();

                                                                setState(() {
                                                                  rainbowColor =
                                                                      color['colorValue']
                                                                          as int;
                                                                  colorIndexLeft =
                                                                      rainbowColors
                                                                          .indexOf(
                                                                              color);
                                                                  print(
                                                                      colorIndexLeft);
                                                                });
                                                              },
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(
                                                rainbowColorRight,
                                              ),
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(1.5, 2.5),
                                                  color: Colors.black12,
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                  blurStyle: BlurStyle.normal,
                                                ),
                                              ],
                                            ),
                                            width: 320,
                                            height: 320,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          OutlinedButton(
                                            onPressed: _pickColorRight,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.list_rounded),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text("pick a color!!!"),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _showColors
                                              ? SizedBox(
                                                  height: 100,
                                                  width: 100,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ...(rainbowColors).map(
                                                          (color) {
                                                            return InkWell(
                                                              child: Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    maxRadius:
                                                                        8,
                                                                    backgroundColor:
                                                                        Color(color['colorValue']
                                                                            as int),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Text(color[
                                                                          'colorName']
                                                                      as String)
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                myFocusNode
                                                                    .requestFocus();

                                                                setState(() {
                                                                  rainbowColorRight =
                                                                      color['colorValue']
                                                                          as int;
                                                                  colorIndexRight =
                                                                      rainbowColors
                                                                          .indexOf(
                                                                              color);
                                                                  print(
                                                                      colorIndexRight);
                                                                });
                                                              },
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        showResults
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  FilledButton(
                                    onPressed: _restColors,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Reset"),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Icon(Icons.reset_tv_rounded),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : FilledButton(
                                onPressed: _mixColors,
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Mix"),
                                    SizedBox(
                                      width: 18,
                                    ),
                                    Icon(Icons.cyclone_rounded),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
