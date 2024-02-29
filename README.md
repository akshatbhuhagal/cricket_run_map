
An Awesome Flutter package to create a Wagon Wheel / Run Map widget for Cricket applications.

## Getting started

To use this package, first download it using the following command:

```
flutter pub add cricket_run_map
```

And run:

```
flutter pub get
```

Finally,

```dart
import 'package:cricket_run_map/cricket_run_map.dart';
```

## Usage

Now you will be able to use the CricketRunMap widget in your build method:

```dart
CricketRunMap(
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
```

This will give you the following UI:


<p align="center"> <img src="https://github.com/akshatbhuhagal/cricket_run_map/blob/master/assets/screenshot/img.png" width="200"> </p>

## Additional information

As of now this is Alpha Release,
This package only contains minimum Features, More Features will be added with Final Release.
