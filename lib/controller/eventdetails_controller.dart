// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/favorites_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/catwise_event.dart';
import 'package:magicmate/model/event_info.dart';
import 'package:magicmate/model/ticket_info.dart';

class EventDetailsController extends GetxController implements GetxService {
  FavoriteController favoriteController = Get.find();
  EventInfo? eventInfo;
  TicketInfo? ticketInfo;
  List<CatWiseInfo> catWiseInfo = [];
  bool isLoading = false;
  List<String> menberList = [];

  String ticketID = "";
  String ticketType = "";
  String ticketPrice = "";
  String totalTicke = "";

  var mTotal = 0.0;
  int totalTicket = 0;
  var mHandTotal = 0.0;

  getTotal({double? total, double? handtotal}) {
    mTotal = total ?? 0.0;
    mHandTotal = handtotal ?? 0.0;
    update();
  }

  getEventData({String? eventId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin") != null
            ? getData.read("UserLogin")["id"]
            : "1",
        "event_id": eventId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.eventDetails);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        menberList = [];
        for (var element in result["EventData"]["member_list"]) {
          menberList.add("${Config.imageUrl}" + element);
        }
        eventInfo = EventInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getEventTicket({String? eventId}) async {
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin") != null
            ? getData.read("UserLogin")["id"]
            : "1",
        "event_id": eventId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.ticketApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        ticketInfo = TicketInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  int selectedIndex = -1;
  getCatWiseEvent(dynamic index, {String? catId, title, img}) async {
    selectedIndex = index;
    update();
    try {
      isLoading = false;
      Map map = {
        "uid": getData.read("UserLogin") != null
            ? getData.read("UserLogin")["id"]
            : "1",
        "cat_id": catId,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.catWiseEvent);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        catWiseInfo = [];
        for (var element in result["CatEventData"]) {
          catWiseInfo.add(
            CatWiseInfo.fromJson(element),
          );
        }
        // Get.toNamed(Routes.catWiseEventScreen, arguments: {
        //   "title": title,
        //   "catImag": img,
        // });
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getFavAndUnFav({String? eventID}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"],
        "eid": eventID,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.favORUnFav);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        getEventData(eventId: eventID);
        favoriteController.getFavoriteListApi();
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  clearEventTicketData() {
    ticketID = "";
    ticketType = "";
    ticketPrice = "";
    totalTicke = "";
    update();
  }

  getEventTicketData(
      {String? ticketId1, ticketType1, ticketPrice1, totalTicket1}) {
    ticketID = ticketId1 ?? "";
    ticketType = ticketType1 ?? "";
    ticketPrice = ticketPrice1 ?? "";
    totalTicke = totalTicket1 ?? "";
    update();
  }
}
