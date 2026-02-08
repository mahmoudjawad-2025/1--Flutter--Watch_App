import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
part 'state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  final String apiKey;
  final String playlistId;
  String? nextPageToken;

  PlaylistCubit({required this.apiKey, required this.playlistId})
      : super(PlaylistState(videos: []));

  // fetch videos of a playlist
  Future<void> fetchPlaylistVideos({bool loadMore = false}) async {
    if (loadMore && !state.hasMore) return; // No more videos to load

    emit(PlaylistState(
      videos: state.videos,
      isLoading: true,
      error: null,
      hasMore: state.hasMore,
    ));

    final url =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=$apiKey${nextPageToken != null ? "&pageToken=$nextPageToken" : ""}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // final newVideos = data['items'];
        nextPageToken = data['nextPageToken'];
        final List<Video> newVideos = (data['items'] as List)
            .map((item) => Video.convertJsonPlaylist(item))
            .toList();

        emit(PlaylistState(
          videos: [...state.videos, ...newVideos],
          isLoading: false,
          hasMore: nextPageToken != null,
        ));
      } else {
        emit(PlaylistState(
          videos: state.videos,
          isLoading: false,
          error: 'Failed to load videos',
          hasMore: state.hasMore,
        ));
      }
    } catch (e) {
      emit(PlaylistState(
        videos: state.videos,
        isLoading: false,
        error: 'Error: $e',
        hasMore: state.hasMore,
      ));
    }
  }
}
