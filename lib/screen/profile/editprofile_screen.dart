// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_brace_in_string_interps, sized_box_for_whitespace, deprecated_member_use, unused_element, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/login_controller.dart';
import 'package:magicmate/controller/pagelist_controller.dart';
import 'package:magicmate/controller/signup_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController idard = TextEditingController();

  LoginController loginController = Get.find();
  SignUpController signUpController = Get.find();
  PageListController pageListController = Get.find();

  String? path;
  String? networkimage;
  String? base64Image;
  final ImagePicker imgpicker = ImagePicker();
  PickedFile? imageFile;
  @override
  void initState() {
    super.initState();
    fname.text;
    getData.read("UserLogin") != null
        ? setState(() {
            fname.text = getData.read("UserLogin")["name"] ?? "";
            number.text = getData.read("UserLogin")["mobile"] ?? "";
            email.text = getData.read("UserLogin")["email"] ?? "";
            networkimage = getData.read("UserLogin")["pro_pic"] ?? "";
            idard.text = getData.read("UserLogin")["idCard"] ?? "";
            networkimage != "null"
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      // appBar: AppBar(
      //   backgroundColor: blackColor30,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: WhiteColor,
      //     ),
      //   ),
      //   title: Text(
      //     "Profile".tr,
      //     style: TextStyle(
      //       fontSize: 17,
      //       fontFamily: FontFamily.gilroyBold,
      //       color: WhiteColor,
      //     ),
      //   ),
      // ),
      body: GetBuilder<SignUpController>(builder: (context) {
        return SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Image.asset(
                  "assets/mood.png",
                  height: 50,
                ),
                SizedBox(
                  height: 5,
                ),
                GetBuilder<LoginController>(builder: (context) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _openGallery(Get.context!);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: path == null
                              ? networkimage != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.network(
                                        "${Config.imageUrl}${networkimage ?? ""}",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: Get.height / 17,
                                      child: Image.asset(
                                        "assets/profile-default.png",
                                        fit: BoxFit.cover,
                                      ),
                                    )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: Image.file(
                                    File(path.toString()),
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: -5,
                        child: InkWell(
                          onTap: () {
                            _openGallery(Get.context!);
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            padding: EdgeInsets.all(7),
                            child: Image.asset(
                              "assets/Edit.png",
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                Text(
                  "Welcome..",
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: greyColor,
                  ),
                ),
                Text(
                  fname.text,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 14,
                    color: BlackColor,
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Get.toNamed(Routes.resetPassword);
                //   },
                //   child: Text(
                //     'Change Password',
                //     style: TextStyle(
                //       fontFamily: FontFamily.gilroyRegular,
                //       fontSize: 14,
                //       decoration: TextDecoration.underline,
                //       color: greyColor,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Full Name',
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyRegular,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: fname,
                          cursorColor: BlackColor,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            hintText: "Full Name".tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Full name'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyRegular,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: email,
                          cursorColor: BlackColor,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            // suffixIcon: Padding(
                            //   padding: const EdgeInsets.all(10),
                            //   child: Image.asset(
                            //     "assets/images/email.png",
                            //     height: 10,
                            //     width: 10,
                            //     color: BlackColor,
                            //   ),
                            // ),
                            hintText: "Email".tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Phone number',
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyRegular,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: Get.size.width,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${getData.read("UserLogin")["ccode"]}",
                            style: TextStyle(
                              color: BlackColor,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${number.text}",
                            style: TextStyle(
                              color: BlackColor,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID Number',
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyRegular,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: idard,
                          cursorColor: BlackColor,
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 14,
                            color: BlackColor,
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            hintText: "ID Number".tr,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Id Number'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 15),
                //       child: Text(
                //         'City',
                //         style: TextStyle(
                //           fontFamily: FontFamily.gilroyRegular,
                //           fontSize: 14,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 5,
                //     ),
                //     Container(
                //       height: 50,
                //       width: Get.size.width,
                //       margin: EdgeInsets.symmetric(horizontal: 15),
                //       padding: EdgeInsets.only(left: 15, right: 15),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             "Other",
                //             style: TextStyle(
                //               color: BlackColor,
                //               fontFamily: 'Gilroy',
                //             ),
                //           ),
                //           Icon(Icons.arrow_drop_down)
                //         ],
                //       ),
                //       decoration: BoxDecoration(
                //         color: Colors.grey.shade300,
                //         borderRadius: BorderRadius.circular(15),
                //         border: Border.all(color: Colors.grey.shade100),
                //       ),
                //     ),
                 
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 15),
                //       child: Text(
                //         'Gender',
                //         style: TextStyle(
                //           fontFamily: FontFamily.gilroyRegular,
                //           fontSize: 14,
                //           color: Colors.grey,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 5,
                //     ),
                //     Container(
                //       height: 50,
                //       width: Get.size.width,
                //       margin: EdgeInsets.symmetric(horizontal: 15),
                //       padding: EdgeInsets.only(left: 15, right: 15),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             "Male",
                //             style: TextStyle(
                //               color: BlackColor,
                //               fontFamily: 'Gilroy',
                //             ),
                //           ),
                //           Icon(Icons.arrow_drop_down)
                //         ],
                //       ),
                //       decoration: BoxDecoration(
                //         color: Colors.grey.shade300,
                //         borderRadius: BorderRadius.circular(15),
                //         border: Border.all(color: Colors.grey.shade100),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: LayoutBuilder(builder: (c, b) {
                    return Wrap(spacing: 10, children: [
                      SizedBox(
                        width: (b.maxWidth / 2) - 5,
                        child: GestButton(
                          Width: Get.size.width,
                          height: 50,
                          buttoncolor: gradient.defoultColor,
                          margin: EdgeInsets.only(top: 15),
                          buttontext: "Update".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          onclick: () {
                            signUpController.editProfileApi(
                              name: fname.text,
                              email: email.text,
                              idCard:idard.text,
                              password: getData.read("UserLogin")["password"],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: (b.maxWidth / 2) - 5,
                        child: GestButton(
                          Width: Get.size.width,
                          height: 50,
                          buttoncolor: Colors.grey,
                          margin: EdgeInsets.only(
                            top: 15,
                          ),
                          buttontext: "Delete".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          onclick: () {
                            deleteSheet();
                          },
                        ),
                      ),
                    ]);
                  }),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future deleteSheet() {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Delete Account".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.gilroyBold,
                color: RedColor,
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
              height: 10,
            ),
            Text(
              "Are you sure you want to delete account?".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 16,
                color: BlackColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Cancle".tr,
                        style: TextStyle(
                          color: gradient.defoultColor,
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
                      pageListController.deletAccount();
                    },
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.center,
                      child: Text(
                        "Yes, Remove".tr,
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
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      path = pickedFile.path;
      setState(() {});
      File imageFile = File(path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      loginController.updateProfileImage(base64Image);
      setState(() {});
    }
  }
}
