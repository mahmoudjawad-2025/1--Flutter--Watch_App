part of 'cubit.dart';

class PlaylistState {
  final List videos;
  final bool isLoading;
  final String? error;
  final bool hasMore;

  PlaylistState({
    required this.videos,
    this.isLoading = false,
    this.error,
    this.hasMore = true,
  });
}
