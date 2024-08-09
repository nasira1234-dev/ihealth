// ignore_for_file: prefer_const_constructors

import 'package:get/route_manager.dart';
import 'package:magicmate/screen/LoginAndSignup/onbording_screen.dart.dart';
import 'package:magicmate/screen/LoginAndSignup/otp_screen.dart';
import 'package:magicmate/screen/LoginAndSignup/resetpassword_screen.dart';
import 'package:magicmate/screen/LoginAndSignup/signup_screen.dart';
import 'package:magicmate/screen/addwallet/addwallet_screen.dart';
import 'package:magicmate/screen/addwallet/wallet_screen.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/screen/catwise_event.dart';
import 'package:magicmate/screen/coupon_screen.dart';
import 'package:magicmate/screen/event_details.dart';
import 'package:magicmate/screen/order_details.dart';
import 'package:magicmate/screen/profile/editprofile_screen.dart';
import 'package:magicmate/screen/profile/loream.dart';
import 'package:magicmate/screen/ticket_details.dart';

class Routes {
  static String initial = "/";
  static String eventDetailsScreen = "/eventDetailsScreen";
  static String tikitDetailsScreen = "/tikitDetailsScreen";
  static String orderDetailsScreen = "/orderDetailsScreen";
  static String otpScreen = '/otpScreen';
  static String bottoBarScreen = "/bottoBarScreen";
  static String resetPassword = "/resetPassword";
  static String signUpScreen = "/signUpScreen";
  static String editProfileScreen = "/viewProfileScreen";
  static String loreamScreen = "/loreamScreen";
  static String addWalletScreen = "/addWalletScreen";
  static String walletScreen = "/walletScreen";
  static String couponScreen = "/couponScreen";
  static String catWiseEventScreen = "/catWiseEvent";
}

final getPages = [
  GetPage(
    name: Routes.initial,
    page: () => onBording(),
  ),
  GetPage(
    name: Routes.eventDetailsScreen,
    page: () => EventDetailsScreen(),
  ),
  GetPage(
    name: Routes.tikitDetailsScreen,
    page: () => TicketDetailsScreen(),
  ),
  GetPage(
    name: Routes.orderDetailsScreen,
    page: () => OrderDetailsScreen(),
  ),
  GetPage(
    name: Routes.otpScreen,
    page: () => OtpScreen(),
  ),
  GetPage(
    name: Routes.bottoBarScreen,
    page: () => BottomBarScreen(),
  ),
  GetPage(
    name: Routes.resetPassword,
    page: () => ResetPasswordScreen(),
  ),
  GetPage(
    name: Routes.signUpScreen,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: Routes.editProfileScreen,
    page: () => ViewProfileScreen(),
  ),
  GetPage(
    name: Routes.loreamScreen,
    page: () => Loream(),
  ),
  GetPage(
    name: Routes.addWalletScreen,
    page: () => AddWalletScreen(),
  ),
  GetPage(
    name: Routes.walletScreen,
    page: () => WalletHistoryScreen(),
  ),
  GetPage(
    name: Routes.couponScreen,
    page: () => CouponScreen(),
  ),
  GetPage(
    name: Routes.catWiseEventScreen,
    page: () => CatWiseEvent(),
  ),
];
