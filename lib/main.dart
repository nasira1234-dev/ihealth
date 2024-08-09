// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/screen/language/local_string.dart';
import 'package:magicmate/utils/Custom_widget.dart';

import 'helpar/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  await Firebase.initializeApp();
  await di.init();
  await GetStorage.init();
  // fcf3fbfb-f09b-43af-9fb3-5603db555e06
  initPlatformState();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: "Gilroy",
      ),
      translations: LocaleString(),
      locale: getData.read("lan2") != null
          ? Locale(getData.read("lan2"), getData.read("lan1"))
          : Locale('ar', 'ar'),
      initialRoute: Routes.bottoBarScreen,
      getPages: getPages,
    ),
  );
}

      // <a data-id="<?php echo $row[
      //                                           "id"
      //                                           ]; ?>" data-status="Completed" data-type="update_status"
      //                                            coll-type="com_game"
      //                                            href="javascript:void(0);" class="drop badge badge-success"
      //                                             data-bs-toggle="tooltip" data-bs-placement="top"
      //                                              data-bs-title="Completed Event">
      //                                             <i data-feather="thumbs-up"></i></a>
      //                                        <a data-id="<?php echo $row[
      //                                           "id"
      //                                           ]; ?>" data-status="Cancelled" data-type="update_status"
      //                                            coll-type="can_game"
      //                                            href="javascript:void(0);" class="drop badge badge-danger"
      //                                             data-bs-toggle="tooltip" data-bs-placement="top"
      //                                              data-bs-title="Cancelled Event"><i data-feather="x-square"></i></a>
