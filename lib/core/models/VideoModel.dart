import 'package:intl/intl.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';

class Video {
  final String title;
  final String channelTitle;
  final String? imageUrl;
  final String videoId;
  final String? publishedDate;
  final String? channelDescription;
  final String? channelId;
  bool isFavourite = false;
  static List searchedVideos = [];
  static List favouriteVideos = [];

  Video(
      {required this.title,
      required this.channelTitle,
      this.imageUrl,
      required this.videoId,
      required this.publishedDate,
      required this.channelDescription,
      required this.channelId});

  // convert json code to dart code
  factory Video.convertJson(Map<String, dynamic> json, final channelId2) {
    return Video(
      title: json['snippet']['title'], // Video title
      channelTitle: json['snippet']['channelTitle'], // Channel name
      videoId: json['id']['videoId'],
      publishedDate: json['snippet']['publishedAt'] != null
          ? DateFormat('dd/MM/yyyy')
              .format(DateTime.parse(json['snippet']['publishedAt']))
          : "Unknown date",
      channelDescription: json['snippet']['description'],
      channelId: channelId2,
      imageUrl: json['snippet']['thumbnails'] != null
          ? json['snippet']['thumbnails']['high'] != null
              ? json['snippet']['thumbnails']['high']
                  ['url'] // High resolution thumbnail URL
              : null
          : null,
    );
  }
  // convert json code of a playlist response to dart code
  factory Video.convertJsonPlaylist(Map<String, dynamic> json) {
    return Video(
        title: json['snippet']['title'], // Video title
        channelTitle: json['snippet']['channelTitle'], // Channel name
        videoId: json['snippet']['resourceId']?['videoId'],
        publishedDate: json['snippet']['publishedAt'],
        // json['snippet']['publishedAt'] != null
        //     ? DateFormat('dd/MM/yyyy')
        //         .format(DateTime.parse(json['snippet']['publishedAt']))
        //     : "Unknown date",
        channelDescription: "1----json['snippet']['description']",
        channelId: AppConstants.channelIds[0],
        imageUrl: json['snippet']['thumbnails']['default']['url']);
    // (json['snippet']['thumbnails'] != null)
    //     ? (json['snippet']['thumbnails']['high']?['url'])
    //     : null);
  }
}
