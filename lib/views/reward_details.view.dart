import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/responses/rewards.res.dart';
import 'package:orphicnew/responses/user.res.dart';

import '../constants.dart';

class RewardDetailsView extends StatelessWidget {
  RewardItem reward;
  RewardDetailsView({Key? key, required this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Momentum.controller<AuthController>(context).postStat(
            eventType: EVENT_TYPES.USER_CLOSED_REWARD,
            idType: ID_TYPE.rewardId,
            data: reward.sId);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FLAT ${reward.discountPercentage}% OFF",
              style: TextStyle(
                fontFamily: "Poppins",
                color: AppColors.DARKCOLOR,
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.pin_drop_rounded,
                  // size: 10,

                  color: Color(0xffff8100),
                ),
                xSpace(5),
                const Text(
                  "Bistro Claytopia",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff302f3c),
                  ),
                ),
              ],
            ),
            ySpace(8),
            Text(
              reward.message ?? "",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.DARKCOLOR,
              ),
            ),
            ySpace(16),
            Image.asset(
              "assets/images/biggest_coupon.png",
              height: 130,
              width: 130,
            ),
            ySpace(16),
            Text(
              "Valid from ${humanFormat(reward.eligibleFrom)}",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.DARKCOLOR,
              ),
            ),
            ySpace(14),
            DottedBorder(
              color: AppColors.DARKCOLOR,
              strokeWidth: 2,
              child: GestureDetector(
                onTap: () {
                  EasyLoading.showToast(
                    "Copied to clipboard",
                    toastPosition: EasyLoadingToastPosition.bottom,
                  );
                  Clipboard.setData(ClipboardData(text: reward.code ?? ""));
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "${reward.code}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.DARKCOLOR,
                      ),
                    ),
                  ),
                  height: 60,
                  width: 297,
                  color: const Color(0xffffc914),
                ),
              ),
            ),
            ySpace(14),
            Text(
              "Expires on ${humanFormat(reward.expires)}",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.DARKCOLOR,
              ),
            ),
            ySpace(14),
            Center(
              child: GestureDetector(
                onTap: () {
                  Momentum.controller<AuthController>(context).postStat(
                      eventType: EVENT_TYPES.USER_CLOSED_REWARD,
                      idType: ID_TYPE.rewardId,
                      data: reward.sId);
                  Get.back();
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
