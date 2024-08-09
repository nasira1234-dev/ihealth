// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/screen/LoginAndSignup/resetpassword_screen.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/utils/Custom_widget.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class SignUpController extends GetxController implements GetxService {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  TextEditingController idCard = TextEditingController();

  bool showPassword = true;
  bool chack = false;
  int currentIndex = 0;
  String userMessage = "";
  String resultCheck = "";

  String signUpMsg = "";

  showOfPassword() {
    showPassword = !showPassword;
    update();
  }

  checkTermsAndCondition(bool? newbool) {
    chack = newbool ?? false;
    update();
  }

  cleanFild() {
    name.text = "";
    email.text = "";
    number.text = "";
    password.text = "";
    referralCode.text = "";
    idCard.text = "";
    chack = false;
    update();
  }

  changeIndex(int index) {
    currentIndex = index;
    update();
  }

  checkMobileNumber(String cuntryCode) async {
    try {
      Map map = {
        "mobile": number.text,
        "ccode": cuntryCode,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.mobileChack);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        userMessage = result["ResponseMsg"];
        resultCheck = result["Result"];
        print("MMMMMMMMMMMMMMMMMM" + userMessage);
        if (resultCheck == "true") {
          sendOTP(number.text, cuntryCode);
          Get.toNamed(Routes.otpScreen, arguments: {
            "number": number.text,
            "cuntryCode": cuntryCode,
            "route": "signUpScreen",
          });
        }
        showToastMessage(userMessage);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  checkMobileInResetPassword({String? number, String? cuntryCode}) async {
    try {
      Map map = {
        "mobile": number,
        "ccode": cuntryCode,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.mobileChack);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        userMessage = result["ResponseMsg"];
        resultCheck = result["Result"];
        if (resultCheck == "false") {
          sendOTP(number ?? "", cuntryCode ?? "");
          Get.toNamed(Routes.otpScreen, arguments: {
            "number": number,
            "cuntryCode": cuntryCode,
            "route": "resetScreen",
          });
        } else {
          showToastMessage('Invalid Mobile Number');
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  bool _isLoding = false;
  bool get isLoding => _isLoding;

  setUserApiData(String cuntryCode) async {
    _isLoding = true;
    update();
    try {
      password.text = idCard.text;
      Map map = {
        "name": name.text,
        "email": "",
        "mobile": number.text,
        "ccode": cuntryCode,
        "password": password.text,
        'idCard': idCard.text
      };
      Uri uri = Uri.parse(Config.baseurl + Config.registerUser);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      _isLoding = false;
      update();
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        save('Firstuser', true);
        signUpMsg = result["ResponseMsg"];
        showToastMessage(signUpMsg);
        save("UserLogin", result["UserLogin"]);
        initPlatformState();
        OneSignal.User.addTagWithKey(
            "user_id", getData.read("UserLogin")["id"]);
        _isLoding = false;
        update();
        Get.offAll(BottomBarScreen());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  editProfileApi(
      {String? name, String? password, String? email, String? idCard}) async {
    try {
      Map map = {
        "name": name,
        "uid": getData.read("UserLogin")["id"].toString(),
        "password": password,
        "email": email,
        "idCard": idCard
      };
      Uri uri = Uri.parse(Config.baseurl + Config.editProfileApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        save("UserLogin", result["UserLogin"]);
        showToastMessage(result["ResponseMsg"]);
      }
      Get.back();
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
