import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/app_global/MostImportantPlaylist/cubit.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';
import 'package:lectures_app/front_end/app_global/CustomNavBar.dart';
import 'package:lectures_app/core/widgets/YoutubePlayerScreen.dart';
import 'package:lectures_app/front_end/app_global/MostImportantPlaylist.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // youtube player
      case AppRoutes.youtubePlayer:
        final args = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (_) => YoutubePlayerScreen(
            videoId: args["videoId"],
            channelTitle: args["channelTitle"],
            channelDescription: args["channelDescription"],
            channelSubscribers: args["channelSubscribersCount"],
            publishedDate: args["publishedDate"], // Include this
            videoTitle: args["videoTitle"], // Include this
          ),
          settings: settings,
        );
      case AppRoutes.customNavbar: // New route for CustomNavBar
        return CupertinoPageRoute(
          builder: (_) => CustomNavBar(),
          settings: settings,
        );
      case AppRoutes.mostImportantPlaylist: // New route for CustomNavBar
        return CupertinoPageRoute(
          builder: (_) => MostImportantPlaylist(),
          settings: settings,
        );

      default:
        return CupertinoPageRoute(
          builder: (_) => CustomNavBar(),
          settings: settings,
        );
    }
  }
}
