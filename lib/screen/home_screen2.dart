import 'dart:convert';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:magicmate/screen/LoginAndSignup/login_screen.dart';
import 'package:magicmate/screen/bottom_picker.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/screen/contactus_screen.dart';
import 'package:magicmate/screen/myTicket/myticket_screen.dart';
import 'package:magicmate/screen/searchevent_screen.dart';
import 'package:magicmate/screen/seeAll/latest_event.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:http/http.dart' as http;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
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
                // homePageController.getCatWiseEvent(-1, catId: '');
              },
            );
          },
          child: homePageController.isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(
                    //   child: Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text(
                    //       "Endless Memories",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 130,
                      width: double.infinity,
                      child: AnotherCarousel(
                        borderRadius: true,
                        dotBgColor: Colors.transparent,
                        dotSpacing: 10,
                        dotIncreasedColor: Colors.white,
                        radius: const Radius.circular(2),
                        images: homePageController.banners.map((elem) {
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: '${Config.imageUrl}${elem['image']}',
                          );
                        }).toList(),
                        dotSize: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              openPicker(
                                context: Get.context!,
                                options: ["All", "Riyadh"],
                                value:
                                    selectedCity.isEmpty ? "All" : selectedCity,
                                onSelected: (opt) {
                                  setState(() {
                                    selectedCity = opt;
                                  });
                                  print(selectedCity);
                                },
                              );
                            },
                            child: Container(
                              height: 45,
                              width: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    const Icon(
                                      Icons.location_city,
                                      color: gradient.defoultColor,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                        child: Text(
                                      selectedCity.isEmpty
                                          ? "City".tr
                                          : selectedCity,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        fontSize: 16,
                                        color: BlackColor,
                                      ),
                                    )),
                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: gradient.defoultColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Get.to(const SearchEventScreen());
                              },
                              child: Container(
                                height: 45,
                                margin: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      "assets/Search.png",
                                      height: 25,
                                      color: gradient.defoultColor,
                                      width: 25,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Search...".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 25, top: 10),
                              child: Column(
                                children: [
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.5,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent: 100,
                                    ),
                                    itemCount: (homePageController.homeInfo!
                                            .homeData.reportData.length +
                                        1),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      if (index == 5) {
                                        return InkWell(
                                          onTap: () async {
                                            Get.to(() => ContactScreen(
                                                  from: true,
                                                ));
                                          },
                                          child: Container(
                                            height: 100,
                                            width: Get.size.width,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: WhiteColor,
                                            ),
                                            child: SizedBox(
                                              width: Get.size.width * 0.25,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  // Text(
                                                  //   "Contact",
                                                  //   style: TextStyle(
                                                  //       fontFamily: FontFamily
                                                  //           .gilroyExtraBold,
                                                  //       color: BlackColor,
                                                  //       fontSize: 15),
                                                  // ),

                                                  Container(
                                                    width: 50,
                                                    height: 100,
                                                    decoration:
                                                        const BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/contacts.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          if (index == 0) {
                                            Get.to(
                                                LatestEvent(eventStaus: "1"));
                                          } else if (index == 1) {
                                            Get.to(
                                                LatestEvent(eventStaus: "2"));
                                          } else if (index == 2) {
                                            setState(() {});
                                            if (isLogin != null) {
                                              Get.to(
                                                  () => const MyTicketScreen());
                                            } else {
                                              Get.to(() => LoginScreen());
                                            }
                                          } else if (index == 3) {
                                            setState(() {});
                                            if (isLogin != null) {
                                              Get.find<LoginController>()
                                                  .changeIndex(1);
                                            } else {
                                              Get.to(() => LoginScreen());
                                            }
                                          } else if (index == 4) {
                                            setState(() {});
                                            if (isLogin != null) {
                                              Get.find<LoginController>()
                                                  .changeIndex(3);
                                            } else {
                                              Get.to(() => LoginScreen());
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 100,
                                          width: Get.size.width,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: WhiteColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.size.width * 0.25,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${homePageController.homeInfo?.homeData.reportData[index].reportData ?? ""}",
                                                      style: TextStyle(
                                                          fontFamily: FontFamily
                                                              .gilroyExtraBold,
                                                          color: BlackColor,
                                                          fontSize: 24),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            Get.height * 0.010),
                                                    Text(
                                                      index == 0
                                                          ? "Total offer".tr
                                                          : index == 1
                                                              ? 'Today offer'.tr
                                                              : index == 2
                                                                  ? 'Ticket me'
                                                                      .tr
                                                                  : index == 3
                                                                      ? 'Favorite'
                                                                          .tr
                                                                      : index ==
                                                                              4
                                                                          ? 'Wallet'
                                                                              .tr
                                                                          : '',
                                                      // "${homePageController.homeInfo?.homeData.reportData[index].title ?? ""}",
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                        fontFamily: FontFamily
                                                            .gilroyBold,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              CachedNetworkImage(
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      "${Config.imageUrl}${homePageController.homeInfo?.homeData.reportData[index].url ?? ""}"),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   height: 50,
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   width: Get.size.width,
                    //   child: Row(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           homePageController.getCatWiseEvent(
                    //             -1,
                    //             catId: '',
                    //           );
                    //         },
                    //         child: Container(
                    //           padding: EdgeInsets.all(
                    //               homePageController.selectedIndex == -1
                    //                   ? 3
                    //                   : 0),
                    //           decoration: homePageController.selectedIndex ==
                    //                   -1
                    //               ? BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   border: Border.all(
                    //                       color: gradient.defoultColor),
                    //                 )
                    //               : null,
                    //           child: Container(
                    //             height: 50,
                    //             width: 60,
                    //             alignment: Alignment.center,
                    //             padding: const EdgeInsets.all(8),
                    //             decoration: BoxDecoration(
                    //               color: WhiteColor,
                    //               boxShadow: [
                    //                 BoxShadow(
                    //                   color: BlackColor.withOpacity(0.1),
                    //                   spreadRadius: 1,
                    //                   blurRadius: 1,
                    //                   offset: const Offset(0, 1),
                    //                 ),
                    //               ],
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             child: Text(
                    //               'All',
                    //               textAlign: TextAlign.center,
                    //               style: TextStyle(
                    //                 fontFamily: FontFamily.gilroyMedium,
                    //                 fontSize: 14,
                    //                 color: BlackColor,
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       ListView.separated(
                    //         separatorBuilder: (context, index) =>
                    //             const SizedBox(
                    //           width: 10,
                    //         ),
                    //         itemCount: homePageController
                    //             .homeInfo!.homeData.catlist.length,
                    //         scrollDirection: Axis.horizontal,
                    //         physics: const BouncingScrollPhysics(),
                    //         padding: EdgeInsets.zero,
                    //         shrinkWrap: true,
                    //         itemBuilder: (context, index) {
                    //           return InkWell(
                    //             onTap: () {
                    //               homePageController.getCatWiseEvent(
                    //                 index,
                    //                 catId: homePageController
                    //                     .homeInfo?.homeData.catlist[index].id,
                    //               );
                    //             },
                    //             child: Container(
                    //               padding: EdgeInsets.all(
                    //                   homePageController.selectedIndex ==
                    //                           index
                    //                       ? 3
                    //                       : 0),
                    //               decoration: homePageController
                    //                           .selectedIndex ==
                    //                       index
                    //                   ? BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(10),
                    //                       border: Border.all(
                    //                           color: gradient.defoultColor),
                    //                     )
                    //                   : null,
                    //               child: Container(
                    //                 height: 50,
                    //                 width: 60,
                    //                 alignment: Alignment.center,
                    //                 padding: const EdgeInsets.all(8),
                    //                 decoration: BoxDecoration(
                    //                   color: WhiteColor,
                    //                   boxShadow: [
                    //                     BoxShadow(
                    //                       color: BlackColor.withOpacity(0.1),
                    //                       spreadRadius: 1,
                    //                       blurRadius: 1,
                    //                       offset: const Offset(0, 1),
                    //                     ),
                    //                   ],
                    //                   borderRadius: BorderRadius.circular(10),
                    //                 ),
                    //                 child: Text(
                    //                   '${homePageController.homeInfo?.homeData.catlist[index].title}',
                    //                   textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     fontFamily: FontFamily.gilroyMedium,
                    //                     fontSize: 14,
                    //                     color: BlackColor,
                    //                   ),
                    //                 ),
                    //                 // child: CachedNetworkImage(
                    //                 //   width:
                    //                 //       MediaQuery.of(context).size.width,
                    //                 //   fit: BoxFit.contain,
                    //                 //   imageUrl:
                    //                 //       "${Config.imageUrl}${homePageController.homeInfo?.homeData.catlist[index].catImg}",
                    //                 // ),
                    //               ),
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),

                    // homePageController.catWiseInfo.isNotEmpty
                    //     ? SizedBox(
                    //         width: Get.size.width,
                    //         child: GridView.builder(
                    //           gridDelegate:
                    //               const SliverGridDelegateWithFixedCrossAxisCount(
                    //                   crossAxisCount: 2),
                    //           itemCount:
                    //               homePageController.catWiseInfo.length,
                    //           shrinkWrap: true,
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           itemBuilder: (context, index) {
                    //             return InkWell(
                    //               onTap: () async {
                    //                 await eventDetailsController.getEventData(
                    //                   eventId: homePageController
                    //                       .catWiseInfo[index].eventId,
                    //                 );
                    //                 Get.toNamed(
                    //                   Routes.eventDetailsScreen,
                    //                   arguments: {
                    //                     "eventId": homePageController
                    //                         .catWiseInfo[index].eventId,
                    //                     "bookStatus": "1"
                    //                   },
                    //                 );
                    //               },
                    //               child: Container(
                    //                 height: 340,
                    //                 width: 260,
                    //                 margin: const EdgeInsets.only(
                    //                     left: 10, right: 10, bottom: 10),
                    //                 child: ClipRRect(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   child: Stack(
                    //                     children: [
                    //                       SizedBox(
                    //                         height: 340,
                    //                         width: 260,
                    //                         child: FadeInImage.assetNetwork(
                    //                           fadeInCurve: Curves.easeInCirc,
                    //                           placeholder:
                    //                               "assets/ezgif.com-crop.gif",
                    //                           height: 320,
                    //                           width: 240,
                    //                           placeholderCacheHeight: 320,
                    //                           placeholderCacheWidth: 240,
                    //                           placeholderFit: BoxFit.fill,
                    //                           // placeholderScale: 1.0,
                    //                           image:
                    //                               "${Config.imageUrl}${homePageController.catWiseInfo[index].eventImg}",
                    //                           fit: BoxFit.cover,
                    //                         ),
                    //                       ),
                    //                       Container(
                    //                         decoration: BoxDecoration(
                    //                           gradient: LinearGradient(
                    //                             begin: Alignment.topCenter,
                    //                             end: Alignment.bottomCenter,
                    //                             stops: [0.6, 0.8, 1.5],
                    //                             colors: [
                    //                               Colors.transparent,
                    //                               Colors.black
                    //                                   .withOpacity(0.5),
                    //                               Colors.black
                    //                                   .withOpacity(0.5),
                    //                             ],
                    //                           ),
                    //                           //border: Border.all(color: lightgrey),
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(30),
                    //                   color: WhiteColor,
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       )
                    //     : const Center(
                    //         child: CircularProgressIndicator(
                    //           color: gradient.defoultColor,
                    //         ),
                    //       ),
                  ],
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
