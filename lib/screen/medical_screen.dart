import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/controller/home_controller.dart';
import 'package:magicmate/helpar/rating_bar.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/screen/organizer%20details/organizer_Information.dart';
import 'package:magicmate/screen/provider_details.dart';
import 'package:magicmate/screen/searchevent_screen.dart';
import 'package:magicmate/utils/Colors.dart';

class MedicalScreen extends StatefulWidget {
  const MedicalScreen({super.key});

  @override
  State<MedicalScreen> createState() => _MedicalScreenState();
}

class _MedicalScreenState extends State<MedicalScreen> {
  HomePageController homePageController = Get.find();
  EventDetailsController eventDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: GetBuilder<HomePageController>(builder: (context) {
        return SafeArea(
            child: SingleChildScrollView(
          child: Column(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "We Can Help to Find it".tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        color: BlackColor,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: gradient.defoultColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: gradient.defoultColor,
                                  blurRadius: 1,
                                )
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: const Icon(
                            Icons.search,
                            size: 28,
                            color: Colors.white,
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 45,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Search...".tr,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: Colors.grey.shade500,
                            ),
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
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: Get.size.width,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        homePageController.getCatWiseProvider(
                          -1,
                          catId: '',
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: homePageController.selectedIndex == -1
                              ? gradient.defoultColor
                              : WhiteColor,
                        ),
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(
                            'All',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              fontSize: 14,
                              color: homePageController.selectedIndex == -1
                                  ? WhiteColor
                                  : BlackColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount:
                          homePageController.homeInfo!.homeData.catlist.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            homePageController.getCatWiseProvider(
                              index,
                              catId: homePageController
                                  .homeInfo?.homeData.catlist[index].id,
                            );
                          },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 60.0,
                            ),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: homePageController.selectedIndex == index
                                    ? gradient.defoultColor
                                    : WhiteColor,
                              ),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                '${homePageController.homeInfo?.homeData.catlist[index].title}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyMedium,
                                  fontSize: 14,
                                  color:
                                      homePageController.selectedIndex == index
                                          ? WhiteColor
                                          : BlackColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              homePageController.providers.isNotEmpty
                  ? ListView.builder(
                      itemCount: homePageController.providers.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            // await eventDetailsController.getEventData(
                            //   eventId: homePageController.providers[index]['id'],
                            // );
                            // Get.toNamed(
                            //   Routes.eventDetailsScreen,
                            //   arguments: {
                            //     "eventId": homePageController.providers[index]['id'],
                            //     "bookStatus": "1",
                            //   },
                            // );
                            Get.to(
                              ProviderDetails(
                                providerInfo:
                                    homePageController.providers[index],
                              ),
                            );
                          },
                          child: Container(
                            height: 140,
                            width: Get.size.width,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  child: Container(
                                    height: 120,
                                    width: 100,
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
                                        placeholder:
                                            "assets/ezgif.com-crop.gif",
                                        height: 120,
                                        image:
                                            "${Config.imageUrl}${homePageController.providers[index]['image'] ?? ""}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        homePageController.providers[index]
                                                ['title'] ??
                                            "",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 15,
                                          color: BlackColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        homePageController.providers[index]
                                                    ['start_time'] +
                                                '-' +
                                                homePageController
                                                        .providers[index]
                                                    ['end_time'] ??
                                            "",
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontFamily: FontFamily.gilroyMedium,
                                          color: gradient.defoultColor,
                                          fontSize: 14,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      RatingBar(rating: 0.0),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Get.size.width * 0.48,
                                            child: Text(
                                              homePageController
                                                          .providers[index]
                                                      ['description'] ??
                                                  "",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 14,
                                                color: BlackColor,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
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
                      child: CircularProgressIndicator(
                        color: gradient.defoultColor,
                      ),
                    ),
            ],
          ),
        ));
      }),
    );
  }
}
