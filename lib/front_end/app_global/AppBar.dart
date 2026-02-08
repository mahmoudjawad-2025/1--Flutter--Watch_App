import 'package:flutter/material.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';

class AppBar1 extends StatelessWidget {
  const AppBar1({super.key});
  Widget build(BuildContext context) {
    // note dynamic values
    return Padding(
      padding: EdgeInsets.only(
          top: AppConstants.device == 'small_mobile'
              ? AppConstants.screenSize(context).height * 0.0
              : AppConstants.deviceType == 'mobile'
                  ? AppConstants.screenSize(context).height * 0.01
                  : AppConstants.screenSize(context).height * 0.02),
      child: AppBar(
        // specifications and contents of appbar
        iconTheme: IconThemeData(
            color: Colors.white,
            size: AppConstants.device == 'small_mobile'
                ? AppConstants.screenSize(context).height * 0.0378
                : AppConstants.deviceType == 'mobile'
                    ? AppConstants.screenSize(context).width * 0.08
                    : AppConstants.screenSize(context).width * 0.068),
        backgroundColor: Colors.transparent, //Colors.transparent,
        title: Padding(
          padding: EdgeInsets.only(
              top: AppConstants.deviceType == 'mobile'
                  ? AppConstants.screenSize(context).height * 0.0000001
                  : AppConstants.screenSize(context).height * 0.02),
          child: Text(
            'MOVIE',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppConstants.device == 'small_mobile'
                  ? AppConstants.screenSize(context).height * 0.03
                  : AppConstants.deviceType == 'mobile'
                      ? AppConstants.screenSize(context).width * 0.06
                      : AppConstants.screenSize(context).width * 0.05,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: AppConstants.device == 'small_mobile'
                ? AppConstants.screenSize(context).height * 0.04
                : AppConstants.deviceType == 'mobile'
                    ? AppConstants.screenSize(context).width * 0.077
                    : AppConstants.screenSize(context).width * 0.073,
          ),
          // open drawer
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          Container(
            width: AppConstants.deviceType == 'mobile'
                ? AppConstants.screenSize(context).width * 0.12
                : AppConstants.screenSize(context).width * 0.12,
            height: AppConstants.deviceType == 'mobile'
                ? AppConstants.screenSize(context).width * 0.12
                : AppConstants.screenSize(context).width * 0.12,
            // when click on notification icon
            child: IconButton(
              icon: Icon(Icons.notifications),
              color: Colors.white,
              onPressed: () {
                showNotificationWindow(context);
              },
            ),
          ),
        ],

        elevation: 0,
        clipBehavior: Clip.none,
      ),
    );
  }

  void showNotificationWindow(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Notifications',
            style: TextStyle(
                fontSize: AppConstants.deviceType == 'mobile'
                    ? AppConstants.screenSize(context).width * 0.045 + 2
                    : AppConstants.screenSize(context).width * 0.035 + 2,
                fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "There's no notifications yet!",
                style: TextStyle(
                    fontSize: AppConstants.deviceType == 'mobile'
                        ? AppConstants.screenSize(context).width * 0.045
                        : AppConstants.screenSize(context).width * 0.035),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontSize: AppConstants.deviceType == 'mobile'
                          ? AppConstants.screenSize(context).width * 0.045
                          : AppConstants.screenSize(context).width * 0.035),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
