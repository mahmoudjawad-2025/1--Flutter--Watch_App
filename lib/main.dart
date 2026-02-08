import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/app_global/MostImportantPlaylist/cubit.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/back_end/home_page/cubit/VideoCubit.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/AppTheme.dart';
import 'package:lectures_app/core/utils/route/AppRouter.dart';
import 'package:lectures_app/back_end/search_page/cubit/SearchPageCubit.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';

void main() {
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set device info
    AppConstants.setDevice(context);
    // Bloc-Providers
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoCubit>(
          create: (_) => VideoCubit()..fetchVideos(AppConstants.channelIds[0]),
        ),
        BlocProvider<HomePageCubit>(
          create: (_) => HomePageCubit(),
        ),
        BlocProvider<FavouritePageCubit>(
          create: (_) => FavouritePageCubit(),
        ),
        BlocProvider(
          create: (_) => PlaylistCubit(
            apiKey: AppConstants.apiKey2, // Replace with your API key
            playlistId:
                AppConstants.playListIds[0], // Replace with your playlist ID
          )..fetchPlaylistVideos(),
        ),
      ],
      // App route
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.mainTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes
            .customNavbar, // Set the navigation bar as the initial route
      ),
    );
  }
}
