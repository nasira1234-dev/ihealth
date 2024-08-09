// ignore_for_file: avoid_print, prefer_const_constructors, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/catwise_event.dart';
import 'package:magicmate/model/home_info.dart';
import 'package:magicmate/model/map_info.dart';
import 'package:magicmate/screen/LoginAndSignup/onbording_screen.dart.dart';
import 'package:magicmate/screen/home_screen.dart';

class HomePageController extends GetxController implements GetxService {
  EventDetailsController eventDetailsController = Get.find();
  PageController pageController = PageController();

  List<MapInfo> mapInfo = [];
  List<dynamic> banners = [];
  List<dynamic> providers = [];

  bool isLoading = false;
  HomeInfo? homeInfo;

  CameraPosition kGoogle = CameraPosition(
    target: LatLng(21.2381962, 72.8879607),
    zoom: 5,
  );

  List<Marker> markers = <Marker>[];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  HomePageController() {
    getHomeDataApi();
    getCatWiseProvider(-1, catId: '');
  }
  List<CatWiseInfo> catWiseInfo = [];

  int selectedIndex = -1;
  getCatWiseProvider(dynamic index, {String? catId}) async {
    selectedIndex = index;
    update();
    try {
      //   isLoading = true;
      providers = [];
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
        providers.clear();
        for (var element in result["Providers"]) {
          providers.add(element);
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getHomeDataApi() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin") != null
            ? getData.read("UserLogin")["id"]
            : "0",
        "lats": lat,
        "longs": long,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.homeDataApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(
          "::::::::::________::::::::::" + Config.baseurl + Config.homeDataApi);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("::::::::::________::::::::::" + result.toString());
        banners.clear();
        for (var element in result["HomeData"]["banners"]) {
          banners.add(element);
        }

        // for (var element in result["HomeData"]["nearby_event"]) {
        //   mapInfo.add(MapInfo.fromJson(element));
        // }
        homeInfo = HomeInfo.fromJson(result);
        // print(homeInfo);
        // var maplist = mapInfo.reversed.toList();

        // for (var i = 0; i < maplist.length; i++) {
        //   final Uint8List markIcon = await getImages("assets/MapPin.png", 100);
        //   markers.add(
        //     Marker(
        //       markerId: MarkerId(i.toString()),
        //       position: LatLng(
        //         double.parse(mapInfo[i].eventLatitude),
        //         double.parse(mapInfo[i].eventLongtitude),
        //       ),
        //       icon: BitmapDescriptor.fromBytes(markIcon),
        //       onTap: () {
        //         pageController.animateToPage(i,
        //             duration: Duration(seconds: 1), curve: Curves.decelerate);
        //         update();
        //       },
        //       infoWindow: InfoWindow(
        //         title: mapInfo[i].eventTitle,
        //         snippet: mapInfo[i].eventPlaceName,
        //         onTap: () async {
        //           await eventDetailsController.getEventData(
        //             eventId: mapInfo[i].eventId,
        //           );
        //           Get.toNamed(
        //             Routes.eventDetailsScreen,
        //             arguments: {
        //               "eventId": mapInfo[i].eventId,
        //               "bookStatus": "1",
        //             },
        //           );
        //         },
        //       ),
        //     ),
        //   );
        //   kGoogle = CameraPosition(
        //     target: LatLng(
        //       double.parse(maplist[i].eventLatitude),
        //       double.parse(maplist[i].eventLongtitude),
        //     ),
        //     zoom: 8,
        //   );
        // }

        currency = result["HomeData"]["Main_Data"]["currency"];
        terms = result["HomeData"]["Main_Data"]["terms_url"];
        vats = result["HomeData"]["Main_Data"]["vat_url"];
        wallet1 = result["HomeData"]["wallet"];
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  List<dynamic> offers = [];
  List<dynamic> service = [];
  dynamic proiverInfo = [];
  List<dynamic> reivews = [];
  int tabIndex = 0;

  getPrivedorDetails(String id) async {
    try {
      isLoading = true;
      offers = [];
      service = [];
      reivews = [];
      proiverInfo = [];
      Map map = {
        "uid": getData.read("UserLogin") != null
            ? getData.read("UserLogin")["id"]
            : "1",
        "provider_id": id,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.providerInfo);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        var result = jsonDecode(response.body);
        print(result);
        offers.clear();
        reivews.clear();
        offers.clear();
        for (var element in result["Offers"]) {
          offers.add(element);
        }
        for (var element in result["Service"]) {
          service.add(element);
        }
        for (var element in result["reviews"]) {
          reivews.add(element);
        }
        // proiverInfo = result["proiverInfo"];
      }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  void select(int index) {
    tabIndex = index;
    update();
  }
}
