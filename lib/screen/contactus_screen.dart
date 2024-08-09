// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  bool from = false;
  ContactScreen({
    Key? key,
    this.from = false,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  TextEditingController subject = TextEditingController();
  TextEditingController mesg = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.from) {
      subject.text = "Contact for event sale".tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: widget.from
          ? AppBar(
              backgroundColor: blackColor30,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: WhiteColor,
                ),
              ),
              title: Text(
                "Sale Event".tr,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: FontFamily.gilroyBold,
                  color: WhiteColor,
                ),
              ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Subject".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 16,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: WhiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: subject,
                cursorColor: BlackColor,
                enabled: !widget.from,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  color: BlackColor,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  hintText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter subject'.tr;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Message".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 16,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: WhiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: mesg,
                maxLines: 20,
                cursorColor: BlackColor,
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 14,
                  color: BlackColor,
                ),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey.shade100),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                  hintText: "",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter message'.tr;
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestButton(
              Width: Get.size.width,
              height: 50,
              buttoncolor: gradient.defoultColor,
              margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
              buttontext: "Send Request".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                color: WhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              onclick: () {
                if (subject.text.isEmpty || mesg.text.isEmpty) {
                  showToastMessage("Please fill all the fields".tr);
                  return;
                }
                showToastMessage("We will contact you shortly!".tr);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Stay Connected".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 14,
                      color: BlackColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.email_outlined,
                        color: gradient.defoultColor,
                      ),
                      Text(
                        "demdsfdsfo@gmail.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          fontSize: 14,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        color: gradient.defoultColor,
                      ),
                      Text(
                        "+9661234567",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          fontSize: 14,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      promotion(
                        image: FontAwesomeIcons.tiktok,
                        url: "https://www.instagram.com/helotokindia/",
                      ),
                      promotion(
                        image: FontAwesomeIcons.instagram,
                        url: "https://www.instagram.com/helotokindia/",
                      ),
                      promotion(
                        image: FontAwesomeIcons.x,
                        url: "https://www.instagram.com/helotokindia/",
                      ),
                      promotion(
                        image: FontAwesomeIcons.whatsapp,
                        url: "https://www.instagram.com/helotokindia/",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class promotion extends StatelessWidget {
  String url;
  IconData image;
  promotion({
    Key? key,
    required this.image,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 30,
      onTap: () {
        launch(url);
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: gradient.defoultColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]),
        padding: EdgeInsets.all(12),
        child: Center(child: FaIcon(image, size: 25.0, color: Colors.white)),
      ),
    );
  }
}
