import 'package:flutter/material.dart';
import 'package:lectures_app/core/utils/AppConstants.dart';
import 'package:lectures_app/core/utils/route/AppRoutes.dart';
import 'package:lectures_app/front_end/app_global/AppBar.dart';
import 'package:lectures_app/front_end/home_page/HomePage.dart';
import 'package:lectures_app/front_end/profile_page/ProfilePage.dart';
import 'package:lectures_app/front_end/search_page/SearchPage.dart';
import 'package:lectures_app/front_end/favourite_page/FavouritePage.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;
  // list of pages for navbart tabs
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    FavouritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    AppConstants.setDevice(context);
    // variables for drawer
    final drawerIconSize = AppConstants.deviceType == 'mobile'
        ? AppConstants.screenSize(context).width * 0.047 + 10
        : AppConstants.screenSize(context).width * 0.047 + 10;
    final drawerTextSize = AppConstants.deviceType == 'mobile'
        ? AppConstants.screenSize(context).width * 0.047
        : AppConstants.screenSize(context).width * 0.042;
    final drawerItemPadding = [
      AppConstants.deviceType == 'mobile'
          ? AppConstants.screenSize(context).width * 0.006
          : AppConstants.screenSize(context).width * 0.02, // horizontal
      AppConstants.deviceType == 'mobile'
          ? AppConstants.screenSize(context).width * 0.0000001
          : AppConstants.screenSize(context).width * 0.012, // vertical
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(AppConstants.screenSize(context).height * 0.09),
          child: AppBar1(),
        ),
        extendBodyBehindAppBar: true,
        // drawer design and actions
        drawer: Drawer(
          width: AppConstants.deviceType == 'mobile'
              ? AppConstants.screenSize(context).width * 0.6
              : AppConstants.screenSize(context).width * 0.52,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: AppConstants.screenSize(context).height * 0.25,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 1, 15, 28),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Watch App',
                        style: TextStyle(
                          fontSize: AppConstants.deviceType == 'mobile'
                              ? AppConstants.screenSize(context).width * 0.1
                              : AppConstants.screenSize(context).width * 0.08,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[
                                Colors.blue,
                                Colors.purple,
                                Colors.pink
                              ],
                            ).createShader(
                                Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          shadows: [
                            Shadow(
                              offset: Offset(4.0, 4.0), // Creates a 3D effect
                              blurRadius: 4.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerItemPadding[0],
                  vertical: drawerItemPadding[1],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    size: drawerIconSize,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(fontSize: drawerTextSize),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerItemPadding[0],
                  vertical: drawerItemPadding[1],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    size: drawerIconSize,
                  ),
                  title: Text(
                    'Search',
                    style: TextStyle(fontSize: drawerTextSize),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerItemPadding[0],
                  vertical: drawerItemPadding[1],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.favorite,
                    size: drawerIconSize,
                  ),
                  title: Text(
                    'Favourites',
                    style: TextStyle(fontSize: drawerTextSize),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerItemPadding[0],
                  vertical: drawerItemPadding[1],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: drawerIconSize,
                  ),
                  title: Text(
                    'Profile',
                    style: TextStyle(fontSize: drawerTextSize),
                  ),
                  onTap: () {
                    setState(() {
                      _currentIndex = 3;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.deviceType == 'mobile'
                      ? drawerItemPadding[0] * 9
                      : drawerItemPadding[0] * 2,
                  vertical: drawerItemPadding[1],
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      AppRoutes.mostImportantPlaylist,
                    );
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.playlist_play,
                          size: drawerIconSize * 1.12,
                        ),
                        SizedBox(
                            width: 10), // Add spacing between icon and text
                        Expanded(
                          child: Text(
                            'Most important playlist',
                            style: TextStyle(fontSize: drawerTextSize),
                            maxLines:
                                2, // Allow text to wrap into 2 lines if needed
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if text overflows
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: drawerItemPadding[0],
                  vertical: drawerItemPadding[1],
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    size: drawerIconSize,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(fontSize: drawerTextSize),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Color.fromARGB(255, 1, 15, 28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(
                            'About us',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 153, 246, 145),
                                fontWeight: FontWeight.bold,
                                fontSize: AppConstants.deviceType == 'mobile'
                                    ? AppConstants.screenSize(context).width *
                                        0.045
                                    : AppConstants.screenSize(context).width *
                                        0.04),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "The main goal of this application is to glorify Allah Almighty,"
                                " to be proud of the Islamic identity, to establish faith in souls,"
                                " and so on.\n If you have any comments, do not hesitate to contact us at"
                                " the following email: \"mahmood@outlook.com\"",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        AppConstants.deviceType == 'mobile'
                                            ? AppConstants.screenSize(context)
                                                    .width *
                                                0.034
                                            : AppConstants.screenSize(context)
                                                    .width *
                                                0.028),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          AppConstants.deviceType == 'mobile'
                                              ? AppConstants.screenSize(context)
                                                      .width *
                                                  0.035
                                              : AppConstants.screenSize(context)
                                                      .width *
                                                  0.03),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // control navbar
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: Container(
            height: AppConstants.deviceType == 'mobile'
                ? AppConstants.screenSize(context).width * 0.17
                : AppConstants.screenSize(context).width * 0.13,
            child: BottomNavigationBar(
              selectedIconTheme: IconThemeData(
                  size: AppConstants.deviceType == 'mobile'
                      ? AppConstants.screenSize(context).width * 0.065
                      : AppConstants.screenSize(context).width * 0.05),
              unselectedIconTheme: IconThemeData(
                  size: AppConstants.deviceType == 'mobile'
                      ? AppConstants.screenSize(context).width * 0.055
                      : AppConstants.screenSize(context).width * 0.045),
              selectedFontSize: AppConstants.deviceType == 'mobile'
                  ? AppConstants.screenSize(context).width * 0.037
                  : AppConstants.screenSize(context).width * 0.03,
              unselectedFontSize: AppConstants.deviceType == 'mobile'
                  ? AppConstants.screenSize(context).width * 0.032
                  : AppConstants.screenSize(context).width * 0.025,
              currentIndex: _currentIndex,
              backgroundColor: const Color.fromARGB(255, 11, 2, 24),
              selectedItemColor: Colors.white,
              unselectedItemColor: const Color.fromARGB(255, 185, 182, 182),
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
