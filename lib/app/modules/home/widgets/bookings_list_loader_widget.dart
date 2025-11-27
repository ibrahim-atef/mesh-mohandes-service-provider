import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/app_color.dart';

class BookingsListLoaderWidget extends StatelessWidget {
  BookingsListLoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        primary: false,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (_, index) {
          return Shimmer.fromColors(
            baseColor: AppColor.greyWithOpacity(0.1),
            highlightColor: AppColor.greyLightWithOpacity(0.1),
            child: Container(
              width: double.maxFinite,
              height: 180,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.white,
              ),
            ),
          );
        });
  }
}
