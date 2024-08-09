import 'dart:convert';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/controller/home_controller.dart';
import 'package:magicmate/controller/login_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/bottom_picker.dart';
import 'package:http/http.dart' as http;
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/screen/contactus_screen.dart';
import 'package:magicmate/screen/offer_detail.dart';
import 'package:magicmate/screen/searchevent_screen.dart';
import 'package:magicmate/screen/seeAll/latest_event.dart';
import 'package:magicmate/utils/Colors.dart';

class HomeScreen3 extends StatefulWidget {
  const HomeScreen3({super.key});

  @override
  State<HomeScreen3> createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3> {
  String? base64Image;
  EventDetailsController eventDetailsController = Get.find();
  double height = Get.height * 0.25;
  HomePageController homePageController = Get.find();
  bool lastStatus = true;
  LoginController loginController = Get.find();
  String? networkimage;
  String selectedCity = "";
  String userName = "";

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    getData.read("UserLogin") != null
        ? setState(() {
            userName = getData.read("UserLogin")["name"] ?? "";
            networkimage = getData.read("UserLogin")["pro_pic"] ?? "";
            getData.read("UserLogin")["pro_pic"] != "null"
                ? setState(() {
                    networkimageconvert();
                  })
                : const SizedBox();
          })
        : null;
  }

  networkimageconvert() {
    (() async {
      http.Response response =
          await http.get(Uri.parse(Config.imageUrl + networkimage.toString()));
      if (mounted) {
        setState(() {
          base64Image = const Base64Encoder().convert(response.bodyBytes);
        });
      }
    })();
  }

  void openPicker({
    required BuildContext context,
    required List<String> options,
    required String value,
    required Function(String) onSelected,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => BottomPicker(
        options: options,
        value: value,
        onSelected: onSelected,
      ),
    );
  }

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: GetBuilder<HomePageController>(builder: (context) {
        return RefreshIndicator(
          color: gradient.defoultColor,
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 2),
              () {
                homePageController.getHomeDataApi();
              },
            );
          },
          child: homePageController.isLoading
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 35,
                                      width: 35,
                                      child:
                                          // networkimage != ""
                                          //     ? ClipRRect(
                                          //         borderRadius:
                                          //             BorderRadius.circular(80),
                                          //         child: Image.network(
                                          //           "${Config.imageUrl}${networkimage ?? ""}",
                                          //           fit: BoxFit.cover,
                                          //         ),
                                          //       )
                                          //     :
                                          CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: Get.height / 17,
                                        child: Image.asset(
                                          "assets/profile-default.png",
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hello",
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 14,
                                          color: greytext,
                                        ),
                                      ),
                                      Text(
                                        isLogin != null
                                            ? getData.read("UserLogin")["name"]
                                            : "Guest",
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 14,
                                          color: BlackColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/new_logo.png",
                                  height: 50,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: 70,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.all(16.0),
                          height: 140,
                          width: Get.width,
                          child: CarouselSlider(
                            items: homePageController.banners.map((elem) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      '${Config.imageUrl}${elem['image']}',
                                ),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              disableCenter: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: homePageController.banners.map((url) {
                            int index = homePageController.banners.indexOf(url);
                            return Container(
                              width: 24.0,
                              height: 4.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: _currentIndex == index
                                    ? Colors.blueAccent
                                    : Colors.grey,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "We Can Help to Find it".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                color: BlackColor,
                                fontSize: 17,
                              ),
                            ),
                            Spacer(),
                            // TextButton(
                            //   onPressed: () {
                            //     Get.to(LatestEvent(eventStaus: "1"));
                            //   },
                            //   child: Text(
                            //     "See All".tr,
                            //     style: TextStyle(
                            //       fontFamily: FontFamily.gilroyMedium,
                            //       color: gradient.defoultColor,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          width: Get.size.width,
                          child: Row(
                            children: [
                              ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 10,
                                ),
                                itemCount: homePageController
                                    .homeInfo!.homeData.catlist.length,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // homePageController.getCatWiseEvent(
                                      //   index,
                                      //   catId: homePageController
                                      //       .homeInfo?.homeData.catlist[index].id,
                                      // );
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 60,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          CachedNetworkImage(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.contain,
                                            imageUrl:
                                                "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[index].catImg}",
                                          ),
                                          Text(
                                            '${homePageController.homeInfo?.homeData.catlist[index].title}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              fontSize: 12,
                                              color: BlackColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        homePageController
                                .homeInfo!.homeData.latestEvent.isNotEmpty
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "The Best Offers For You".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: BlackColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Spacer(),
                                  // TextButton(
                                  //   onPressed: () {
                                  //     Get.to(LatestEvent(eventStaus: "1"));
                                  //   },
                                  //   child: Text(
                                  //     "See All".tr,
                                  //     style: TextStyle(
                                  //       fontFamily: FontFamily.gilroyMedium,
                                  //       color: gradient.defoultColor,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )
                            : SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        homePageController
                                .homeInfo!.homeData.latestEvent.isNotEmpty
                            ? SizedBox(
                                width: Get.size.width,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: homePageController
                                      .homeInfo!.homeData.latestEvent.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        // await eventDetailsController
                                        //     .getEventData(
                                        //   eventId: homePageController
                                        //       .homeInfo!
                                        //       .homeData
                                        //       .latestEvent[index]
                                        //       .eventId,
                                        // );
                                        Get.to(() => OfferDetailScreen());
                                        // Get.toNamed(
                                        //   Routes.eventDetailsScreen,
                                        //   arguments: {
                                        //     "eventId": homePageController
                                        //         .homeInfo!
                                        //         .homeData
                                        //         .latestEvent[index]
                                        //         .eventId,
                                        //     "bookStatus": "1"
                                        //   },
                                        // );
                                      },
                                      child: Container(
                                        height: 340,
                                        width: 260,
                                        margin: const EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 340,
                                                width: 260,
                                                child: FadeInImage.assetNetwork(
                                                  fadeInCurve:
                                                      Curves.easeInCirc,
                                                  placeholder:
                                                      "assets/ezgif.com-crop.gif",
                                                  height: 320,
                                                  width: 240,
                                                  placeholderCacheHeight: 320,
                                                  placeholderCacheWidth: 240,
                                                  placeholderFit: BoxFit.fill,
                                                  // placeholderScale: 1.0,
                                                  image:
                                                      "${Config.imageUrl}${homePageController.homeInfo!.homeData.latestEvent[index].eventImg}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    stops: [0.6, 0.8, 1.5],
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.5),
                                                      Colors.black
                                                          .withOpacity(0.5),
                                                    ],
                                                  ),
                                                  //border: Border.all(color: lightgrey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: WhiteColor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: gradient.defoultColor,
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: gradient.defoultColor,
                  ),
                ),
        );
      }),
    );
  }
}
