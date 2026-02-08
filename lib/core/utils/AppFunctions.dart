import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/home_page/cubit/VideoCubit.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';

Future<void> watchVideo(
    BuildContext context, Video video, bool isPlaylist) async {
  if (!isPlaylist) {
    Map<String, dynamic> channelDetails =
        await context.read<VideoCubit>().fetchChannelDetails(video.channelId);
    Navigator.pushNamed(
      context,
      AppRoutes.youtubePlayer,
      arguments: {
        'videoId': video.videoId, // Pass the videoId
        'channelTitle': video.channelTitle ?? "Unknown channelTitle",
        'publishedDate': video.publishedDate ?? "Unknown date",
        'videoTitle': video.title ?? "Unknown videoTitle",
        'channelDescription':
            channelDetails['description'] ?? "Unknown channelDescription",
        'channelSubscribersCount': channelDetails['subscriberCount'] ??
            "unknown channelSubscripersCount",
      },
    );
    // if video of playlist
  } else {
    {
      Navigator.pushNamed(
        context,
        AppRoutes.youtubePlayer,
        arguments: {
          'videoId': video.videoId, // Pass the videoId
          'channelTitle': video.channelTitle ?? "Unknown channelTitle",
          'publishedDate': video.publishedDate ?? "Unknown date",
          'videoTitle': video.title ?? "Unknown videoTitle",
          'channelDescription': "لمحة عن القناة\n"
              "1. حب الله ورسوله\n"
              "2. تعظيم الله تعالى\n"
              "3. الاعتزاز بالهوية الإسلامية\n"
              "4. طمأنينة النفس\n"
              "وهذا كله عن علم عميق ويقين راسخ\n"
              "لنلقى الله وهو عن راضٍ\n"
              "ونخلد في النعيم بجوار رب رحيم.\n",
          'channelSubscribersCount': "10000",
        },
      );
    }
  }
}
