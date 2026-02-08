import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/back_end/home_page/cubit/VideoCubit.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/AppFunctions.dart';

class VideoListWidget extends StatelessWidget {
  final String channelId;
  final bool isChannel;

  VideoListWidget({
    required this.isChannel,
    required this.channelId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants.setDevice(context);
    final deviceType = AppConstants.deviceType;
    final screen = AppConstants.screenSize(context);
    final favouritePageCubit = context.read<FavouritePageCubit>();

    return BlocBuilder<VideoCubit, VideoState>(
      builder: (context, state) {
        final videos = state.channelVideos[channelId] ?? [];
        // loading case
        if (videos.isEmpty && state.isLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        }
        // successful case, check device to return list or grid
        return deviceType == 'mobile'
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: videos.length + 1, // +1 for loading indicator
                itemBuilder: (context, index) {
                  if (index == videos.length) {
                    context.read<VideoCubit>().fetchVideos(channelId);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          color: Colors.transparent,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  final video = videos[index];
                  return _buildVideoTile(
                      video, favouritePageCubit, context, deviceType, screen);
                },
              )
            // if not mobile retutn grid
            : GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: videos.length + 1, // +1 for loading indicator
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of items per row
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 2,
                  childAspectRatio:
                      1 / 1.2, //16 / 9, // Adjust for your desired aspect ratio
                ),
                itemBuilder: (context, index) {
                  if (index == videos.length) {
                    context.read<VideoCubit>().fetchVideos(channelId);
                    return Center(
                      child: Align(
                        alignment: Alignment(1.32, 0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Container(
                            width: 140,
                            height: 140,
                            color: Colors.transparent,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final video = videos[index];
                  return _buildVideoTile(
                      video, favouritePageCubit, context, deviceType, screen);
                },
              );
      },
    );
  }

  // list tile code
  Widget _buildVideoTile(Video video, FavouritePageCubit favouritePageCubit,
      BuildContext context, String deviceType, Size screen) {
    AppConstants.setDevice(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => watchVideo(context, video, false),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    video.imageUrl ?? "",
                    //height: double.infinity,//200, //screen.height / 20,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: deviceType == 'mobile'
                            ? AppConstants.screenSize(context).width * 0.78
                            : AppConstants.screenSize(context).width * 0.38,
                        // height: 500,
                        // video title
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: deviceType == 'mobile'
                                    ? AppConstants.screenSize(context).width *
                                        0.05
                                    : AppConstants.screenSize(context).width *
                                        0.033,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            // channel name
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                video.channelTitle,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: deviceType == 'mobile'
                                      ? AppConstants.screenSize(context).width *
                                          0.04
                                      : AppConstants.screenSize(context).width *
                                          0.03,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      // favourite button
                      BlocBuilder<FavouritePageCubit, FavouritePageState>(
                          builder: (context, state) => PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: AppConstants.deviceType == 'mobile'
                                      ? AppConstants.screenSize(context).width *
                                          0.08
                                      : AppConstants.screenSize(context).width *
                                          0.05,
                                ),
                                offset: AppConstants.deviceType == 'mobile'
                                    ? Offset(-20, 40)
                                    : AppConstants.device == 'medium_tablet'
                                        ? Offset(-250, 50)
                                        : Offset(
                                            -200,
                                            // AppConstants.screenSize(context).width *-0.3,
                                            50),
                                onSelected: (String value) {
                                  if (value == 'add_to_favourite') {
                                    favouritePageCubit.toggleFavourite(video);
                                  }
                                },
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: 'add_to_favourite',
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        video.isFavourite
                                            ? Icon(Icons.favorite_outlined,
                                                size: AppConstants.deviceType ==
                                                        'mobile'
                                                    ? AppConstants.screenSize(
                                                                context)
                                                            .width *
                                                        0.06
                                                    : AppConstants.device ==
                                                            'small_tablet'
                                                        ? AppConstants
                                                                    .screenSize(
                                                                        context)
                                                                .width *
                                                            0.04
                                                        : AppConstants
                                                                    .screenSize(
                                                                        context)
                                                                .width *
                                                            0.035)
                                            : Icon(
                                                Icons.favorite_outline_outlined,
                                                size: AppConstants.deviceType ==
                                                        'mobile'
                                                    ? AppConstants.screenSize(
                                                                context)
                                                            .width *
                                                        0.06
                                                    : AppConstants.screenSize(
                                                                context)
                                                            .width *
                                                        0.035,
                                              ),
                                        video.isFavourite
                                            ? Flexible(
                                                child: Text(
                                                  ' Remove from Favourite',
                                                  style: TextStyle(
                                                      fontSize: AppConstants
                                                                  .deviceType ==
                                                              'mobile'
                                                          ? AppConstants.screenSize(
                                                                      context)
                                                                  .width *
                                                              0.03
                                                          : AppConstants
                                                                      .device ==
                                                                  'small_tablet'
                                                              ? AppConstants.screenSize(
                                                                          context)
                                                                      .width *
                                                                  0.026
                                                              : AppConstants
                                                                          .device ==
                                                                      'medium_tablet'
                                                                  ? AppConstants.screenSize(
                                                                              context)
                                                                          .width *
                                                                      0.022
                                                                  : AppConstants
                                                                              .device ==
                                                                          'large_tablet'
                                                                      ? AppConstants.screenSize(context)
                                                                              .width *
                                                                          0.023
                                                                      : AppConstants.screenSize(context)
                                                                              .width *
                                                                          0.03),
                                                ),
                                              )
                                            : Expanded(
                                                child: Text(
                                                  ' Add to Favourite',
                                                  style: TextStyle(
                                                      fontSize: AppConstants
                                                                  .deviceType ==
                                                              'mobile'
                                                          ? AppConstants.screenSize(
                                                                      context)
                                                                  .width *
                                                              0.03
                                                          : AppConstants
                                                                      .device ==
                                                                  'large_tablet'
                                                              ? AppConstants.screenSize(
                                                                          context)
                                                                      .width *
                                                                  0.021
                                                              : AppConstants.screenSize(
                                                                          context)
                                                                      .width *
                                                                  0.025),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
