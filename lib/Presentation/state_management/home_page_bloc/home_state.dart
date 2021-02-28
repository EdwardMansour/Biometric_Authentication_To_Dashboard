part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

//! fetch data
class FetchDataState extends HomeState {
  final List<dynamic> responce;

  const FetchDataState({
    @required this.responce,
  });

  @override
  List<Object> get props => [
        responce,
      ];
}

//! loading
class LoadingState extends HomeState {
  final bool isLoading;

  const LoadingState({
    @required this.isLoading,
  });

  @override
  List<Object> get props => [
        isLoading,
      ];
}

//! Error when there is no data
class ErrorLoadingState extends HomeState {
  final String message;

  const ErrorLoadingState({
    @required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
