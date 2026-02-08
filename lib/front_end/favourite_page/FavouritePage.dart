import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/favourite_page/cubit/FavouritePageCubit.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/front_end/search_page/models/VideoListItem.dart';
import 'package:lectures_app/core/models/VideoModel.dart';
import 'package:lectures_app/core/widgets/Background.dart';
import 'package:lottie/lottie.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // refresh device info
    AppConstants.setDevice(context);
    final favouriteVideos = Video.favouriteVideos;
    final favouritePageCubit = context.read<FavouritePageCubit>();
    return BlocBuilder(
      bloc: favouritePageCubit,
      builder: (context, state) => Stack(
        children: [
          Background(),
          favouriteVideos.isEmpty
              // favourite list is empty
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // addemoji
                          Container(
                            //width: 250,
                            height:
                                AppConstants.screenSize(context).width * 0.4,
                            child: Lottie.network(
                                "https://lottie.host/d5a12482-068e-4f3e-803c-4e3c329137f5/13HrSnKq4g.json"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'No favourite lectures yet.',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    AppConstants.screenSize(context).width *
                                        0.035),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              // There are favourite videos
              : Padding(
                  padding: EdgeInsets.only(
                      top: AppConstants.screenSize(context).height * 0.045),
                  child: ListView.builder(
                    itemCount: favouriteVideos.length,
                    itemBuilder: (context, index) {
                      final video = favouriteVideos[index];
                      return VideoListItem(video: video);
                    },
                  ),
                )
        ],
      ),
    );
  }
}
