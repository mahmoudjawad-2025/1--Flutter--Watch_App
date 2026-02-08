import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';

class HomeCarouselSlider1 extends StatefulWidget {
  final CarouselSliderController carouselController;
  final int currentIndex;
  final Function(int) onPageChanged;
  final bool enableCircularScroll;

  const HomeCarouselSlider1({
    required this.carouselController,
    required this.currentIndex,
    required this.onPageChanged,
    this.enableCircularScroll = false, // Default to circular scroll
    super.key,
  });

  @override
  State<HomeCarouselSlider1> createState() => _HomeCarouselSlider1State();
}

class _HomeCarouselSlider1State extends State<HomeCarouselSlider1> {
  @override
  Widget build(BuildContext context) {
    AppConstants.setDevice(context);
    return Stack(
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                flex: 2, // Adjust this flex to control background height
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      AppConstants.images[widget.currentIndex]['image']!,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 3, sigmaY: 3), // Adjust blur intensity
                      child: Container(
                          color: Colors.black
                              .withOpacity(0.1)), // Optional overlay
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1), // Empty space below background
            ],
          ),
        ),
        // Carousel slider
        Align(
          alignment: Alignment.topRight,
          child: CarouselSlider.builder(
            carouselController: widget.carouselController,
            itemCount: AppConstants.images.length,
            itemBuilder: (context, index, realIndex) {
              final movie = AppConstants.images[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Front image positioned at the bottom
                  Container(
                    height: AppConstants.device == 'large_mobile'
                        ? AppConstants.screenSize(context).width * 0.45
                        : AppConstants.deviceType == 'mobile'
                            ? AppConstants.screenSize(context).width * 0.5
                            : AppConstants.device == 'small_tablet'
                                ? AppConstants.screenSize(context).width * 0.45
                                : AppConstants.screenSize(context).width * 0.35,
                    width: AppConstants.device == 'large_mobile'
                        ? AppConstants.screenSize(context).width * 0.45
                        : AppConstants.deviceType == 'mobile'
                            ? AppConstants.screenSize(context).width * 0.5
                            : AppConstants.device == 'small_tablet'
                                ? AppConstants.screenSize(context).width * 0.45
                                : AppConstants.screenSize(context).width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        movie['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            },
            // settings of carousel
            options: CarouselOptions(
              height: AppConstants.deviceType == 'mobile'
                  ? AppConstants.screenSize(context).height * 0.36
                  : AppConstants.screenSize(context).height * 0.38,
              viewportFraction: 0.6,
              enableInfiniteScroll: widget.enableCircularScroll,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                widget.onPageChanged(index);
              },
            ),
          ),
        ),
      ],
    );
  }
}
