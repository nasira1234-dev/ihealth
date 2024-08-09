import 'dart:convert';
import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:magicmate/Api/config.dart';
import 'package:magicmate/Api/data_store.dart';
import 'package:magicmate/controller/login_controller.dart';
import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/screen/LoginAndSignup/login_screen.dart';
import 'package:magicmate/screen/addwallet/wallet_screen.dart';
import 'package:magicmate/screen/contactus_screen.dart';
import 'package:magicmate/screen/favorites/favorites_screen.dart';
import 'package:magicmate/screen/home_screen.dart';
import 'package:magicmate/screen/home_screen2.dart';
import 'package:magicmate/screen/home_screen3.dart';
import 'package:magicmate/screen/map_screen.dart';
import 'package:magicmate/screen/medical_screen.dart';
import 'package:magicmate/screen/myTicket/myticket_screen.dart';
import 'package:magicmate/screen/profile/editprofile_screen.dart';
import 'package:magicmate/screen/profile/profile_screen.dart';
import 'package:magicmate/utils/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

var isLogin;
String userName = "";
String iDNUM = "";

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Widget> myChilders = [
    const HomeScreen3(),
    MedicalScreen(),
    const FavoritesScreen(),
    WalletHistoryScreen(
      from: true,
    ),
    ContactScreen(),
    const ViewProfileScreen(),
  ];

  int currenIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? path;
  String? networkimage;
  String? base64Image;

  @override
  void initState() {
    if (getData.read("currentIndex") == true) {
      save("currentIndex", false);
    } else {
      Get.find<LoginController>().selectedIndex = 0;
    }
    super.initState();
    isLogin = getData.read("UserLogin");
    setState(() {});
    getData.read("UserLogin") != null
        ? setState(() {
            userName = getData.read("UserLogin")["name"] ?? "";
            iDNUM = getData.read("UserLogin")["idCard"] ?? "";
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

  updateLanguage(Locale locale) {
    scaffoldKey.currentState!.closeDrawer();
    save("lan1", locale.countryCode);
    save("lan2", locale.languageCode);
    Get.updateLocale(locale);
  }

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'عربى', 'locale': const Locale('ar', 'IN')},
  ];
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: GetBuilder<LoginController>(builder: (context) {
        return Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            width: 250,
            child: GetBuilder<LoginController>(builder: (context) {
              return SafeArea(
                child: Column(
                  children: [
                    isLogin != null
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 80,
                                //   width: 80,
                                //   child: path == null
                                //       ? networkimage != ""
                                //           ? ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(80),
                                //               child: Image.network(
                                //                 "${Config.imageUrl}${networkimage ?? ""}",
                                //                 fit: BoxFit.cover,
                                //               ),
                                //             )
                                //           : CircleAvatar(
                                //               backgroundColor:
                                //                   Colors.transparent,
                                //               radius: Get.height / 17,
                                //               child: Container(
                                //                 decoration: const BoxDecoration(
                                //                     shape: BoxShape.circle,
                                //                     gradient: LinearGradient(
                                //                         end: Alignment
                                //                             .bottomRight,
                                //                         colors: [
                                //                           gradient.defoultColor,
                                //                           Colors.purpleAccent
                                //                         ])),
                                //               ),
                                //             )
                                //       : ClipRRect(
                                //           borderRadius:
                                //               BorderRadius.circular(80),
                                //           child: Image.file(
                                //             File(path.toString()),
                                //             width: Get.width,
                                //             fit: BoxFit.cover,
                                //           ),
                                //         ),
                                // ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome..".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        fontSize: 16,
                                        color: greyColor,
                                      ),
                                    ),
                                    Text(
                                      getData.read("UserLogin")["name"] ?? "-",
                                      style: TextStyle(
                                        fontFamily: FontFamily.gilroyMedium,
                                        fontSize: 14,
                                        color: BlackColor,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        scaffoldKey.currentState!.closeDrawer();
                                        setState(() {});
                                        if (isLogin != null) {
                                          context.changeIndex(5);
                                        } else {
                                          Get.to(() => LoginScreen());
                                        }
                                      },
                                      child: Text(
                                        "My Profile".tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.gilroyMedium,
                                          fontSize: 15,
                                          color: BlackColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    settingWidget(
                      name: "Home Page".tr,
                      imagePath: "assets/home-dash.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();

                        setState(() {});
                        if (isLogin != null) {
                          // coselectedIndex = index;
                          context.changeIndex(0);
                        } else {
                          0 != 0
                              ? Get.to(() => LoginScreen())
                              : const SizedBox();
                        }
                      },
                    ),
                    settingWidget(
                      name: "My Tickets".tr,
                      imagePath: "assets/Ticket.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                        setState(() {});
                        if (isLogin != null) {
                          Get.to(() => MyTicketScreen());
                        } else {
                          2 != 0
                              ? Get.to(() => LoginScreen())
                              : const SizedBox();
                        }
                      },
                    ),
                    settingWidget(
                      name: "Sell your offer".tr,
                      imagePath: "assets/deal.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                        setState(() {});
                        if (isLogin != null) {
                          Get.to(() => ContactScreen(
                                from: true,
                              ));
                        } else {
                          Get.to(() => LoginScreen());
                        }
                      },
                    ),
                    settingWidget(
                      name: "My Wallet".tr,
                      imagePath: "assets/wallet.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                        setState(() {});
                        if (isLogin != null) {
                          context.changeIndex(3);
                        } else {
                          Get.to(() => LoginScreen());
                        }
                      },
                    ),
                    settingWidget(
                      name: "Favorites".tr,
                      imagePath: "assets/Love.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                        setState(() {});
                        if (isLogin != null) {
                          context.changeIndex(2);
                        } else {
                          Get.to(() => LoginScreen());
                        }
                      },
                    ),
                    settingWidget(
                      name: "Contact us".tr,
                      imagePath: "assets/contactus.png",
                      onTap: () {
                        scaffoldKey.currentState!.closeDrawer();
                        setState(() {});
                        if (isLogin != null) {
                          context.changeIndex(4);
                        } else {
                          Get.to(() => LoginScreen());
                        }
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (getData.read("lanValue") == 0) {
                                  save("lanValue", 1);
                                  updateLanguage(locale[1]['locale']);
                                } else {
                                  save("lanValue", 0);
                                  updateLanguage(locale[0]['locale']);
                                }
                              });
                            },
                            child: Text(
                              getData.read("lanValue") != null
                                  ? getData.read("lanValue") == 0
                                      ? "English"
                                      : "عربى"
                                  : "English",
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 16,
                                color: BlackColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          isLogin != null
                              ? InkWell(
                                  onTap: () {
                                    logoutSheet();
                                  },
                                  child: Text(
                                    "SIGN OUT".tr,
                                    style: const TextStyle(
                                      fontFamily: FontFamily.gilroyMedium,
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (vats != null) {
                                launch(vats);
                              }
                            },
                            child: Container(
                              height: 80,
                              width: 100,
                              padding: const EdgeInsets.all(0),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      alignment: Alignment.topLeft,
                                      image: AssetImage("assets/vat.png"))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (terms != null) {
                                launch(terms);
                              }
                            },
                            child: Text(
                              "Terms & Conditions".tr,
                              style: const TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  launch(
                                      "https://www.instagram.com/helotokindia/");
                                },
                                icon: FaIcon(FontAwesomeIcons.tiktok,
                                    size: 25.0, color: gradient.defoultColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  launch(
                                      "https://www.instagram.com/helotokindia/");
                                },
                                icon: FaIcon(FontAwesomeIcons.instagram,
                                    size: 25.0, color: gradient.defoultColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  launch(
                                      "https://www.instagram.com/helotokindia/");
                                },
                                icon: FaIcon(FontAwesomeIcons.xTwitter,
                                    size: 25.0, color: gradient.defoultColor),
                              ),
                              IconButton(
                                onPressed: () {
                                  launch(
                                      "https://www.instagram.com/helotokindia/");
                                },
                                icon: FaIcon(FontAwesomeIcons.whatsapp,
                                    size: 25.0, color: gradient.defoultColor),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          //     appBar: AppBar(
          //       backgroundColor: bg1Color,
          // title: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Image.asset(
          //           "assets/new_logo.png",
          //           height: 50,
          //         ),
          //       ),
          //       // title: Text(
          //       //   context.selectedIndex == 0
          //       //       ? ""
          //       //       : context.selectedIndex == 1
          //       //           ? "Favorite".tr
          //       //           : context.selectedIndex == 2
          //       //               ? "Wallet".tr
          //       //               : context.selectedIndex == 3
          //       //                   ? "Contact us".tr
          //       //                   : "Profile".tr,
          //       //   style: TextStyle(
          //       //     fontFamily: FontFamily.gilroyBold,
          //       //     fontSize: 20,
          //       //     color: WhiteColor,
          //       //   ),
          //       // ),
          //       // actions: context.selectedIndex == 0
          //       //     ? [
          //       //         IconButton(
          //       //             onPressed: () {
          //       //               if (isLogin != null) {
          //       //                 Get.find<LoginController>().changeIndex(3);
          //       //               } else {
          //       //                 Get.to(() => LoginScreen());
          //       //               }
          //       //             },
          //       //             icon: const Icon(
          //       //               Icons.wallet,
          //       //               size: 30,
          //       //               color: Colors.white,
          //       //             )),
          //       //         IconButton(
          //       //             onPressed: () {
          //       //               if (isLogin != null) {
          //       //                 Get.to(() => MyTicketScreen());
          //       //               } else {
          //       //                 Get.to(() => LoginScreen());
          //       //               }
          //       //             },
          //       //             icon: Image.asset(
          //       //               "assets/Ticket.png",
          //       //               color: Colors.white,
          //       //               height: Get.size.height / 35,
          //       //             ))
          //       //       ]
          //       //     : [],
          //     ),
          backgroundColor: bgcolor,
          bottomNavigationBar: GetBuilder<LoginController>(builder: (context) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: greycolor,
              backgroundColor: WhiteColor,
              elevation: 0,
              fixedColor: gradient.defoultColor,
              currentIndex: currenIndex,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: transparent,
                  icon: Image.asset("assets/home-dash.png",
                      color: context.selectedIndex == 0
                          ? gradient.defoultColor
                          : greycolor,
                      height: Get.size.height / 35),
                  label: 'Home'.tr,
                ),
                BottomNavigationBarItem(
                  backgroundColor: transparent,
                  icon: Image.asset("assets/network.png",
                      color: context.selectedIndex == 1
                          ? gradient.defoultColor
                          : greycolor,
                      height: Get.size.height / 35),
                  label: 'Medical'.tr,
                ),
                BottomNavigationBarItem(
                  backgroundColor: transparent,
                  icon: Image.asset("assets/Love.png",
                      color: context.selectedIndex == 2
                          ? gradient.defoultColor
                          : greycolor,
                      height: Get.size.height / 35),
                  label: 'Favorite'.tr,
                ),

                BottomNavigationBarItem(
                  backgroundColor: transparent,
                  icon: Icon(Icons.wallet_outlined,
                      color: context.selectedIndex == 3
                          ? gradient.defoultColor
                          : greycolor,
                      size: Get.size.height / 35),
                  label: 'Wallet'.tr,
                ),

                BottomNavigationBarItem(
                  backgroundColor: transparent,
                  icon: Image.asset("assets/contactus.png",
                      color: context.selectedIndex == 4
                          ? gradient.defoultColor
                          : greycolor,
                      height: Get.size.height / 35),
                  label: 'Contact'.tr,
                ),

                // TabItem(
                //     icon: Image.asset(
                //       "assets/home-dash.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     ),
                //     title: 'Home'.tr,
                //     activeIcon: Image.asset(
                //       "assets/home-dash.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     )),

                // TabItem(
                //     icon: Image.asset(
                //       "assets/Love.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     ),
                //     title: 'Favorite'.tr,
                //     activeIcon: Image.asset(
                //       "assets/Love.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     )),
                // // TabItem(
                // //     icon: Container(
                // //       padding: const EdgeInsets.all(6),
                // //       decoration: const BoxDecoration(
                // //           color: Colors.white, shape: BoxShape.circle),
                // //       child: Image.asset(
                // //         "assets/Ticket.png",
                // //         color: gradient.defoultColor,
                // //       ),
                // //     ),
                // //     activeIcon: Container(
                // //       padding: const EdgeInsets.all(6),
                // //       decoration: const BoxDecoration(
                // //           color: Colors.white, shape: BoxShape.circle),
                // //       child: Image.asset(
                // //         "assets/Ticket.png",
                // //         color: gradient.defoultColor,
                // //       ),
                // //     )),

                // TabItem(
                //     icon: const Icon(
                //       Icons.wallet_outlined,
                //       color: Colors.black,
                //     ),
                //     title: 'Wallet'.tr,
                //     activeIcon: const Icon(
                //       Icons.wallet_outlined,
                //       color: Colors.black,
                //     )),
                // TabItem(
                //     icon: Image.asset(
                //       "assets/contactus.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     ),
                //     title: 'Contact'.tr,
                //     activeIcon: Image.asset(
                //       "assets/contactus.png",
                //       color: Colors.black,
                //       height: Get.size.height / 35,
                //     )),
              ],
              // backgroundColor: Colors.white,
              // activeColor: Colors.black,
              // color: Colors.black,
              onTap: (index) {
                if (isLogin != null) {
                  currenIndex = index;
                  context.changeIndex(index);
                } else {
                  index != 0 ? Get.to(() => LoginScreen()) : const SizedBox();
                }
                setState(() {});
              },
            );
          }),
          body: GetBuilder<LoginController>(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: myChilders[context.selectedIndex],
            );
          }),
        );
      }),
    );
  }

  Widget settingWidget({Function()? onTap, String? name, String? imagePath}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 45,
            width: Get.size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                Image.asset(
                  imagePath ?? "",
                  height: 25,
                  width: 25,
                  color: BlackColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  name ?? "",
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                ),
                const Spacer(),
                // Icon(
                //   Icons.arrow_forward_ios,
                //   size: 17,
                //   color: BlackColor,
                // ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  Future logoutSheet() {
    return Get.bottomSheet(
      Container(
        height: 220,
        width: Get.size.width,
        decoration: BoxDecoration(
          color: WhiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Logout".tr,
              style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.gilroyBold,
                color: RedColor,
              ),
            ),
            const SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to log out?".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                fontSize: 16,
                color: BlackColor,
              ),
            ),
            const SizedBox(
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
                      margin: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFeef4ff),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Text(
                        "Cancle".tr,
                        style: const TextStyle(
                          color: gradient.defoultColor,
                          fontFamily: FontFamily.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() async {
                        save('isLoginBack', true);
                        getData.remove('Firstuser');
                        getData.remove("UserLogin");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      });
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: gradient.btnGradient,
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Text(
                        "Logout".tr,
                        style: TextStyle(
                          color: WhiteColor,
                          fontFamily: FontFamily.gilroyBold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MapScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
