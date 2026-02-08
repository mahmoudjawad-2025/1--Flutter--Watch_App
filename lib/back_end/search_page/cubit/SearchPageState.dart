part of 'SearchPageCubit.dart';

abstract class HomePageState {}

class homePageInitial extends HomePageState {}

class homePageLoading extends HomePageState {
  final List<Video> videos; // Allow loading state to hold existing videos
  homePageLoading({this.videos = const []});
}

class homePageLoaded extends HomePageState {
  final List<Video> videos;
  homePageLoaded({required this.videos});
}

class homePageError extends HomePageState {
  final String message;
  final List<Video> videos; // Allow error state to hold existing videos
  homePageError({required this.message, this.videos = const []});
}
