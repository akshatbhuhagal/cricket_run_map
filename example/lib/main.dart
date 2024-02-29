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
          child: const CricketRunMap(
            width: 350,
            height: 350,
            leftSide: Text("OFF", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
            rightSide: Text("LEG", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
            positionNames: [
              'Deep Mid\nWicket',
              'Long On',
              'Long Off',
              'Deep Cover',
              'Deep Point',
              'Third Man',
              'Deep\nFine Leg',
              'Deep\nSquare Leg',
            ],
          ),
        ),
      ),
    );
  }
}

