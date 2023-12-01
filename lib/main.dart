import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:guitarshop/components/layout.dart';
import 'package:guitarshop/screen/aboutsection.dart';
import 'package:guitarshop/screen/addtocartscreen.dart';
import 'package:guitarshop/screen/blogscreen.dart';
import 'package:guitarshop/screen/categoryguitarscreen.dart';
import 'package:guitarshop/screen/editprofilescreen.dart';
import 'package:guitarshop/screen/firstloadingscreen.dart';
import 'package:guitarshop/screen/homepagescreen.dart';
import 'package:guitarshop/screen/loginscreen.dart';
import 'package:guitarshop/screen/orderscreen.dart';
import 'package:guitarshop/screen/profilescreen.dart';
import 'package:guitarshop/screen/registerscreen.dart';
import 'package:guitarshop/screen/showorder.dart';
import 'package:guitarshop/screen/singleblog.dart';
import 'package:guitarshop/screen/singleguitar.dart';
import 'package:guitarshop/screen/splashscreen.dart';
import 'package:guitarshop/screen/wishlistscreen.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        importance: NotificationImportance.Max,
        ledColor: Colors.white,
        channelShowBadge: true,
      ),
    ],
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => const LoginScreenState(),
        // '/dashboard': (context) => const DashboardScreenState(),
        // '/showguitarwearos': (context) => const GuitarShowWearOs(),
        // '/showcatwearos': (context) => const ShowCategoryWearos(),
        // '/showcart': (context) => const ShowCart(),
        // '/showorderwearos': (context) => const ShowOrderWear(),

        '/': (context) => const SplashScreen(),
        '/layout': (context) => const LayoutScreen(),
        '/firstloading': (context) => const LoadingScreen(),
        '/homepage': (context) => const HomepageScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/addtocart': (context) => const AddToCartScreen(),
        '/wishlist': (context) => const WishlistScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/categoryguitar': (context) => const CategoryGuitarScreenState(),
        '/showblog': (context) => const BlogScreenState(),
        '/about': (context) => const AboutSection(),
        '/singleguitar': (context) => const SingleGuitarScreen(),
        '/singleblog': (context) => const SingleBlogScreen(),
        '/order': (context) => const OrderScreenState(),
        '/showorder': (context) => const ShowOrderScreen(),
        '/editprofile': (context) => const EditProfile(),
      },
    ),
  );
}
