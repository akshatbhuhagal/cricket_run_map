import 'package:cricket_run_map/cricket_run_map.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket Run Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: CricketRunMap(
            width: 350,
            height: 350,
            isRightHand:
                false, // True = Right Hand Batsman  |  False = Left Hand Batsman
            onPositionSelected: (String selectedPosition) {
              // Handle the selected position name here
              print('Selected position index: $selectedPosition');
            },
          ),
        ),
      ),
    );
  }
}
