// import 'dart:async';
// import 'package:flutter_sensors/flutter_sensors.dart';

// class ShakeDetector {
//   final Function onShake;
//   StreamSubscription? _subscription;
//   List<double> _lastValues = [0, 0, 0];

//   ShakeDetector({required this.onShake});

//   void startListening() async {
//     bool isAvailable =
//         await SensorManager().isSensorAvailable(Sensors.ACCELEROMETER);
//     if (!isAvailable) {
//       print("Accelerometer sensor not available.");
//       return;
//     }

//     SensorManager()
//         .sensorUpdates(
//       sensorId: Sensors.ACCELEROMETER,
//       interval: Sensors.SENSOR_DELAY_UI,
//     )
//         .then((stream) {
//       _subscription = stream.listen((event) {
//         double x = event.data[0];
//         double y = event.data[1];
//         double z = event.data[2];

//         double deltaX = (x - _lastValues[0]).abs();
//         double deltaY = (y - _lastValues[1]).abs();
//         double deltaZ = (z - _lastValues[2]).abs();

//         _lastValues = [x, y, z];

//         double shakeThreshold = 15.0;
//         if (deltaX > shakeThreshold ||
//             deltaY > shakeThreshold ||
//             deltaZ > shakeThreshold) {
//           onShake();
//         }
//       });
//     });
//   }

//   void stopListening() {
//     _subscription?.cancel();
//   }
// }
