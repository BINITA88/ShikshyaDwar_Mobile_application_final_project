import 'package:local_auth/local_auth.dart';

class FingerprintAuth {
  final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if the device supports fingerprint authentication
  Future<bool> isBiometricAvailable() async {
    bool canAuthenticate = await _localAuth.canCheckBiometrics ||
        await _localAuth.isDeviceSupported();
    return canAuthenticate;
  }

  /// Perform fingerprint authentication
  Future<bool> authenticate() async {
    try {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      return isAuthenticated;
    } catch (e) {
      print("Fingerprint authentication error: $e");
      return false;
    }
  }
}
