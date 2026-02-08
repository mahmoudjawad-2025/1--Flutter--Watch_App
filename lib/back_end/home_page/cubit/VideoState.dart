part of 'VideoCubit.dart';

class VideoState {
  final Map<String, List<Video>> channelVideos; // Map of channelId to videos
  final Map<String, String> nextPageTokens; // Map of channelId to nextPageToken
  final bool isLoading;

  VideoState({
    this.channelVideos = const {},
    this.nextPageTokens = const {},
    this.isLoading = false,
  });

  VideoState copyWith({
    Map<String, List<Video>>? channelVideos,
    Map<String, String>? nextPageTokens,
    bool? isLoading,
  }) {
    return VideoState(
      channelVideos: channelVideos ?? this.channelVideos,
      nextPageTokens: nextPageTokens ?? this.nextPageTokens,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
