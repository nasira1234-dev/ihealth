// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class BookEventController extends GetxController implements GetxService {
  double couponAmt = 0.0;
  bool booking = false;
  bookEventApi(
      {String? eID,
      typeId,
      type,
      price,
      totalTicket,
      subTotal,
      handTotal,
      tax,
      couAmt,
      totalAmt,
      wallAmt,
      pMethodId,
      otid,
      pLimit,
      sponsoreId,
      ccode}) async {
    if (booking) {
      return;
    }
    booking = true;
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "eid": eID ?? "",
        "typeid": typeId,
        "type": type,
        "price": price,
        "total_ticket": totalTicket,
        "subtotal": subTotal,
        "handTotal": handTotal,
        "tax": tax,
        "cou_amt": couAmt,
        "total_amt": totalAmt,
        "wall_amt": wallAmt,
        "p_method_id": pMethodId,
        "transaction_id": otid,
        "plimit": pLimit,
        "sponsore_id": sponsoreId,
        "coupen_code": ccode
      };
      print("::::::::::---------::::::::::" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.bookEventApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("........=========........" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        booking = false;
        print("........=========........" + result.toString());
        if (result["Result"] == "true") {
          showToastMessage(result["ResponseMsg"]);
          OrderPlacedSuccessfully();
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
