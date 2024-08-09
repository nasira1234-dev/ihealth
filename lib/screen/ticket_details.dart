// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, must_be_immutable, prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magicmate/controller/eventdetails_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/home_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

var eIndex;

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  EventDetailsController eventDetailsController = Get.find();
  var total = 0.0;
  var handtotal = 0.0;
  int totalTicket = 0;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      preIndex = -1;
      eventDetailsController.mTotal = 0.0;
      eventDetailsController.mHandTotal = 0.0;
      eventDetailsController.totalTicket = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: blackColor30,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Ticket Details".tr,
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 16,
            color: WhiteColor,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: WhiteColor,
        ),
      ),
      bottomNavigationBar: GetBuilder<EventDetailsController>(
        builder: (context) {
          return GestButton(
            height: 50,
            Width: Get.size.width,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            buttoncolor: gradient.defoultColor,
            buttontext:
                "${"PURCHASE".tr} - ${currency}${eventDetailsController.mTotal}",
            style: TextStyle(
              color: WhiteColor,
              fontFamily: FontFamily.gilroyBold,
              fontSize: 15,
            ),
            onclick: () {
              if (eventDetailsController.totalTicket != 0) {
                Get.toNamed(
                  Routes.orderDetailsScreen,
                  arguments: {
                    "total": eventDetailsController.mTotal,
                    "handpay": eventDetailsController.mHandTotal
                  },
                );
              } else {
                showToastMessage("Please Select Your Favorite Ticket!".tr);
              }
            },
          );
        },
      ),
      body: GetBuilder<EventDetailsController>(builder: (context) {
        return eventDetailsController.isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "WHAT TICKETS WOULD YOU LIKE?".tr,
                      style: TextStyle(
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 16,
                        color: BlackColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: eventDetailsController
                            .ticketInfo?.eventTypePrice.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListOfCounter(
                            index: index,
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: gradient.defoultColor,
                ),
              );
      }),
    );
  }
}

class ListOfCounter extends StatefulWidget {
  int? index;
  ListOfCounter({super.key, this.index});

  @override
  State<ListOfCounter> createState() => _ListOfCounterState();
}

int preIndex = -1;

class _ListOfCounterState extends State<ListOfCounter> {
  EventDetailsController eventDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventDetailsController>(builder: (context) {
      return Container(
        height: 120,
        width: Get.size.width,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipPath(
              clipper: OvalRightBorderClipper(),
              child: Container(
                height: 120,
                width: 80,
                alignment: Alignment.center,
                child: Text(
                  preIndex == widget.index
                      ? eventDetailsController.totalTicket.toString()
                      : "0",
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 25,
                    color: eventDetailsController.totalTicket.toString() != "0"
                        ? preIndex != widget.index
                            ? BlackColor
                            : WhiteColor
                        : BlackColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: eventDetailsController.totalTicket.toString() != "0"
                      ? preIndex != widget.index
                          ? Colors.grey.shade200
                          : gradient.defoultColor
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventDetailsController.ticketInfo
                            ?.eventTypePrice[widget.index ?? 0].ticketType ??
                        "",
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 17,
                      color: BlackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    eventDetailsController.ticketInfo
                            ?.eventTypePrice[widget.index ?? 0].description ??
                        "",
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 14,
                      color: BlackColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   "${eventDetailsController.ticketInfo?.eventTypePrice[widget.index ?? 0].remainTicket.toString() ?? ""} ${"spots left".tr}",
                  //   style: TextStyle(
                  //     fontFamily: FontFamily.gilroyBold,
                  //     fontSize: 14,
                  //     color: Color(0xFFFF5E4E),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "x ${currency}${eventDetailsController.ticketInfo?.eventTypePrice[widget.index ?? 0].ticketPrice ?? ""} = ${currency}${eventDetailsController.ticketInfo!.eventTypePrice[widget.index ?? 0].tPrice != "null" ? eventDetailsController.ticketInfo!.eventTypePrice[widget.index ?? 0].tPrice : 0.0}",
                    style: TextStyle(
                      color: gradient.defoultColor,
                      fontFamily: FontFamily.gilroyBold,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 120,
              width: 50,
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (preIndex != widget.index) {
                          setState(() {
                            eventDetailsController.totalTicket = 0;
                          });
                        }
                        if (eventDetailsController.totalTicket <
                            eventDetailsController
                                .ticketInfo!
                                .eventTypePrice[widget.index ?? 0]
                                .remainTicket) {
                          print("<<<<<<<TotalTicket>>>>>>>" +
                              eventDetailsController.totalTicket.toString());
                          eventDetailsController.clearEventTicketData();
                          eventDetailsController.getEventTicketData(
                            ticketId1: eventDetailsController
                                    .ticketInfo
                                    ?.eventTypePrice[widget.index ?? 0]
                                    .typeid ??
                                "",
                            ticketPrice1: eventDetailsController
                                    .ticketInfo
                                    ?.eventTypePrice[widget.index ?? 0]
                                    .ticketPrice ??
                                "",
                            ticketType1: eventDetailsController
                                    .ticketInfo
                                    ?.eventTypePrice[widget.index ?? 0]
                                    .ticketType ??
                                "",
                            totalTicket1: eventDetailsController
                                    .ticketInfo
                                    ?.eventTypePrice[widget.index ?? 0]
                                    .totalTicket
                                    .toString() ??
                                "",
                          );
                          print("-------------<1>preIndex:" +
                              preIndex.toString());
                          if (preIndex != -1) {
                            print("-------------<2>preIndex:" +
                                preIndex.toString());
                            eventDetailsController.ticketInfo!
                                .eventTypePrice[preIndex].tPrice = "null";
                            if (preIndex != widget.index) {
                              print("-------------<3>preIndex:" +
                                  preIndex.toString());
                              eventDetailsController.totalTicket = 0;
                              setState(() {});
                            }
                            setState(() {});
                          }
                          preIndex = widget.index!;
                          print("-------------<4>preIndex:" +
                              preIndex.toString());
                          eventDetailsController.totalTicket++;
                          eventDetailsController.ticketInfo!
                                  .eventTypePrice[widget.index ?? 0].tPrice =
                              "${double.parse(eventDetailsController.ticketInfo?.eventTypePrice[widget.index ?? 0].ticketPrice ?? "") * eventDetailsController.totalTicket}";
                          eventDetailsController.totalTicket =
                              eventDetailsController.totalTicket;
                          eventDetailsController.getTotal(
                            total: double.parse(eventDetailsController
                                .ticketInfo!
                                .eventTypePrice[widget.index ?? 0]
                                .tPrice),
                            handtotal: double.parse(eventDetailsController
                                .ticketInfo!
                                .eventTypePrice[widget.index ?? 0]
                                .ticketHandPrice),
                          );
                          setState(() {});
                        } else {
                          showToastMessage(
                              "${"The maximum number of spots available in the".tr} ${eventDetailsController.ticketInfo!.eventTypePrice[widget.index ?? 0].ticketType} ${"has been reached.".tr}");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: gradient.defoultColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (eventDetailsController.totalTicket > 0) {
                          eventDetailsController.ticketInfo!
                                  .eventTypePrice[widget.index ?? 0].tPrice =
                              "${double.parse(eventDetailsController.ticketInfo!.eventTypePrice[widget.index ?? 0].tPrice) - double.parse(eventDetailsController.ticketInfo?.eventTypePrice[widget.index ?? 0].ticketPrice ?? "")}";
                          eventDetailsController.totalTicket--;
                          eventDetailsController.totalTicket =
                              eventDetailsController.totalTicket;
                          eventDetailsController.getTotal(
                            total: double.parse(eventDetailsController
                                .ticketInfo!
                                .eventTypePrice[widget.index ?? 0]
                                .tPrice),
                            handtotal: double.parse(eventDetailsController
                                .ticketInfo!
                                .eventTypePrice[widget.index ?? 0]
                                .ticketHandPrice),
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.remove,
                          color: gradient.defoultColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.circular(15),
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
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
      );
    });
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 25, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 25, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
