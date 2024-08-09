// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, unnecessary_brace_in_string_interps, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_new, prefer_final_fields, non_constant_identifier_names, unnecessary_null_comparison, unused_element

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:ticket_widget/ticket_widget.dart';

import 'package:magicmate/controller/bookevent_controller.dart';
import 'package:magicmate/controller/mybooking_controller.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/model/mtticket_info.dart';
import 'package:magicmate/screen/home_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class MyTicketDetailsScreen extends StatefulWidget {
  const MyTicketDetailsScreen({super.key});

  @override
  State<MyTicketDetailsScreen> createState() => _MyTicketDetailsScreenState();
}

class _MyTicketDetailsScreenState extends State<MyTicketDetailsScreen> {
  MyBookingController myBookingController = Get.find();
  GlobalKey _globalKey = GlobalKey();
  Uint8List? imageInMemory;
  String? imagePath;
  File? capturedFile;

  @override
  void initState() {
    super.initState();
    Get.find<MyBookingController>().imageLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradient.defoultColor.withOpacity(.3),
      appBar: AppBar(
        backgroundColor: blackColor30,
        elevation: 0,
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
          color: WhiteColor,
        ),
        centerTitle: true,
        title: Text(
          "E-Ticket".tr,
          style: TextStyle(
            fontFamily: FontFamily.gilroyBold,
            fontSize: 15,
            color: WhiteColor,
          ),
        ),
      ),
      bottomNavigationBar: GetBuilder<MyBookingController>(
        builder: (context) {
          return myBookingController.status != "Past"
              ? GestButton(
                  height: 50,
                  Width: Get.size.width,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  buttoncolor: gradient.defoultColor,
                  buttontext: "Download Ticket".tr,
                  style: TextStyle(
                    color: WhiteColor,
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 15,
                  ),
                  onclick: () async {
                    if (myBookingController.imageLoaded) {
                      _capturePng();
                    }
                  },
                )
              : myBookingController.status == "Past"
                  ? myBookingController.myTicketInfo?.ticketData.ticketRate !=
                              "1" &&
                          myBookingController
                                  .myTicketInfo?.ticketData.ticketStatus !=
                              "Cancelled"
                      ? GestButton(
                          height: 50,
                          Width: Get.size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          buttoncolor: gradient.defoultColor,
                          buttontext: "Review".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 15,
                          ),
                          onclick: () async {
                            reviewSheet();
                          },
                        )
                      : SizedBox()
                  : SizedBox();
        },
      ),
      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: GetBuilder<MyBookingController>(builder: (context) {
          return myBookingController.isLoading
              ? SingleChildScrollView(
                  child: RepaintBoundary(
                    key: _globalKey,
                    child: Center(
                      child: Center(
                        child: TicketWidget(
                          width: 350,
                          height: 600,
                          margin: EdgeInsets.only(top: 40),
                          isCornerRounded: true,
                          padding: EdgeInsets.all(20),
                          child: TicketData(
                              myTicketInfo: myBookingController.myTicketInfo,
                              myBookingController: myBookingController),
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: gradient.defoultColor,
                  ),
                );
        }),
      ),
    );
  }

  ticketText({String? title, subtitle}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title!,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 14,
                color: greytext,
              ),
            ),
            Spacer(),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 14,
                color: BlackColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
      ],
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  Future _capturePng() async {
    try {
      await [Permission.storage].request();
      print('inside');
      RenderRepaintBoundary boundary = _globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
//create file
      final String dir = (await getApplicationDocumentsDirectory()).path;
      imagePath = '$dir/ticket${DateTime.now()}.png';
      capturedFile = File(imagePath!);
      await capturedFile!.writeAsBytes(pngBytes);
      print(capturedFile!.path);
      final result = await ImageGallerySaver.saveImage(pngBytes,
          quality: 60, name: "ticket${DateTime.now()}");
      print(result);
      await convertImageToPdf(pngBytes, "ticket${DateTime.now()}");

      print('png done');
      showToastMessage("Image saved in gallery");
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  Future<void> convertImageToPdf(Uint8List imageBytes, String fileName) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final output = await getTemporaryDirectory();
    final file = File('$dir/ticket${DateTime.now()}.pdf');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  Future reviewSheet() {
    return Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: 520,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Leave a Review".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: greytext,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "How was your experience".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontFamily: FontFamily.gilroyBold,
                color: BlackColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RatingBar(
              initialRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Image.asset(
                  'assets/starBold.png',
                  color: gradient.defoultColor,
                ),
                half: Image.asset(
                  'assets/star-half.png',
                  color: gradient.defoultColor,
                ),
                empty: Image.asset(
                  'assets/star.png',
                  color: gradient.defoultColor,
                ),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                myBookingController.totalRateUpdate(rating);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: greytext,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                "Write Your Review".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.gilroyBold,
                  color: BlackColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: TextFormField(
                controller: myBookingController.ratingText,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: BlackColor,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Your review here...".tr,
                  hintStyle: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 15,
                  ),
                ),
                style: TextStyle(
                  fontFamily: FontFamily.gilroyMedium,
                  fontSize: 16,
                  color: BlackColor,
                ),
              ),
              decoration: BoxDecoration(
                color: WhiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Divider(
                color: greytext,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Maybe Later".tr,
                        style: TextStyle(
                          color: blueColor,
                          fontFamily: FontFamily.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFeef4ff),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      myBookingController.orderReviewApi(
                          orderID: myBookingController
                              .myTicketInfo?.ticketData.ticketId);
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Submit".tr,
                        style: TextStyle(
                          color: WhiteColor,
                          fontFamily: FontFamily.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: gradient.btnGradient,
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}

getCurrentTextDirection() {
  return Get.locale?.languageCode == 'ar' || Get.locale?.languageCode == 'he'
      ? true
      : false;
}

class TicketData extends StatelessWidget {
  MyTicketInfo? myTicketInfo;
  MyBookingController myBookingController;
  TicketData({
    Key? key,
    required this.myTicketInfo,
    required this.myBookingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Offer Ticket'.tr,
            style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, right: 52.0),
                child: ticketDetailsWidget(
                  'Name'.tr,
                  myTicketInfo?.ticketData.ticketUsername ?? "",
                  'Date'.tr,
                  myTicketInfo?.ticketData.startTime ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget(
                    'Organizer'.tr,
                    myTicketInfo?.ticketData.sponsoreTitle ?? "",
                    'Offer'.tr,
                    myTicketInfo?.ticketData.ticketTitle ?? ""),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: ticketDetailsWidget(
                    'Location'.tr,
                    myTicketInfo?.ticketData.eventAddressTitle ?? "",
                    'Seats'.tr,
                    myTicketInfo?.ticketData.totalTicket ?? ""),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Payable Amount".tr,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: FontFamily.gilroyMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          myTicketInfo?.ticketData.tickectInHandPay ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: FontFamily.gilroyMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
          child: Center(
            child: Image.network(
              "${myTicketInfo?.ticketData.qrcode}",
              height: 200,
              width: 200,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  myBookingController.imageLoaded = true;
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                myTicketInfo?.ticketData.uniqueCode ?? "",
                style: TextStyle(
                  fontFamily: FontFamily.gilroyMedium,
                  color: BlackColor,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(
                    new ClipboardData(
                      text: myTicketInfo?.ticketData.uniqueCode ?? "",
                    ),
                  );
                  showToastMessage("Copy");
                },
                child: Image.asset(
                  "assets/copypng.png",
                  height: 20,
                  width: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: FontFamily.gilroyMedium, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                firstDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: FontFamily.gilroyMedium, color: Colors.black),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: FontFamily.gilroyMedium, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontFamily: FontFamily.gilroyMedium, color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}

class TicketPainter extends CustomPainter {
  final Color borderColor;
  final Color bgColor;

  static const _cornerGap = 20.0;
  static const _cutoutRadius = 20.0;
  static const _cutoutDiameter = _cutoutRadius * 2;

  TicketPainter({required this.bgColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = size.width;
    final maxHeight = size.height;

    final cutoutStartPos = maxHeight - maxHeight * 0.29;
    final leftCutoutStartY = cutoutStartPos;
    final rightCutoutStartY = cutoutStartPos - _cutoutDiameter;
    final dottedLineY = cutoutStartPos - _cutoutRadius;
    double dottedLineStartX = _cutoutRadius;
    final double dottedLineEndX = maxWidth - _cutoutRadius;
    const double dashWidth = 8.5;
    const double dashSpace = 4;

    final paintBg = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..color = bgColor;

    final paintBorder = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = borderColor;

    final paintDottedLine = Paint()
      ..color = borderColor.withOpacity(0.5)
      ..strokeWidth = 1.2;

    var path = Path();

    path.moveTo(_cornerGap, 0);
    path.lineTo(maxWidth - _cornerGap, 0);
    _drawCornerArc(path, maxWidth, _cornerGap);
    path.lineTo(maxWidth, rightCutoutStartY);
    _drawCutout(path, maxWidth, rightCutoutStartY + _cutoutDiameter);
    path.lineTo(maxWidth, maxHeight - _cornerGap);
    _drawCornerArc(path, maxWidth - _cornerGap, maxHeight);
    path.lineTo(_cornerGap, maxHeight);
    _drawCornerArc(path, 0, maxHeight - _cornerGap);
    path.lineTo(0, leftCutoutStartY);
    _drawCutout(path, 0.0, leftCutoutStartY - _cutoutDiameter);
    path.lineTo(0, _cornerGap);
    _drawCornerArc(path, _cornerGap, 0);

    canvas.drawPath(path, paintBg);
    canvas.drawPath(path, paintBorder);

    while (dottedLineStartX < dottedLineEndX) {
      canvas.drawLine(
        Offset(dottedLineStartX, dottedLineY),
        Offset(dottedLineStartX + dashWidth, dottedLineY),
        paintDottedLine,
      );
      dottedLineStartX += dashWidth + dashSpace;
    }
  }

  _drawCutout(Path path, double startX, double endY) {
    path.arcToPoint(
      Offset(startX, endY),
      radius: const Radius.circular(_cutoutRadius),
      clockwise: false,
    );
  }

  _drawCornerArc(Path path, double endPointX, double endPointY) {
    path.arcToPoint(
      Offset(endPointX, endPointY),
      radius: const Radius.circular(_cornerGap),
    );
  }

  @override
  bool shouldRepaint(TicketPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(TicketPainter oldDelegate) => false;
}


      //  Container(
      //                       width: Get.size.width,
      //                       padding: EdgeInsets.all(15),
      //                       child: Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           SizedBox(
      //                             height: 8,
      //                           ),
      //                           SizedBox(
      //                             height: 8,
      //                           ),
      //                           Text(
      //                             "Offer".tr,
      //                             style: TextStyle(
      //                               color: greytext,
      //                               fontFamily: FontFamily.gilroyMedium,
      //                               fontSize: 14,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 5,
      //                           ),
      //                           Text(
      //                             myBookingController.myTicketInfo?.ticketData
      //                                     .ticketTitle ??
      //                                 "",
      //                             style: TextStyle(
      //                               color: BlackColor,
      //                               fontFamily: FontFamily.gilroyBold,
      //                               fontSize: 15,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 15,
      //                           ),
      //                           Text(
      //                             "Event Location".tr,
      //                             style: TextStyle(
      //                               color: greytext,
      //                               fontFamily: FontFamily.gilroyMedium,
      //                               fontSize: 14,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 5,
      //                           ),
      //                           Text(
      //                             myBookingController.myTicketInfo?.ticketData
      //                                     .eventAddressTitle ??
      //                                 "",
      //                             style: TextStyle(
      //                               color: BlackColor,
      //                               fontFamily: FontFamily.gilroyBold,
      //                               fontSize: 15,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 15,
      //                           ),
      //                           Text(
      //                             "Event Organizer".tr,
      //                             style: TextStyle(
      //                               color: greytext,
      //                               fontFamily: FontFamily.gilroyMedium,
      //                               fontSize: 14,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             height: 5,
      //                           ),
      //                           Text(
      //                             myBookingController.myTicketInfo?.ticketData
      //                                     .sponsoreTitle ??
      //                                 "",
      //                             style: TextStyle(
      //                               color: BlackColor,
      //                               fontFamily: FontFamily.gilroyBold,
      //                               fontSize: 15,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       decoration: BoxDecoration(
      //                         color: WhiteColor,
      //                         borderRadius: BorderRadius.circular(15),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                     Container(
      //                       width: Get.size.width,
      //                       padding: EdgeInsets.all(15),
      //                       child: Column(
      //                         children: [
      //                           ticketText(
      //                               title: "Full Name".tr,
      //                               subtitle: myBookingController.myTicketInfo
      //                                   ?.ticketData.ticketUsername),
      //                           ticketText(
      //                               title: "Phone".tr,
      //                               subtitle: myBookingController
      //                                   .myTicketInfo?.ticketData.ticketMobile),
      //                           ticketText(
      //                               title: "Email".tr,
      //                               subtitle: myBookingController
      //                                   .myTicketInfo?.ticketData.ticketEmail),
      //                           ticketText(
      //                               title:
      //                                   "${myBookingController.myTicketInfo?.ticketData.totalTicket} ${"Seats".tr}",
      //                               subtitle:
      //                                   "${currency}${myBookingController.myTicketInfo?.ticketData.ticketSubtotal}"),
      //                           ticketText(
      //                               title: "Tax".tr,
      //                               subtitle:
      //                                   "${currency}${myBookingController.myTicketInfo?.ticketData.ticketTax}"),
      //                           myBookingController.myTicketInfo?.ticketData
      //                                       .ticketCouAmt !=
      //                                   "0"
      //                               ? ticketText(
      //                                   title: "Coupon".tr,
      //                                   subtitle:
      //                                       "${currency}${myBookingController.myTicketInfo?.ticketData.ticketCouAmt}")
      //                               : SizedBox(),
      //                           myBookingController.myTicketInfo?.ticketData
      //                                       .ticketWallAmt !=
      //                                   "0"
      //                               ? ticketText(
      //                                   title: "Wallet".tr,
      //                                   subtitle:
      //                                       "${currency}${myBookingController.myTicketInfo?.ticketData.ticketWallAmt}")
      //                               : SizedBox(),
      //                           ticketText(
      //                               title: "Total".tr,
      //                               subtitle: currency +
      //                                   myBookingController.myTicketInfo
      //                                       ?.ticketData.ticketTotalAmt),
      //                           ticketText(
      //                               title: "Payment Method".tr,
      //                               subtitle: myBookingController.myTicketInfo
      //                                   ?.ticketData.ticketPMethod),
      //                           ticketText(
      //                               title: "In Hand Pay".tr,
      //                               subtitle: myBookingController.myTicketInfo
      //                                   ?.ticketData.tickectInHandPay
      //                                   .toString()),
      //                           myBookingController.myTicketInfo?.ticketData
      //                                       .ticketTransactionId !=
      //                                   "0"
      //                               ? ticketText(
      //                                   title: "Transaction ID".tr,
      //                                   subtitle: myBookingController
      //                                       .myTicketInfo
      //                                       ?.ticketData
      //                                       .ticketTransactionId)
      //                               : SizedBox(),
      //                           myBookingController.myTicketInfo?.ticketData
      //                                       .ticketStatus ==
      //                                   "Cancelled"
      //                               ? ticketText(
      //                                   title: "Ticket Status".tr,
      //                                   subtitle: myBookingController
      //                                       .myTicketInfo
      //                                       ?.ticketData
      //                                       .ticketStatus)
      //                               : SizedBox(),
      //                         ],
      //                       ),
      //                       decoration: BoxDecoration(
      //                         color: WhiteColor,
      //                         borderRadius: BorderRadius.circular(20),
      //                       ),
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),