part of 'biometric_bloc.dart';

abstract class BiometricEvent extends Equatable {
  const BiometricEvent();

  @override
  List<Object> get props => [];
}

//! Initialize event
class InitializeEvent extends BiometricEvent {}

//! Animation event
class AuthenticationBiometricEvent extends BiometricEvent {}

//! Authentication get values event
class AuthenticationsMethodesFoundEvent extends BiometricEvent {}

class LoadingEvent extends BiometricEvent {
  final bool isloading;

  LoadingEvent({
    this.isloading,
  });
}

class LoginStart extends BiometricEvent {}
