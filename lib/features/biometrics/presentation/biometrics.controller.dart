import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

import 'package:flutter/material.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class BiometricsController extends StateNotifier<AsyncValue<void>> {
  BiometricsController() : super(const AsyncValue<void>.data(null));

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      _isAuthenticating = false;
      _authorized = 'Authenticating';
    } on PlatformException catch (e) {
      _isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      throw Exception(e.message);
    }
    if (!mounted) {
      return;
    }
    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    _authorized = message;
    return;
  }

}

final biometricsScreenControllerProvider =
    StateNotifierProvider<BiometricsController, AsyncValue<void>>((ref) {
  return BiometricsController();
});
