
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
  isRightHand: true, // True = Right Hand Batsman  |  False = Left Hand Batsman
  onPositionSelected: (String selectedPosition) {
    // Handle the selected position name here
    print('Selected position index: $selectedPosition');
  },
)
```

This will give you the following UI:


<p align="center"> <img src="https://github.com/akshatbhuhagal/cricket_run_map/blob/master/assets/screenshot/img2.png" width="200"> <img src="https://github.com/akshatbhuhagal/cricket_run_map/blob/master/assets/screenshot/img.png" width="200"> </p>

## Additional information

Additional features are slated for integration in forthcoming updates, enhancing the functionality and usability of the platform. 
For customization or further refinement to align with specific preferences, please refer to the GitHub repository provided: https://github.com/akshatbhuhagal/cricket_run_map
