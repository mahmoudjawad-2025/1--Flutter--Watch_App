import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/widgets/Background.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.setDevice(context);
    final size = MediaQuery.of(context).size;

    return Stack(children: [
      Background(),
      Padding(
        padding: EdgeInsets.only(
          top: AppConstants.device == 'large_mobile'
              ? 80
              : AppConstants.deviceType == 'mobile'
                  ? 70
                  : AppConstants.device == 'large_tablet'
                      ? 200
                      : 200,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // profile image
              CircleAvatar(
                radius: AppConstants.screenSize(context).width * 0.27,
                backgroundImage: const NetworkImage(
                  'https://images.inc.com/uploaded_files/image/1920x1080/getty_481292845_77896.jpg',
                ),
              ),
              const SizedBox(height: 24.0),
              //profile info
              Text(
                'Ahmed Mohamed',
                style: TextStyle(
                    fontSize: AppConstants.screenSize(context).width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 6.0),
              Text(
                'Software Engineer',
                style: TextStyle(
                  fontSize: AppConstants.screenSize(context).width * 0.06,
                  color: Color.fromARGB(115, 222, 215, 215),
                ),
              ),
              const SizedBox(height: 14.0),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),
              // icon buttons to control app
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable GridView scrolling
                  crossAxisCount: 2,
                  // set icons and texts dynamiclly
                  children: List.generate(4, (index) {
                    List icons = [
                      Icons.settings,
                      Icons.language,
                      Icons.theater_comedy,
                      Icons.exit_to_app
                    ];
                    List names = ['General', 'Language', 'Theme', 'Exit'];
                    List buttonsCount = [1, 1, 1];
                    List buttonsContent = ['Default', 'English', 'Dark'];
                    return Padding(
                      padding: EdgeInsets.all(AppConstants.device ==
                              'large_mobile'
                          ? AppConstants.screenSize(context).width * 0.08
                          : AppConstants.deviceType == 'mobile'
                              ? AppConstants.screenSize(context).width * 0.06
                              : AppConstants.device == 'large_tablet'
                                  ? AppConstants.screenSize(context).width *
                                      0.11
                                  : AppConstants.device == 'medium_tablet'
                                      ? AppConstants.screenSize(context).width *
                                          0.1
                                      : AppConstants.screenSize(context).width *
                                          0.08),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: LayoutBuilder(builder: (context, constraints) {
                            final gridElementSize = constraints.maxWidth * 0.5;
                            return InkWell(
                              onTap: () {
                                if (index != 3) {
                                  showDialogWindow(context, buttonsCount[index],
                                      buttonsContent[index]);
                                } else {
                                  if (Platform.isAndroid)
                                    SystemNavigator.pop();
                                  else
                                    exit(0);
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icons[index],
                                    size: gridElementSize,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    names[index],
                                    style: TextStyle(
                                      fontSize: gridElementSize * 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  // show window with list items when click on any button
  void showDialogWindow(BuildContext context, int count, String value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 1, 15, 28),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Padding(
            padding:
                EdgeInsets.all(AppConstants.screenSize(context).width * 0.04),
            child: Text('Please choose your choice:',
                style: TextStyle(
                    fontSize: AppConstants.screenSize(context).width * 0.06,
                    color: Colors.white)),
          ),
          content: Padding(
            padding:
                EdgeInsets.all(AppConstants.screenSize(context).width * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize:
                                AppConstants.screenSize(context).width * 0.04,
                            color: Color.fromARGB(255, 1, 15, 28)),
                      )),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              AppConstants.screenSize(context).width * 0.04),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
