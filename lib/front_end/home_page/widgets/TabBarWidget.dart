import 'package:flutter/material.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';

class TabBarWidget extends StatelessWidget {
  final TabController tabController;
  final ScrollController scrollController;

  TabBarWidget({
    Key? key,
    required this.tabController,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants.screenSize(context);
    return Container(
      height: AppConstants.deviceType == 'mobile'
          ? 50
          : 150, // Height of the tab bar
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.yellow, // Yellow underline for selected tab
        labelColor: Colors.white, // Text color for selected tab
        unselectedLabelColor: Colors.white, // Text color for unselected tabs
        unselectedLabelStyle: TextStyle(fontSize: 14),
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold, // Bold text for selected tab
          fontSize: 16,
        ),
        tabs: List.generate(AppConstants.channelNames.length, (index) {
          final channelName = AppConstants.channelNames[index];
          return Tab(
            child: Text(
              channelName,
              style: TextStyle(
                fontSize: AppConstants.device == 'small_mobile'
                    ? 13
                    : AppConstants.deviceType == 'mobile'
                        ? 16
                        : AppConstants.device == 'small_tablet'
                            ? 27
                            : 37,
              ),
            ),
          );
        }),
      ),
    );
  }
}
