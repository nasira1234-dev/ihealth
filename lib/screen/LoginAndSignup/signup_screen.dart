import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/signup_controller.dart';
import 'package:magicmate/helpar/routes_helpar.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/LoginAndSignup/login_screen.dart';
import 'package:magicmate/screen/bottombar_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpController signUpController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cuntryCode = "+966";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: gradient.bgGradient),
          height: Get.height,
          width: Get.width,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        bool isLoginBack = getData.read('isLoginBack') ?? false;
                        isLoginBack
                            ? Get.toNamed(Routes.bottoBarScreen)
                            : Get.back();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset("assets/180_logo.png"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 350,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        cursorColor: BlackColor,
                                        controller: signUpController.name,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyMedium,
                                          fontSize: 14,
                                          color: BlackColor,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name'.tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          labelText: "Full Name".tr,
                                          labelStyle: TextStyle(
                                              color: greycolor,
                                              fontFamily:
                                                  FontFamily.gilroyMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13,
                                                bottom: 10,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              '🇸🇦+966',
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 14,
                                                color: BlackColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextFormField(
                                              cursorColor: BlackColor,
                                              controller:
                                                  signUpController.number,
                                              keyboardType: TextInputType.phone,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: TextStyle(
                                                fontFamily:
                                                    FontFamily.gilroyMedium,
                                                fontSize: 14,
                                                color: BlackColor,
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your mobile number'
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                labelText: "Mobile Number".tr,
                                                labelStyle: TextStyle(
                                                    color: greycolor,
                                                    fontFamily: FontFamily
                                                        .gilroyMedium),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        cursorColor: BlackColor,
                                        controller: signUpController.idCard,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyMedium,
                                          fontSize: 14,
                                          color: BlackColor,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your ID'.tr;
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          labelText: "National ID".tr,
                                          labelStyle: TextStyle(
                                              color: greycolor,
                                              fontFamily:
                                                  FontFamily.gilroyMedium),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GetBuilder<SignUpController>(
                                      builder: (context) {
                                    return InkWell(
                                      onTap: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context.setUserApiData("+966");
                                          // Get.offAll(BottomBarScreen());
                                          // showToastMessage(context.signUpMsg);
                                          // signUpController
                                          //     .checkMobileNumber(cuntryCode);
                                        }
                                      },
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            color: gradient.defoultColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: gradient.defoultColor,
                                                blurRadius: 1,
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: !context.isLoding
                                            ? const Icon(
                                                Icons.arrow_forward,
                                                size: 32,
                                                color: Colors.white,
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(WhiteColor),
                                                ),
                                              ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Do you have any account ?",
                                    style: TextStyle(
                                      color: WhiteColor,
                                      fontFamily: "NotoKufiArabic Bold",
                                      fontSize: 14,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(LoginScreen());
                                    },
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                        color: WhiteColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                        fontFamily: "NotoKufiArabic Bold",
                                        fontSize: 14,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
