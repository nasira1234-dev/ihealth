// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/home_controller.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/screen/offer_detail.dart';
import 'package:magicmate/utils/Colors.dart';

class ProviderDetails extends StatefulWidget {
  dynamic providerInfo;

  ProviderDetails({
    Key? key,
    this.providerInfo,
  }) : super(key: key);

  @override
  State<ProviderDetails> createState() => _ProviderDetailsState();
}

class _ProviderDetailsState extends State<ProviderDetails> {
  int mainTab = 0;
  HomePageController homePageController = Get.find();

  @override
  void initState() {
    super.initState();
    mainTab = 0;

    loadData();
  }

  void loadData() {
    homePageController.tabIndex = 0;
    homePageController.getPrivedorDetails(widget.providerInfo['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: gradient.defoultColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: gradient.defoultColor,
                  )),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/new_logo.png",
              height: 50,
            ),
          ),
        ),
        body: GetBuilder<HomePageController>(builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black26,
                          )
                        ],
                        color: Colors.white),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  mainTab = 0;
                                });
                              },
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: mainTab == 0
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 2,
                                            color: Colors.black26,
                                          )
                                        ],
                                        color: gradient.defoultColor)
                                    : null,
                                child: Center(
                                  child: Text(
                                    "Information",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      color: mainTab == 0
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: mainTab == 0 ? 22 : 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     setState(() {
                            //       mainTab = 1;
                            //     });
                            //   },
                            //   child: Container(
                            //     height: 40,
                            //     padding:
                            //         const EdgeInsets.symmetric(horizontal: 10),
                            //     decoration: mainTab == 1
                            //         ? BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             boxShadow: const [
                            //               BoxShadow(
                            //                 offset: Offset(0, 2),
                            //                 blurRadius: 2,
                            //                 color: Colors.black26,
                            //               )
                            //             ],
                            //             color: gradient.defoultColor)
                            //         : null,
                            //     child: Center(
                            //       child: Text(
                            //         "Discount",
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //           fontFamily: FontFamily.gilroyMedium,
                            //           color: mainTab == 1
                            //               ? Colors.white
                            //               : Colors.black,
                            //           fontSize: mainTab == 1 ? 22 : 18,
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black26,
                          )
                        ],
                        color: Colors.white),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Container(
                                height: 60,
                                width: 60,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeInImage.assetNetwork(
                                    fadeInCurve: Curves.easeInCirc,
                                    placeholder: "assets/ezgif.com-crop.gif",
                                    height: 120,
                                    image:
                                        "${Config.imageUrl}${widget.providerInfo['image'] ?? ""}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.providerInfo['title'] ?? "",
                              maxLines: 2,
                              style: const TextStyle(
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 20,
                                color: gradient.defoultColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/Location.png",
                                      color: Colors.grey,
                                      height: 20,
                                      width: 20,
                                    ),
                                    const Text(
                                      "location",
                                      style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_outline,
                                    color: Colors.yellow,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.providerInfo['rating'] ?? "0",
                                    style: const TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      fontSize: 20,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 2),
                            blurRadius: 3,
                            color: Colors.black26,
                          )
                        ],
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TabItem(
                              tabIndex: 0,
                              tabName: "Service",
                              controller: context,
                              selected: context.tabIndex == 0),
                          TabItem(
                              tabIndex: 1,
                              tabName: "Offer",
                              controller: context,
                              selected: context.tabIndex == 1),
                          TabItem(
                              tabIndex: 2,
                              controller: context,
                              tabName: "About",
                              selected: context.tabIndex == 2),
                          TabItem(
                              tabIndex: 3,
                              controller: context,
                              tabName: "Evaluation",
                              selected: context.tabIndex == 3),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  homePageController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink(),
                  if (homePageController.tabIndex == 0)
                    homePageController.service.isNotEmpty
                        ? ListView.builder(
                            itemCount: homePageController.service.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  Get.to(() => const OfferDetailScreen());
                                },
                                child: Container(
                                  height: 100,
                                  width: Get.size.width,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: WhiteColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 3,
                                        color: Colors.black26,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 5),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: FadeInImage.assetNetwork(
                                              fadeInCurve: Curves.easeInCirc,
                                              placeholder:
                                                  "assets/ezgif.com-crop.gif",
                                              height: 60,
                                              image:
                                                  "${Config.imageUrl}${homePageController.service[index]['event_img'] ?? ""}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    homePageController
                                                                .service[index]
                                                            ['event_title'] ??
                                                        "",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15,
                                                      color: BlackColor,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    homePageController
                                                                .service[index]
                                                            ['price'] +
                                                        "SA",
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("Empty Data"),
                          ),
                  if (homePageController.tabIndex == 1)
                    homePageController.service.isNotEmpty
                        ? ListView.builder(
                            itemCount: homePageController.offers.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  Get.to(() => const OfferDetailScreen());
                                },
                                child: Container(
                                  height: 100,
                                  width: Get.size.width,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: WhiteColor,
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 3,
                                        color: Colors.black26,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6, horizontal: 5),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(80),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: FadeInImage.assetNetwork(
                                              fadeInCurve: Curves.easeInCirc,
                                              placeholder:
                                                  "assets/ezgif.com-crop.gif",
                                              height: 60,
                                              image:
                                                  "${Config.imageUrl}${homePageController.offers[index]['event_img'] ?? ""}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    homePageController
                                                                .offers[index]
                                                            ['event_title'] ??
                                                        "",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15,
                                                      color: BlackColor,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Text(
                                                    homePageController
                                                                .offers[index]
                                                            ['price'] +
                                                        "SA",
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          FontFamily.gilroyBold,
                                                      fontSize: 15,
                                                      color: Colors.grey,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text("Empty Data"),
                          ),

                   if (homePageController.tabIndex == 2)
                         Container(
                          child: Column(
                            children: [
                              
                            ],
                          ),
                         )        
                ],
              ),
            ),
          );
        }));
  }
}

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.selected,
    required this.tabName,
    required this.tabIndex,
    required this.controller,
  });

  final bool selected;
  final String tabName;
  final int tabIndex;
  final HomePageController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.select(tabIndex);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tabName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontFamily.gilroyMedium,
              color: selected ? gradient.defoultColor : Colors.grey,
              fontSize: selected ? 20 : 16,
            ),
          ),
          selected
              ? Container(
                  height: 3,
                  width: 80,
                  color: gradient.defoultColor,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
