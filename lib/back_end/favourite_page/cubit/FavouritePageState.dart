part of 'FavouritePageCubit.dart';

class FavouritePageState {}

class FavouritePageInitial extends FavouritePageState {}

class FavouritePageLoading extends FavouritePageState {}

class FavouritePageLoaded extends FavouritePageState {}

class FavouritePageError extends FavouritePageState {
  final String message;
  FavouritePageError({required this.message});
}
