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
  bool fingerPrintDisabled = false;

  Future<void> authenticateWithBiometrics() async {
    state = const AsyncValue<void>.loading();
    try {
      _isAuthenticating = true;
      _authorized = 'Authenticating';
      fingerPrintDisabled = await auth.authenticate(
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
      state = AsyncValue<void>.error(e, StackTrace.fromString(''));
      throw Exception(e.message);
    }
    if (!mounted) {
      return;
    }
    final String message =
        fingerPrintDisabled ? 'Authorized' : 'Not Authorized';
    if (message == 'Not Authorized') {
      state = AsyncValue.error('User Canceled Biometrics', StackTrace.current);
      return;
    } else {
      state = const AsyncValue.data(null);
      return;
    }
  }
}

final biometricsScreenControllerProvider =
    StateNotifierProvider<BiometricsController, AsyncValue<void>>((ref) {
  return BiometricsController();
});
