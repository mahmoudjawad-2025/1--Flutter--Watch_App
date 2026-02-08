import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectures_app/back_end/home_page/cubit/VideoCubit.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/widgets/Background.dart';
import 'package:lectures_app/front_end/home_page/widgets/CarouselSlider.dart';
import 'package:lectures_app/front_end/home_page/widgets/TabBarWidget.dart';
import 'package:lectures_app/front_end/home_page/widgets/VideoListWidget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final PageController _pageController = PageController();
  int currentIndex = 0;
  bool isAnimating = false;
  ScrollController _scrollController = ScrollController();

  final List<String> backgroundImages = [
    "https://image.tmdb.org/t/p/w500/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg",
    "https://image.tmdb.org/t/p/w500/eDnHgozW8vfOaLHzfpHluf1GZCW.jpg",
    "https://image.tmdb.org/t/p/w500/aJphRf00MiGLXBL0Fb4gcA3B5vT.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: AppConstants.channelIds.length, vsync: this);

    // fetch videos for all channels
    final cubit = context.read<VideoCubit>();
    for (var channelId in AppConstants.channelIds) {
      cubit.fetchVideos(channelId);
    }
    // listen continuosly
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && !isAnimating) {
        syncWithIndex(_tabController.index, animate: true);
      }
    });
  }

  // sync
  void syncWithIndex(int index, {bool animate = false}) {
    if (isAnimating) return;

    setState(() {
      currentIndex = index;
      isAnimating = true;
    });

    if (animate) {
      Future.wait([
        _carouselController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
      ]).then((_) {
        setState(() {
          isAnimating = false;
        });
      });
    } else {
      _carouselController.jumpToPage(index);
      _pageController.jumpToPage(index);
      setState(() {
        isAnimating = false;
      });
    }

    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Background(),
        Column(
          children: [
            HomeCarouselSlider1(
              carouselController: _carouselController,
              currentIndex: currentIndex,
              onPageChanged: (index) {
                if (!isAnimating) syncWithIndex(index, animate: true);
              },
            ),
            //Tabs and Video List
            Expanded(
              child: Column(
                children: [
                  TabBarWidget(
                    tabController: _tabController,
                    scrollController: _scrollController,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        if (!isAnimating) syncWithIndex(index, animate: true);
                      },
                      itemCount: AppConstants.channelIds.length,
                      itemBuilder: (context, index) {
                        // return Container();
                        return VideoListWidget(
                            isChannel: true,
                            channelId: AppConstants.channelIds[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }
}
