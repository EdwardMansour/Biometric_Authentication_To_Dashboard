import 'dart:async';

import 'package:biometric_dashboard/core/injection/dependancy_injection.dart';
import 'package:biometric_dashboard/core/navigator_service/navigator_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
part 'biometric_event.dart';
part 'biometric_state.dart';

class BiometricBloc extends Bloc<BiometricEvent, BiometricState> {
  BiometricBloc() : super(BiometricInitial());
  //! Initialize auth instance
  final LocalAuthentication auth = LocalAuthentication();
  //! check if there there is
  bool canCheckBiometrics = false;
  //! is Authenticated
  bool _isAuthenticating = false;
  @override
  Stream<BiometricState> mapEventToState(
    BiometricEvent event,
  ) async* {
    if (event is AuthenticationsMethodesFoundEvent) {
      yield* setAuthAvailableTopMap(event);
    } else if (event is AuthenticationBiometricEvent) {
      yield* authenticationBiometric(event);
    } else if (event is InitializeEvent) {
      yield* initializeToMap(event);
    }
  }

  //! Initilize
  Stream<BiometricState> initializeToMap(
    InitializeEvent event,
  ) async* {
    canCheckBiometrics = false;
    _isAuthenticating = false;
    yield BiometricInitial();
  }

  //! Is the biometrical authentication is available????
  Stream<BiometricState> setAuthAvailableTopMap(
    AuthenticationsMethodesFoundEvent event,
  ) async* {
    try {
      //! delay to show that we check if there are a biomtric types
      await Future.delayed(Duration(seconds: 2));
      canCheckBiometrics = await auth.canCheckBiometrics;
      yield CatchIfThereIsAnAuthState(
        authOrNo: canCheckBiometrics,
      );

      print("biometric is available: $canCheckBiometrics");
    } catch (e) {
      //! Error
      yield ErrorLoadingState(
        message: 'Error $e !',
      );
      print("error biome trics $e");
    }
  }

  //! Bio methric with
  Stream<BiometricState> authenticationBiometric(
    AuthenticationBiometricEvent event,
  ) async* {
    try {
      //! Set the loading true
      yield LoadingState(
        isLoading: true,
      );

      //! function that catch if authenticated or no
      _isAuthenticating = await auth.authenticateWithBiometrics(
        localizedReason: 'Touch your finger on the sensor to login',
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: "Login to HomePage",
        ),
        iOSAuthStrings: IOSAuthMessages(
          lockOut: "Login to HomePage",
        ),
      );

      //! Set the loading false
      yield LoadingState(
        isLoading: false,
      );
      //! Navigate to the home page
      if (_isAuthenticating) sl<NavigationService>().navigateTo('/home');
    } catch (e) {
      //! Set the loading false
      yield LoadingState(
        isLoading: false,
      );
      //! here there are an error
      yield ErrorLoadingState(
        message: 'Error $e !',
      );
      print("error using biometric auth: $e");
    }
    print("authenticated: $_isAuthenticating");
  }
}
