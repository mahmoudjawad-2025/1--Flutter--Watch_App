import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Watch';
  static String device = 'large_mobile';
  static String deviceType = 'mobile';
  static const String baseImageUrl = '';

  // APIs
  static const String apiKey2 = 'AIzaSyAfm-8W06rgw9hJFYfXVHWsPStug85XAvU';
  static const String apiKey3 = "AIzaSyC1Q913gxli5kgKmqlBByE9xpqfb2Z5pAE";
  static const String apiKey = "AIzaSyAwNglHW_3V6Y07YkF5E39o2BxTU72qqiQ";
  static const channelIds = [
    'UCahYlNszeMy_PHffYvgAOHg', //dr eyad
    'UC7AbKZa30XPMInZIsViiBOQ', //dr ahmad syyed
    'UC4a5m_aUZQ-PARanwoOKHAw' // yaser mamdouh
  ];
  static const channelNames = [
    'Prof. Iyad Qanibi', //dr eyad
    'Ahmad Alsayed', //dr ahmad syyed
    'Yasser Mamdouh' // yaser mamdouh
  ];
  static const playListIds = [
    'PL56IcDjrf3YJr__TEOJ2UOv3jCzht1_yc', //rehlat alyaqeen
  ];

  // carousel/ channels images
  static List<Map<String, String>> images = [
    {
      "image": "lib/core/assets/carousel_slider/iyad_qanibi.jpg",
    },
    {
      "image": "lib/core/assets/carousel_slider/ahmad_alsayed.jpg",
    },
    {
      "image": "lib/core/assets/carousel_slider/yaser_mamdouh.jpg",
    },
  ];
  // set device name and type
  static void setDevice(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width <= 360) {
      device = 'small_mobile';
      deviceType = 'mobile';
    } else if (size.width <= 412) {
      device = 'medium_mobile';
      deviceType = 'mobile';
    } else if (size.width <= 480) {
      device = 'large_mobile';
      deviceType = 'mobile';
    } else if (size.width <= 800) {
      device = 'small_tablet';
      deviceType = 'tablet';
    } else if (size.width <= 1024) {
      device = 'medium_tablet';
      deviceType = 'tablet';
    } else if (size.width <= 1280) {
      device = 'large_tablet';
      deviceType = 'tablet';
    }
  }

  // return size of current screen
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
