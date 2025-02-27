import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:sensors_plus/sensors_plus.dart';

class ShakeDetector {
  final VoidCallback onShake;
  final double shakeThreshold; // ✅ Fix: Renamed from shakeThresholdGravity
  final int shakeSlopTimeMS;
  final int shakeCountResetTime;
  final int requiredShakes;

  DateTime? _lastShakeTime;
  int _shakeCount = 0;
  StreamSubscription<UserAccelerometerEvent>? _subscription;

  ShakeDetector({
    required this.onShake,
    this.shakeThreshold = 2.0, // ✅ Fix: Changed to correct name
    this.shakeSlopTimeMS = 500,
    this.shakeCountResetTime = 3000,
    this.requiredShakes = 3,
  });

  void startListening() {
    _subscription = userAccelerometerEvents.listen(
      (UserAccelerometerEvent event) {
        double gX = event.x / 9.81;
        double gY = event.y / 9.81;
        double gZ = event.z / 9.81;

        double gForce = sqrt(gX * gX + gY * gY + gZ * gZ);

        if (gForce > shakeThreshold) {
          // ✅ Fix: Using correct name
          final DateTime now = DateTime.now();

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds <
                  shakeSlopTimeMS) {
            return;
          }

          if (_lastShakeTime != null &&
              now.difference(_lastShakeTime!).inMilliseconds >
                  shakeCountResetTime) {
            _shakeCount = 0;
          }

          _lastShakeTime = now;
          _shakeCount++;

          if (_shakeCount >= requiredShakes) {
            _shakeCount = 0;
            onShake();
          }
        }
      },
      onError: (error) {
        print('Error in shake detection: $error');
      },
      cancelOnError: true,
    );
  }

  void stopListening() {
    _subscription?.cancel();
  }
}
