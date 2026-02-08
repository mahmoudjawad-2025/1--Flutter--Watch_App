import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:lectures_app/core/models/VideoModel.dart';
import 'dart:convert';

import 'package:lectures_app/core/utils/AppConstants.dart';
part 'VideoState.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoState());

  // fetch videos
  Future<void> fetchVideos(String channelId) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final nextPageToken = state.nextPageTokens[channelId] ?? "";
    final url =
        "https://www.googleapis.com/youtube/v3/search?key=${AppConstants.apiKey2}&channelId=$channelId&part=snippet&type=video&maxResults=10&pageToken=$nextPageToken";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Video> newVideos = (data['items'] as List)
            .map((item) => Video.convertJson(item, channelId))
            .toList();

        final updatedChannelVideos =
            Map<String, List<Video>>.from(state.channelVideos);
        updatedChannelVideos[channelId] = [
          ...(state.channelVideos[channelId] ?? []),
          ...newVideos,
        ];

        final updatedNextPageTokens =
            Map<String, String>.from(state.nextPageTokens);
        updatedNextPageTokens[channelId] = data['nextPageToken'] ?? "";

        emit(state.copyWith(
          channelVideos: updatedChannelVideos,
          nextPageTokens: updatedNextPageTokens,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (error) {
      emit(state.copyWith(isLoading: false));
    }
  }

  // fetch channel details

  Future<Map<String, String>> fetchChannelDetails(String? channelId) async {
    final url =
        'https://www.googleapis.com/youtube/v3/channels?part=snippet,statistics&id=$channelId&key=${AppConstants.apiKey3}';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final channel = data['items'][0];
      return {
        'description': channel['snippet']['description'],
        'subscriberCount': channel['statistics']['subscriberCount'],
      };
    } else {
      throw Exception('Failed to fetch channel details');
    }
  }
}
