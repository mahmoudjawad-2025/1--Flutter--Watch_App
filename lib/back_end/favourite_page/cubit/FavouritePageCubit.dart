import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
part 'FavouritePageState.dart';

class FavouritePageCubit extends Cubit<FavouritePageState> {
  FavouritePageCubit() : super(FavouritePageInitial());

  // set/remove favourite video
  Future<void> toggleFavourite(Video video) async {
    emit(FavouritePageLoading());
    try {
      if (video.isFavourite) {
        video.isFavourite = !video.isFavourite;
        Video.favouriteVideos.remove(video);
      } else {
        video.isFavourite = !video.isFavourite;
        Video.favouriteVideos.add(video);
      }

      emit(FavouritePageLoaded());
    } catch (e) {
      emit(FavouritePageError(message: "Error: ${e.toString()}"));
    }
  }
}
