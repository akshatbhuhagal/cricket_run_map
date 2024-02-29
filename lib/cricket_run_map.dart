library cricket_run_map;

import 'dart:math';

import 'package:cricket_run_map/painter/RunMapPainter.dart';
import 'package:flutter/material.dart';





class CricketRunMap extends StatefulWidget {

  final double width;
  final double height;
  final List<String> positionNames;
  final Text leftSide;
  final Text rightSide;

  const CricketRunMap({
    super.key,
    required this.positionNames,
    required this.width,
    required this.height,
    required this.leftSide,
    required this.rightSide,
  });

  @override
  State<CricketRunMap> createState() => _CricketRunMapState();
}

class _CricketRunMapState extends State<CricketRunMap> {


  Offset? tapPoint;
  int? selectedPosition;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          tapPoint = details.localPosition;
          if (tapPoint != null) {
            final dx = tapPoint!.dx - (widget.width / 2);
            final dy = tapPoint!.dy - (widget.height / 2);
            final angle = atan2(dy, dx);
            final sliceAngle = 2 * pi / widget.positionNames.length;
            double normalizedAngle = angle < 0 ? (2 * pi + angle) : angle;
            normalizedAngle = (normalizedAngle + (4 * pi / 2)) % (2 * pi);
            selectedPosition = (normalizedAngle / sliceAngle).floor();
          }
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF669801),
          border: Border.all(
            width: 3,
            color: const Color(0xFFFF9800),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          child: Stack(
            children: [

              CustomPaint(
                size: Size(widget.width, widget.height),
                painter: RunMapPainter(
                    widget.positionNames,
                    tapPoint: tapPoint,
                    selectedPosition: selectedPosition
                ),
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Container(
                          alignment: Alignment.center,
                          child: widget.leftSide,
                        ),
                      ),
                    ),

                    Container(
                      width: 20,
                      height: widget.height * 0.2,
                      color: Colors.amberAccent,
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset(const AssetImage("assets/ic_wagon_striker.png").assetName, package: 'cricket_run_map', color: Colors.black, fit: BoxFit.cover)
                      ),
                    ),

                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Container(
                          alignment: Alignment.center,
                          child: widget.rightSide,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

