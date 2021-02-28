part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

//! Initialize event
class InitializeEvent extends HomeEvent {}

//! Animation event
class FetchDataEvent extends HomeEvent {}

//! Loading event
class LoadingEvent extends HomeEvent {
  final bool isloading;

  LoadingEvent({
    this.isloading,
  });
}
