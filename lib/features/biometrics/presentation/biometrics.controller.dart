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
    print("pasok");
    bool authenticated = false;
    try {
      print("try");
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
      print("finish");
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
    print('${message} >>>>>>>>>>>>>');
    return;
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    () => _isAuthenticating = false;
  }
}

final biometricsScreenControllerProvider =
    StateNotifierProvider<BiometricsController, AsyncValue<void>>((ref) {
  return BiometricsController();
});
