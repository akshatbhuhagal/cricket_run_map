library cricket_run_map;

import 'dart:math';

import 'package:cricket_run_map/painter/run_map_painter.dart';
import 'package:flutter/material.dart';

import 'model/position_data_model.dart';

class CricketRunMap extends StatefulWidget {
  final double width;
  final double height;
  final bool isRightHand;
  final void Function(PositionDataModel) onPositionSelected;
  final List<PositionDataModel>? positions;

  const CricketRunMap({
    super.key,
    required this.width,
    required this.height,
    this.isRightHand = true,
    required this.onPositionSelected,
    this.positions,
  });

  @override
  State<CricketRunMap> createState() => _CricketRunMapState();
}

class _CricketRunMapState extends State<CricketRunMap> {

  final List<PositionDataModel> _defaultRightHandPositions = [
    PositionDataModel(1, 'Deep Mid\nWicket'),
    PositionDataModel(2, 'Long On'),
    PositionDataModel(3, 'Long Off'),
    PositionDataModel(4, 'Deep Cover'),
    PositionDataModel(5, 'Deep Point'),
    PositionDataModel(6, 'Third Man'),
    PositionDataModel(7, 'Deep\nFine Leg'),
    PositionDataModel(8, 'Deep\nSquare Leg'),
  ];

  final List<PositionDataModel> _defaultLeftHandPositions = [
    PositionDataModel(1, 'Deep Cover'),
    PositionDataModel(2, 'Long Off'),
    PositionDataModel(3, 'Long On'),
    PositionDataModel(4, 'Deep Mid\nWicket'),
    PositionDataModel(5, 'Deep\nSquare Leg'),
    PositionDataModel(6, 'Deep\nFine Leg'),
    PositionDataModel(7, 'Third Man'),
    PositionDataModel(8, 'Deep Point'),
  ];

  List<PositionDataModel> get activePositions {
    if (widget.positions != null && widget.positions!.isNotEmpty) {
      return widget.positions!;
    } else {
      // fallback to default list based on hand
      return widget.isRightHand ? _defaultRightHandPositions : _defaultLeftHandPositions;
    }
  }

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
            final sliceAngle = 2 * pi / activePositions.length;
            double normalizedAngle = angle < 0 ? (2 * pi + angle) : angle;
            normalizedAngle = (normalizedAngle + (4 * pi / 2)) % (2 * pi);
            selectedPosition = (normalizedAngle / sliceAngle).floor() % activePositions.length;

            // Return whole selected position with ID
            widget.onPositionSelected.call(activePositions[selectedPosition!]);
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
                painter: RunMapPainter(activePositions,
                  tapPoint: tapPoint, selectedPosition: selectedPosition,
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
                          child: widget.isRightHand
                              ? const Text("OFF", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))
                              : const Text("LEG", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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
                        child: widget.isRightHand
                            ? Image.asset(
                          const AssetImage("assets/ic_wagon_striker.png").assetName,
                          package: 'cricket_run_map', color: Colors.black, fit: BoxFit.cover,
                        )
                            : Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: Image.asset(
                            const AssetImage("assets/ic_wagon_striker.png").assetName,
                            package: 'cricket_run_map', color: Colors.black, fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: Container(
                          alignment: Alignment.center,
                          child: widget.isRightHand
                              ? const Text("LEG", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white))
                              : const Text("OFF", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
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
