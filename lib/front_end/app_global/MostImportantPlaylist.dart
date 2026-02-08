import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/app_global/MostImportantPlaylist/cubit.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/AppFunctions.dart';

class MostImportantPlaylist extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  _MostImportantPlaylistState createState() => _MostImportantPlaylistState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight); //(kToolbarHeight);
}

class _MostImportantPlaylistState extends State<MostImportantPlaylist> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !context.read<PlaylistCubit>().state.isLoading) {
      context.read<PlaylistCubit>().fetchPlaylistVideos(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.setDevice(context);
    final favouritePageCubit = context.read<FavouritePageCubit>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: AppConstants.deviceType == 'mobile'
                ? AppConstants.screenSize(context).height * 0.1
                : AppConstants.screenSize(context).height * 0.1,
            color: Color.fromARGB(255, 1, 15, 28),
            // manual appbar
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Padding(
                    padding: EdgeInsets.only(
                        left: AppConstants.screenSize(context).width * 0.008,
                        right: AppConstants.screenSize(context).width * 0.03),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: AppConstants.deviceType == 'mobile'
                          ? AppConstants.screenSize(context).width * 0.07
                          : AppConstants.screenSize(context).width * 0.056,
                    ),
                  ),
                ),
                Text(
                  'Rehlat Al-Yaqeen',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.deviceType == 'mobile'
                        ? AppConstants.screenSize(context).width * 0.05
                        : AppConstants.screenSize(context).width * 0.05,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<PlaylistCubit, PlaylistState>(
            builder: (context, state) {
              // return loading indicator
              if (state.isLoading && state.videos.isEmpty) {
                return Center(
                    child: Container(
                  width: AppConstants.screenSize(context).width * 0.095,
                  height: AppConstants.screenSize(context).width * 0.095,
                  color: Colors.transparent,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ));
                // return error message
              } else if (state.error != null && state.videos.isEmpty) {
                return Center(
                    child: Text(
                  "There was a problem, please try again later!",
                  style: TextStyle(
                      fontSize: AppConstants.screenSize(context).width * 0.035,
                      fontWeight: FontWeight.bold),
                ));
              }
              // success case, return listview
              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.videos.length + (state.hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= state.videos.length) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Container(
                          width: AppConstants.screenSize(context).width * 0.095,
                          height:
                              AppConstants.screenSize(context).width * 0.095,
                          color: Colors.transparent,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )),
                      );
                    }
                    Video video = state.videos[index];
                    return InkWell(
                      onTap: () => watchVideo(context, video, true),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: AppConstants.deviceType == 'mobile'
                                  ? AppConstants.screenSize(context).width * 0.2
                                  : AppConstants.screenSize(context).width *
                                      0.199,
                              height: AppConstants.deviceType == 'mobile'
                                  ? AppConstants.screenSize(context).width * 0.2
                                  : AppConstants.screenSize(context).width *
                                      0.199,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage("${video.imageUrl}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.title,
                                    style: TextStyle(
                                      fontSize:
                                          AppConstants.deviceType == 'mobile'
                                              ? AppConstants.screenSize(context)
                                                      .width *
                                                  0.051
                                              : AppConstants.screenSize(context)
                                                      .width *
                                                  0.044,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    video.channelTitle,
                                    style: TextStyle(
                                      fontSize:
                                          AppConstants.deviceType == 'mobile'
                                              ? AppConstants.screenSize(context)
                                                      .width *
                                                  0.041
                                              : AppConstants.screenSize(context)
                                                      .width *
                                                  0.035,
                                      color:
                                          const Color.fromARGB(255, 53, 51, 51),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // add to favourite code
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
                                size: AppConstants.deviceType == 'mobile'
                                    ? AppConstants.screenSize(context).width *
                                        0.06
                                    : AppConstants.screenSize(context).width *
                                        0.05,
                              ),
                              offset: Offset(
                                AppConstants.deviceType == 'mobile'
                                    ? AppConstants.screenSize(context).width *
                                        -0.05
                                    : AppConstants.screenSize(context).width *
                                        -0.04,
                                AppConstants.deviceType == 'mobile'
                                    ? AppConstants.screenSize(context).width *
                                        0.1
                                    : AppConstants.screenSize(context).width *
                                        0.04,
                              ),
                              onSelected: (String value) {
                                if (value == 'add_to_favourite') {
                                  context
                                      .read<FavouritePageCubit>()
                                      .toggleFavourite(video);
                                }
                              },
                              itemBuilder: (BuildContext context) => [
                                PopupMenuItem(
                                  value: 'add_to_favourite',
                                  child: ListTile(
                                    leading: Icon(
                                      video.isFavourite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: AppConstants.deviceType == 'mobile'
                                          ? AppConstants.screenSize(context)
                                                  .width *
                                              0.06
                                          : AppConstants.screenSize(context)
                                                  .width *
                                              0.05,
                                    ),
                                    title: Text(
                                      video.isFavourite
                                          ? 'Remove from Favourite'
                                          : 'Add to Favourite',
                                      style: TextStyle(
                                        fontSize: AppConstants.deviceType ==
                                                'mobile'
                                            ? AppConstants.screenSize(context)
                                                    .width *
                                                0.035
                                            : AppConstants.screenSize(context)
                                                    .width *
                                                0.03,
                                      ),

                                      // overflow: TextOverflow.ellipsis,
                                      // maxLines: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
