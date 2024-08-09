// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/controller/bookevent_controller.dart';
import 'package:magicmate/controller/coupon_controller.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/order_details.dart';
import 'package:magicmate/utils/Colors.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  CouponController couponController = Get.find();
  BookEventController bookEventController = Get.find();

  double price = Get.arguments["price"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: blackColor30,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(
              "assets/x.png",
              height: 25,
              width: 25,
              color: WhiteColor,
            ),
          ),
        ),
        title: Text(
          "Coupons".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: WhiteColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              "Available coupons".tr,
              style: TextStyle(
                fontSize: 17,
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
              ),
            ),
          ),
          GetBuilder<CouponController>(builder: (context) {
            return Expanded(
              child: couponController.isLodding
                  ? couponController.couponList.isNotEmpty
                      ? ListView.builder(
                          itemCount: couponController.couponList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 120,
                              width: Get.size.width,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    padding: EdgeInsets.all(5),
                                    child: Image.network(
                                        "${Config.imageUrl}${couponController.couponList[index].cImg}"),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFf6f7f9),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          couponController
                                              .couponList[index].couponTitle,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: BlackColor,
                                            fontFamily: FontFamily.gilroyBold,
                                            // fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                couponController
                                                    .couponList[index]
                                                    .description,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily:
                                                      FontFamily.gilroyMedium,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (price >=
                                                    int.parse(couponController
                                                        .couponList[index]
                                                        .minAmt)) {
                                                  couponController
                                                      .checkCouponDataApi(
                                                    cid: couponController
                                                        .couponList[index].id,
                                                  );
                                                  bookEventController
                                                          .couponAmt =
                                                      double.parse(
                                                          couponController
                                                              .couponList[index]
                                                              .couponVal);
                                                  print("++++++++++-------" +
                                                      bookEventController
                                                          .couponAmt
                                                          .toString());
                                                  total = total -
                                                      double.parse(
                                                          couponController
                                                              .couponList[index]
                                                              .couponVal);
                                                  setState(() {});
                                                  Get.back(
                                                      result: couponController
                                                          .couponList[index]
                                                          .couponCode);
                                                }
                                              },
                                              child: Text(
                                                "Use".tr,
                                                style: TextStyle(
                                                  color: price >=
                                                          int.parse(
                                                              couponController
                                                                  .couponList[
                                                                      index]
                                                                  .minAmt)
                                                      ? gradient.defoultColor
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Ex ${couponController.couponList[index].expireDate.toString().replaceAll(" 00:00:00.000", "")}",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: BlackColor,
                                            fontFamily: FontFamily.gilroyMedium,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: WhiteColor,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "The Coupon is unavailable \n in your Event.".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                              color: BlackColor,
                            ),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator(
                        color: gradient.defoultColor,
                      ),
                    ),
            );
          }),
        ],
      ),
    );
  }
}
