// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unnecessary_string_interpolations, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:magicmate/controller/signup_controller.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/LoginAndSignup/login_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:magicmate/utils/Custom_widget.dart';

class ResetPasswordScreen extends StatelessWidget {
  SignUpController signUpController = Get.find();
  TextEditingController number = TextEditingController();
  String cuntryCode = "+966";
  final _formKey = GlobalKey<FormState>();

  static String verifay = "";

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: Container(
          color: transparent,
          height: Get.height,
          child: Stack(
            children: [
              Container(
                height: Get.height * 0.35,
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.03),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(13),
                            margin: EdgeInsets.all(10),
                            child: Image.asset(
                              'assets/back.png',
                              color: WhiteColor,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF000000).withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.25,
                        ),
                        Text(
                          "Reset Password".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 17,
                            color: WhiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.size.height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyMedium,
                            fontSize: 15,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            " Login Now".tr,
                            style: TextStyle(
                              color: Color(0xFFFBBC04),
                              fontFamily: FontFamily.gilroyBold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Image.asset(
                        "assets/Rectangle326.png",
                        height: 25,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: gradient.btnGradient,
                ),
              ),
              Positioned(
                top: Get.height * 0.22,
                child: Container(
                  height: Get.size.height,
                  width: Get.size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      // SizedBox(
                      //   height: Get.height * 0.005,
                      // ),
                      Text(
                        "Please enter your phone number to request a\npassword reset"
                            .tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: BlackColor,
                          fontFamily: "NotoKufiArabic Medium",
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IntlPhoneField(
                            keyboardType: TextInputType.number,
                            cursorColor: BlackColor,
                            showDropdownIcon: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            countries: const [
                              Country(
                                name: "Saudi Arabia",
                                nameTranslations: {
                                  "sk": "Saudská Arábia",
                                  "se": "Saudi-Arábia",
                                  "pl": "Arabia Saudyjska",
                                  "no": "Saudi-Arabia",
                                  "ja": "サウジアラビア",
                                  "it": "Arabia Saudita",
                                  "zh": "沙特阿拉伯",
                                  "nl": "Saoedi-Arabië",
                                  "de": "Saudi-Arabien",
                                  "fr": "Arabie saoudite",
                                  "es": "Arabia Saudí",
                                  "en": "Saudi Arabia",
                                  "pt_BR": "Arábia Saudita",
                                  "sr-Cyrl": "Саудијска Арабија",
                                  "sr-Latn": "Saudijska Arabija",
                                  "zh_TW": "沙烏地阿拉",
                                  "tr": "Suudi Arabistan",
                                  "ro": "Arabia Saudită",
                                  "ar": "السعودية",
                                  "fa": "عربستان سعودی",
                                  "yue": "沙地阿拉伯"
                                },
                                flag: "🇸🇦",
                                code: "SA",
                                dialCode: "966",
                                minLength: 9,
                                maxLength: 9,
                              ),
                            ],
                            initialCountryCode: 'SA',
                            controller: number,
                            disableLengthCheck: true,
                            onChanged: (value) {
                              cuntryCode = value.countryCode;
                            },
                            onCountryChanged: (value) {
                              number.text = '';
                            },
                            dropdownIcon: Icon(
                              Icons.arrow_drop_down,
                              color: greycolor,
                            ),
                            dropdownTextStyle: TextStyle(
                              color: greycolor,
                            ),
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: BlackColor,
                            ),
                            decoration: InputDecoration(
                              helperText: null,
                              labelText: "Mobile Number".tr,
                              labelStyle: TextStyle(
                                color: greycolor,
                                fontFamily: FontFamily.gilroyMedium,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (p0) {
                              if (p0!.completeNumber.isEmpty) {
                                return 'Please enter your number'.tr;
                              } else {}
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestButton(
                        Width: Get.size.width,
                        height: 50,
                        buttoncolor: gradient.defoultColor,
                        margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                        buttontext: "Request OTP".tr,
                        style: TextStyle(
                          fontFamily: "NotoKufiArabic Bold",
                          color: WhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onclick: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            signUpController.checkMobileInResetPassword(
                                number: number.text, cuntryCode: cuntryCode);
                          }
                        },
                      ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> sendOTP(
  String phonNumber,
  String cuntryCode,
) async {
  // await FirebaseAuth.instance.verifyPhoneNumber(
  //   phoneNumber: '${cuntryCode + phonNumber}',
  //   verificationCompleted: (PhoneAuthCredential credential) {},
  //   verificationFailed: (FirebaseAuthException e) {
  //     print(e.message);
  //   },
  //   timeout: Duration(seconds: 60),
  //   codeSent: (String verificationId, int? resendToken) {
  //     ResetPasswordScreen.verifay = verificationId;
  //   },
  //   codeAutoRetrievalTimeout: (String verificationId) {},
  // );
}
