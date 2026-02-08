import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/AppFunctions.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';

class VideoListItem extends StatelessWidget {
  final Video video;

  VideoListItem({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favouritePageCubit = context.read<FavouritePageCubit>();

    return Padding(
      padding: EdgeInsets.only(
          bottom: AppConstants.screenSize(context).height * 0.01,
          left: 10,
          right: 10), // Minimize vertical spacing
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Section
          InkWell(
            onTap: () => watchVideo(context, video, false),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(6), // Optional rounded corners
              child: Container(
                child: video.imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: video.imageUrl!,
                        width: AppConstants.screenSize(context).width * 0.25,
                        height: AppConstants.screenSize(context).width *
                            0.21, // Maintain a 16:9 aspect ratio (e.g., 120:68)
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.video_library,
                        size: 68,
                        color: Colors.grey,
                      ),
              ),
            ),
          ),
          SizedBox(
            width: AppConstants.screenSize(context).width * 0.022,
          ),
          // Content Section (Title and Subtitle)
          Expanded(
            child: InkWell(
              onTap: () => watchVideo(context, video, false),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 8), // Adjust for spacing
                title: Text(
                  video.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppConstants.deviceType == 'mobile'
                          ? AppConstants.screenSize(context).width * 0.045
                          : AppConstants.screenSize(context).width * 0.042),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // Handle long titles
                ),
                subtitle: Text(
                  video.channelTitle,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: AppConstants.screenSize(context).width * 0.033),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),

          // Favourite Icon Section
          BlocBuilder<FavouritePageCubit, FavouritePageState>(
            builder: (context, state) => IconButton(
              onPressed: () {
                favouritePageCubit.toggleFavourite(video);
              },
              icon: video.isFavourite
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: AppConstants.screenSize(context).width * 0.07,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: AppConstants.screenSize(context).width * 0.07,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
