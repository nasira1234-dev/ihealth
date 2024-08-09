import 'package:get/get.dart';
import 'package:magicmate/controller/bookevent_controller.dart';
import 'package:magicmate/controller/coupon_controller.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/controller/faq_controller.dart';
import 'package:magicmate/controller/favorites_controller.dart';
import 'package:magicmate/controller/home_controller.dart';
import 'package:magicmate/controller/login_controller.dart';
import 'package:magicmate/controller/mybooking_controller.dart';
import 'package:magicmate/controller/notification_controller.dart';
import 'package:magicmate/controller/org_controller.dart';
import 'package:magicmate/controller/pagelist_controller.dart';
import 'package:magicmate/controller/search_controller.dart';
import 'package:magicmate/controller/signup_controller.dart';
import 'package:magicmate/controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(() => PageListController());
  Get.lazyPut(() => WalletController());
  Get.lazyPut(() => EventDetailsController());
  Get.lazyPut(() => FavoriteController());
  Get.lazyPut(() => CouponController());
  Get.lazyPut(() => BookEventController());
  Get.lazyPut(() => MyBookingController());
  Get.lazyPut(() => SearchController());
  Get.lazyPut(() => FaqController());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => OrgController());
}
