import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthenticationApi {
  static final LocalAuthentication _authentication = LocalAuthentication();

  Future<bool> canBiometric() async {
    try {
      return await _authentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    final hasBiometric = await canBiometric();
    if (!hasBiometric) {
      return false;
    }
    try {
      return await _authentication.authenticate(
          options: const AuthenticationOptions(
            stickyAuth: true,
            useErrorDialogs: true,
            biometricOnly: true,
          ),
          localizedReason: 'Face ID is required to proceed');
    } on PlatformException catch (e) {
      return false;
    }
  }
}
