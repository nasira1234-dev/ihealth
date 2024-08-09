import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/controller/org_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/seeAll/gallery_view.dart';
import 'package:magicmate/screen/seeAll/video_view.dart';
import 'package:magicmate/screen/videopreview_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  EventDetailsController eventDetailsController = Get.find();
  OrgController orgController = Get.find();

  String eventId = Get.arguments["eventId"];
  String bookStatus = Get.arguments["bookStatus"];
  // late GoogleMapController
  //     mapController; //contrller for Google map //markers for google map
  // LatLng showLocation = LatLng(27.7089427, 85.3086209);

  // final List<Marker> _markers = <Marker>[];

  // Future<Uint8List> getImages(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetHeight: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  loadData() async {
    // final Uint8List markIcons = await getImages("assets/MapPin.png", 50);
    // // makers added according to index
    // _markers.add(
    //   Marker(
    //     // given marker id
    //     markerId: MarkerId(showLocation.toString()),
    //     // given marker icon
    //     icon: BitmapDescriptor.fromBytes(markIcons),
    //     // given position
    //     position: LatLng(
    //       double.parse(
    //           eventDetailsController.eventInfo?.eventData.eventLatitude ?? ""),
    //       double.parse(
    //           eventDetailsController.eventInfo?.eventData.eventLongtitude ??
    //               ""),
    //     ),
    //     infoWindow: InfoWindow(),
    //   ),
    // );
    // setState(() {});
  }

  bool isShow = false;
  @override
  void initState() {
    super.initState();
    loadData();
    isShow = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      bottomNavigationBar: GetBuilder<EventDetailsController>(
        builder: (context) {
          return bookStatus == "1"
              ? eventDetailsController.eventInfo?.eventData.totalBookTicket !=
                      eventDetailsController.eventInfo?.eventData.totalTicket
                  ? GestButton(
                      height: 50,
                      Width: Get.size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      buttoncolor: gradient.defoultColor,
                      buttontext: "Book Now".tr,
                      style: TextStyle(
                        color: WhiteColor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 15,
                      ),
                      onclick: () {
                        eventDetailsController.getEventTicket(eventId: eventId);
                        Get.toNamed(Routes.tikitDetailsScreen);
                      },
                    )
                  : const SizedBox()
              : const SizedBox();
        },
      ),
      body: GetBuilder<EventDetailsController>(builder: (context) {
        return eventDetailsController.isLoading
            ? CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(7),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back,
                          color: WhiteColor,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF000000).withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      bookStatus == "1"
                          ? eventDetailsController
                                      .eventInfo?.eventData.isBookmark !=
                                  1
                              ? InkWell(
                                  onTap: () {
                                    eventDetailsController.getFavAndUnFav(
                                        eventID: eventId);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(7),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/Love.png",
                                      color: WhiteColor,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF000000).withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    eventDetailsController.getFavAndUnFav(
                                        eventID: eventId);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(9),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/Fev-Bold.png",
                                      color: gradient.defoultColor,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF000000).withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                          : SizedBox(),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                    expandedHeight: Get.height * 0.29,
                    bottom: PreferredSize(
                      child: Container(),
                      preferredSize: Size(0, 20),
                    ),
                    flexibleSpace: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: Get.height * 0.34,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: transparent,
                            ),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: Get.size.height / 3,
                                viewportFraction: 1,
                                autoPlay: true,
                              ),
                              items: eventDetailsController
                                          .eventInfo?.eventData.eventCoverImg !=
                                      []
                                  ? eventDetailsController
                                      .eventInfo?.eventData.eventCoverImg
                                      .map<Widget>((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: Get.size.width,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    "assets/ezgif.com-crop.gif",
                                                fit: BoxFit.cover,
                                                image: Config.imageUrl + i),
                                          );
                                        },
                                      );
                                    }).toList()
                                  : [].map<Widget>((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: 100,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 1),
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent),
                                            child: Image.network(
                                              Config.imageUrl + i,
                                              fit: BoxFit.fill,
                                            ),
                                          );
                                        },
                                      );
                                    }).toList(),
                              // ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 15,
                            decoration: BoxDecoration(
                              color: WhiteColor,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        eventDetailsController.eventInfo
                                                ?.eventData.eventTitle ??
                                            "",
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 18,
                                          color: BlackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: Get.size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: bgcolor,
                                      ),
                                      child: Image.asset(
                                        "assets/Calendar.png",
                                        color: gradient.defoultColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            eventDetailsController.eventInfo
                                                    ?.eventData.eventSdate ??
                                                "",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            eventDetailsController.eventInfo
                                                    ?.eventData.eventTimeDay ??
                                                "",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: greytext,
                                              fontSize: 13,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: Get.size.width,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: bgcolor,
                                      ),
                                      child: Image.asset(
                                        "assets/Location2.png",
                                        color: gradient.defoultColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            eventDetailsController.eventInfo
                                                    ?.eventData.eventAddress ??
                                                "",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await openMap(
                                          double.parse(eventDetailsController
                                                  .eventInfo
                                                  ?.eventData
                                                  .eventLatitude ??
                                              ""),
                                          double.parse(eventDetailsController
                                                  .eventInfo
                                                  ?.eventData
                                                  .eventLongtitude ??
                                              ""),
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/mapIcons.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 50,
                                width: Get.size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      padding: EdgeInsets.all(12),
                                      child: Image.asset(
                                        "assets/ticketIcon.png",
                                        color: gradient.defoultColor,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: bgcolor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            eventDetailsController.eventInfo
                                                    ?.eventData.ticketPrice ??
                                                "",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Ticket price ".tr,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: greytext,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            eventDetailsController.eventInfo
                                                    ?.eventData.rPrice ??
                                                "",
                                            style: TextStyle(
                                              fontFamily: FontFamily.gilroyBold,
                                              color: BlackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Reservation price ".tr,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: greytext,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Text(
                                    //   "${int.parse(eventDetailsController.eventInfo?.eventData.totalTicket.toString() ?? "0") - int.parse(eventDetailsController.eventInfo?.eventData.totalBookTicket.toString() ?? "0")} spots left",
                                    //   style: TextStyle(
                                    //     fontFamily: FontFamily.gilroyBold,
                                    //     color: Color(0xFFFF5E4E),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Description".tr,
                                  style: const TextStyle(
                                    fontFamily: FontFamily.gilroyBold,
                                    fontSize: 14,
                                    color: gradient.defoultColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 10, right: 15),
                                child: HtmlWidget(
                                  eventDetailsController
                                          .eventInfo?.eventData.eventAbout ??
                                      "",
                                  textStyle: TextStyle(
                                    color: BlackColor,
                                    fontSize: 15,
                                    fontFamily: FontFamily.gilroyMedium,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isShow = !isShow;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Terms & Condition".tr,
                                        style: const TextStyle(
                                          fontFamily: FontFamily.gilroyBold,
                                          fontSize: 14,
                                          color: gradient.defoultColor,
                                        ),
                                      ),
                                      const Icon(Icons.arrow_drop_down_outlined)
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isShow,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  child: HtmlWidget(
                                    eventDetailsController.eventInfo?.eventData
                                            .eventDisclaimer ??
                                        "",
                                    textStyle: TextStyle(
                                      color: BlackColor,
                                      fontSize: 15,
                                      fontFamily: FontFamily.gilroyMedium,
                                    ),
                                  ),
                                ),
                              ),
                              eventDetailsController
                                      .eventInfo!.eventData.infoImg.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: Get.width,
                                        child: FadeInImage.assetNetwork(
                                            placeholder:
                                                "assets/ezgif.com-crop.gif",
                                            fit: BoxFit.cover,
                                            image: Config.imageUrl +
                                                eventDetailsController
                                                    .eventInfo!
                                                    .eventData
                                                    .infoImg),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              eventDetailsController
                                      .eventInfo!.eventGallery.isNotEmpty
                                  ? const SizedBox(
                                      height: 10,
                                    )
                                  : const SizedBox(),
                              eventDetailsController
                                      .eventInfo!.eventGallery.isNotEmpty
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Gallery".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            color: BlackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(GalleryView());
                                          },
                                          child: Text(
                                            "See All".tr,
                                            style: TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: Color(0xFF6F3DE9),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                              eventDetailsController
                                      .eventInfo!.eventGallery.isNotEmpty
                                  ? SizedBox(
                                      height: 100,
                                      width: Get.size.width,
                                      child: ListView.builder(
                                        itemCount: eventDetailsController
                                            .eventInfo?.eventGallery.length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                FullScreenImage(
                                                  imageUrl:
                                                      "${Config.imageUrl}${eventDetailsController.eventInfo!.eventGallery[index]}",
                                                  tag: "generate_a_unique_tag",
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              margin: const EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    offset: const Offset(
                                                      0.5,
                                                      0.5,
                                                    ),
                                                    blurRadius: 0.5,
                                                    spreadRadius: 0.5,
                                                  ), //BoxShadow
                                                  const BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(0.0, 0.0),
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      "assets/ezgif.com-crop.gif",
                                                  placeholderFit: BoxFit.cover,
                                                  image:
                                                      "${Config.imageUrl}${eventDetailsController.eventInfo?.eventGallery[index] ?? ""}",
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                              eventDetailsController.eventInfo!.eventData
                                      .eventVideoUrls.isNotEmpty
                                  ? Row(
                                      children: [
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Video".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.gilroyBold,
                                            color: BlackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(const VideoViewScreen());
                                          },
                                          child: Text(
                                            "See All".tr,
                                            style: const TextStyle(
                                              fontFamily:
                                                  FontFamily.gilroyMedium,
                                              color: Color(0xFF6F3DE9),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              eventDetailsController.eventInfo!.eventData
                                      .eventVideoUrls.isNotEmpty
                                  ? Container(
                                      height: 100,
                                      width: Get.size.width,
                                      child: ListView.builder(
                                        itemCount: eventDetailsController
                                            .eventInfo
                                            ?.eventData
                                            .eventVideoUrls
                                            .length,
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          return eventDetailsController
                                                      .eventInfo
                                                      ?.eventData
                                                      .eventVideoUrls[index] !=
                                                  "null"
                                              ? InkWell(
                                                  onTap: () {
                                                    Get.to(VideoPreviewScreen(
                                                      url: eventDetailsController
                                                                  .eventInfo
                                                                  ?.eventData
                                                                  .eventVideoUrls[
                                                              index] ??
                                                          "",
                                                    ));
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 100,
                                                        width: 100,
                                                        margin: EdgeInsets.only(
                                                            left: 8,
                                                            right: 8,
                                                            bottom: 8),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: FadeInImage
                                                              .assetNetwork(
                                                            placeholder:
                                                                "assets/ezgif.com-crop.gif",
                                                            placeholderCacheHeight:
                                                                100,
                                                            placeholderCacheWidth:
                                                                100,
                                                            placeholderFit:
                                                                BoxFit.cover,
                                                            image: YoutubePlayer
                                                                .getThumbnail(
                                                              videoId: YoutubePlayer.convertUrlToId(
                                                                  eventDetailsController
                                                                          .eventInfo
                                                                          ?.eventData
                                                                          .eventVideoUrls[index] ??
                                                                      "")!,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .shade300,
                                                              offset:
                                                                  const Offset(
                                                                0.5,
                                                                0.5,
                                                              ),
                                                              blurRadius: 0.5,
                                                              spreadRadius: 0.5,
                                                            ), //BoxShadow
                                                            BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              offset:
                                                                  const Offset(
                                                                      0.0, 0.0),
                                                              blurRadius: 0.0,
                                                              spreadRadius: 0.0,
                                                            ), //BoxShadow
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 35,
                                                        left: 35,
                                                        right: 35,
                                                        bottom: 35,
                                                        child: Image.asset(
                                                          "assets/videopush.png",
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : SizedBox();
                                        },
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      }),
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
