part of 'track_cart_bloc.dart';

abstract class TrackCartState {}

class TrackCartInitial extends TrackCartState {}

class TrackLoading extends TrackCartState {}

class TracksShowSuccess extends TrackCartState {
  final bool show;

  TracksShowSuccess({required this.show});
}
