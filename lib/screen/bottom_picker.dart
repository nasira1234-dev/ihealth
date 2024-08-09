// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:magicmate/model/fontfamily_model.dart';
import 'package:magicmate/utils/Colors.dart';

class BottomPicker extends StatelessWidget {
  BottomPicker({
    super.key,
    required this.options,
    required this.value,
    required this.onSelected,
  });

  final List<String> options;
  final String value;
  final Function(String) onSelected;
  String? city = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  onSelected(
                    city == "All" ? "" : city!,
                  );
                  Get.back();
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: gradient.defoultColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: BlackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 250,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 40,
            magnification: 1.25,
            scrollController: FixedExtentScrollController(
              initialItem: options.indexOf(
                options.firstWhere(
                  (element) => element == value,
                ),
              ),
            ),
            onSelectedItemChanged: (int index) {
              city = options[index];
            },
            children: options
                .map(
                  (option) => Center(
                    child: Text(
                      option,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
