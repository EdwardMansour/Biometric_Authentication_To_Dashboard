part of 'biometric_bloc.dart';

abstract class BiometricState extends Equatable {
  const BiometricState();

  @override
  List<Object> get props => [];
}

class BiometricInitial extends BiometricState {}

//! Catch the authentication types
class CatchIfThereIsAnAuthState extends BiometricState {
  final bool authOrNo;

  const CatchIfThereIsAnAuthState({
    @required this.authOrNo,
  });

  @override
  List<Object> get props => [
        authOrNo,
      ];

  @override
  String toString() => 'Biometric available? $authOrNo';
}

//! Error when there is no biometric
class LoadingState extends BiometricState {
  final bool isLoading;

  const LoadingState({
    @required this.isLoading,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];
}

//! Navigate to another page
class NavigateState extends BiometricState {
  final bool navigate;

  const NavigateState({
    @required this.navigate,
  });

  @override
  List<Object> get props => [
        navigate,
      ];
}

//! Error when there is no biometric
class ErrorLoadingState extends BiometricState {
  final String message;

  const ErrorLoadingState({
    @required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
