import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/back_end/search_page/cubit/SearchPageCubit.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/front_end/search_page/models/VideoListItem.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/widgets/Background.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';
import 'package:lectures_app/front_end/home_page/widgets/CarouselSlider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';

// class SearchPage extends StatelessWidget {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final searchPageCubit = context.read<HomePageCubit>();
//     final favouritePageCubit = context.read<FavouritePageCubit>();
//     final AppConstants.screenSize(context) = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Background(),
//         SizedBox(
//           width: AppConstants.screenSize(context).width,
//           height: AppConstants.screenSize(context).height,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 70),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: AppConstants.screenSize(context).width * 0.7,
//                         child: TextField(
//                           controller: _controller,
//                           style: TextStyle(color: Colors.white),
//                           decoration: InputDecoration(
//                             labelText: 'Search for Islamic Lectures',
//                             labelStyle: TextStyle(color: Colors.white),
//                             border: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         width: 55,
//                         height: 55,
//                         //color: Colors.white,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(55))),
//                         child: IconButton(
//                           icon: Icon(Icons.search), // Search icon
//                           color: Colors.black,
//                           onPressed: () {
//                             searchPageCubit.fetchVideos(_controller.text);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: BlocBuilder<HomePageCubit, HomePageState>(
//                     bloc: searchPageCubit,
//                     builder: (context, state) {
//                       if (state is homePageLoading) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (state is homePageError) {
//                         return Center(
//                           child: Text(
//                             state.message,
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         );
//                       } else if (state is homePageLoaded) {
//                         if (state.videos.isEmpty) {
//                           return Center(
//                             child: Text(
//                               'No lectures found',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           );
//                         }

//                         return ListView.builder(
//                           itemCount: state.videos.length,
//                           itemBuilder: (context, index) {
//                             final video = state.videos[index];
//                             return VideoListItem(video: video);
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text(
//                             'Press the search button to fetch videos.',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants.screenSize(context);
    final searchPageCubit = context.read<HomePageCubit>();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 2000 &&
          searchPageCubit.state is homePageLoaded) {
        // Trigger loading more videos when nearing the bottom
        searchPageCubit.fetchVideos(_controller.text, isLoadMore: true);
      }
    });

    return Stack(
      children: [
        Background(),
        SizedBox(
          width: AppConstants.screenSize(context).width,
          height: AppConstants.screenSize(context).height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                10, AppConstants.screenSize(context).height * 0.1, 10, 0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConstants.deviceType == 'mobile'
                          ? AppConstants.screenSize(context).width * 0.009
                          : AppConstants.screenSize(context).width * 0.025,
                      vertical: AppConstants.screenSize(context).width * 0.04),
                  child: Stack(children: [
                    Row(children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                                0.2), // Add slight background color for clarity
                            borderRadius: BorderRadius.circular(
                              AppConstants.screenSize(context).width * 0.02,
                            ),
                          ),
                          child: TextField(
                            maxLines: 1,
                            controller: _controller,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  AppConstants.screenSize(context).width * 0.05,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Search for Islamic Lectures',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    AppConstants.screenSize(context).width *
                                        0.038,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.screenSize(context).width * 0.02,
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical:
                                    AppConstants.screenSize(context).width *
                                        0.03,
                                horizontal: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () =>
                            searchPageCubit.fetchVideos(_controller.text),
                        child: Container(
                          width: AppConstants.deviceType == 'mobile'
                              ? AppConstants.screenSize(context).width * 0.122
                              : AppConstants.screenSize(context).width * 0.125,
                          height: AppConstants.deviceType == 'mobile'
                              ? AppConstants.screenSize(context).width * 0.122
                              : AppConstants.screenSize(context).width * 0.125,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  AppConstants.screenSize(context).width *
                                      0.02),
                            ),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size:
                                AppConstants.screenSize(context).width * 0.055,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: AppConstants.deviceType == 'mobile'
                //           ? AppConstants.screenSize(context).width * 0.009
                //           : AppConstants.screenSize(context).width * 0.025,
                //       vertical: AppConstants.screenSize(context).width * 0.04),
                //   child: Row(children: [
                //     Container(
                //         color: Colors.transparent,
                //         width: AppConstants.screenSize(context).width * 0.77,
                //         height: AppConstants.screenSize(context).width * 0.11,
                //         child: TextField(
                //           maxLines: 1,
                //           controller: _controller,
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize:
                //                 AppConstants.screenSize(context).width * 0.05,
                //             // Removed overflow: TextOverflow.ellipsis
                //           ),
                //           decoration: InputDecoration(
                //             labelText: 'Search for Islamic Lectures',
                //             labelStyle: TextStyle(
                //               color: Colors.white,
                //               fontSize: AppConstants.screenSize(context).width *
                //                   0.038,
                //             ),
                //             border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(
                //                 AppConstants.screenSize(context).width * 0.02,
                //               ),
                //               borderSide: BorderSide(
                //                 color: Colors.white,
                //               ),
                //             ),
                //             // contentPadding: EdgeInsets.symmetric(
                //             //   vertical:
                //             //       AppConstants.screenSize(context).width *
                //             //           0.03, // Adjusted
                //             //   horizontal: 30.0,
                //             // ),
                //           ),
                //         )),
                //     InkWell(
                //       onTap: () =>
                //           searchPageCubit.fetchVideos(_controller.text),
                //       child: Container(
                //         width: AppConstants.screenSize(context).width * 0.105,
                //         height: AppConstants.screenSize(context).width * 0.105,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           borderRadius: BorderRadius.all(Radius.circular(
                //               AppConstants.screenSize(context).width * 0.02)),
                //         ),
                //         child: Icon(
                //           Icons.search,
                //           color: Colors.black,
                //           size: AppConstants.screenSize(context).width * 0.055,
                //         ),
                //         // child: IconButton(
                //         //   icon: Icon(Icons.search),
                //         //   color: Colors.black,
                //         //   iconSize:
                //         //       AppConstants.screenSize(context).width *
                //         //           0.055,
                //         //   onPressed: () {
                //         //     searchPageCubit.fetchVideos(_controller.text);
                //         //   },
                //         // ),
                //       ),
                //     ),
                //   ]),
                // ),
                Expanded(
                  child: BlocBuilder<HomePageCubit, HomePageState>(
                    bloc: searchPageCubit,
                    builder: (context, state) {
                      final videos = state is homePageLoaded
                          ? state.videos
                          : (state is homePageLoading || state is homePageError)
                              ? (state as dynamic).videos
                              : [];
                      if (state is homePageInitial) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width:
                                  AppConstants.screenSize(context).width * 0.26,
                              child: Lottie.network(
                                  'https://lottie.host/9de9fc6d-70a5-4140-af76-03d274b3bdf3/Ju1gKUDDPC.json',
                                  fit: BoxFit.contain),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Please click to search ..',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      AppConstants.screenSize(context).width *
                                          0.035,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }
                      if (state is homePageLoading && videos.isEmpty) {
                        return Center(
                            child: Container(
                          width: AppConstants.screenSize(context).width * 0.095,
                          height:
                              AppConstants.screenSize(context).width * 0.095,
                          color: Colors.transparent,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ));
                      } else if (state is homePageError && videos.isEmpty) {
                        return Center(
                          child: Text(
                            "There was a problem, please try again later!",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize:
                                    AppConstants.screenSize(context).width *
                                        0.035,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      } else if (videos.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Lottie.network(
                                  'https://lottie.host/67642fce-c86b-4ddf-8815-970f807a94f8/r9UHZJDNeP.json'),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No lectures found',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        AppConstants.screenSize(context).width *
                                            0.035,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            videos.length + 1, // +1 for the load more button
                        itemBuilder: (context, index) {
                          if (index < videos.length) {
                            final video = videos[index];
                            return VideoListItem(
                                video: video); // Your existing video widget
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      AppConstants.screenSize(context).width *
                                          0.05),
                              child: Center(
                                child: Container(
                                  width:
                                      AppConstants.screenSize(context).width *
                                          0.08,
                                  height:
                                      AppConstants.screenSize(context).width *
                                          0.08,
                                  color: Colors.transparent,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
