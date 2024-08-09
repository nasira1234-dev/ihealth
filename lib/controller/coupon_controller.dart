// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/bookevent_controller.dart';
import 'package:magicmate/model/coupon_info.dart';
import 'package:magicmate/screen/order_details.dart';

class CouponController extends GetxController implements GetxService {
  List<CouponInfo> couponList = [];
  bool isLodding = false;
  TextEditingController couponET = TextEditingController();

  String copResult = "";
  String couponMsg = "";

  getCouponDataApi(
      {String? sponsoreID,
      String? copuon,
      BookEventController? bookEventController,
      dynamic subtotal}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "sponsore_id": sponsoreID,
        "copuon_code": copuon,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponlist);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        couponList = [];
        for (var element in result["couponlist"]) {
          couponList.add(CouponInfo.fromJson(element));
        }
        if (subtotal >= int.parse(couponList.first.minAmt)) {
          checkCouponDataApi(
            cid: couponList.first.id,
          );

          double discountPercentage =
              double.parse(couponList.first.couponVal) / 100;
          double discountAmount =
              roundToTwoDecimalPlaces(total * discountPercentage);
          print("++++++++++-------$discountAmount");
          bookEventController?.couponAmt = discountAmount;
          total = total - discountAmount;
          isLodding = true;
          update();
          return copuon;
        } else {
          isLodding = true;
          update();
          return "Coupon not applyed";
        }
      } else {
        isLodding = true;
        update();
        return "Coupon not found";
      }
    } catch (e) {
      print(e.toString());
    }
  }

  double roundToTwoDecimalPlaces(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  checkCouponDataApi({String? cid}) async {
    try {
      isLodding = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "cid": cid,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponCheck);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        copResult = result["Result"];
        couponMsg = result["ResponseMsg"];
      }
      isLodding = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
