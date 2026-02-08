import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
part 'SearchPageState.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(homePageInitial());

  String? _nextPageToken;
  bool _isFetching = false;

  // fetch searched videos
  Future<void> fetchVideos(String query, {bool isLoadMore = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (!isLoadMore) {
      emit(homePageLoading(
          videos:
              state is homePageLoaded ? (state as homePageLoaded).videos : []));
    }

    try {
      final List<Video> allVideos = isLoadMore && state is homePageLoaded
          ? List.from((state as homePageLoaded).videos)
          : [];

      final channelIds = AppConstants.channelIds;

      for (String channelId in channelIds) {
        final url = Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&channelId=$channelId&pageToken=${_nextPageToken ?? ""}&key=${AppConstants.apiKey3}',
        );

        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['items'] != null && data['items'].isNotEmpty) {
            allVideos.addAll(data['items']
                .map<Video>((item) => Video.convertJson(item, channelId))
                .toList());
          }

          _nextPageToken = data['nextPageToken'];
        } else {
          emit(homePageError(
              message: 'Failed to load videos for channel: $channelId',
              videos: allVideos));
          _isFetching = false;
          return;
        }
      }

      if (allVideos.isEmpty) {
        emit(homePageError(
            message: "No videos found for the given query.",
            videos: allVideos));
      } else {
        emit(homePageLoaded(videos: allVideos));
      }
    } catch (e) {
      emit(homePageError(message: "Error: ${e.toString()}", videos: []));
    }

    _isFetching = false;
  }
}
