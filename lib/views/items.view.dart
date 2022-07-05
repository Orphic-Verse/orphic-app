import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/common/or_back_button.dart';
import 'package:orphicnew/constants.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/items.controller.dart';
import 'package:orphicnew/models/item.model.dart';
import 'package:orphicnew/responses/category.res.dart';
import 'package:orphicnew/responses/item.res.dart';
import 'package:orphicnew/views/rewards.view.dart';

class ItemsView extends StatefulWidget {
  CategoryData category;
  ItemsView({Key? key, required this.category}) : super(key: key);

  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  String selectedCat = "All";

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      Momentum.controller<ItemController>(context)
          .fetchItemsWithCategoryId(widget.category.sId ?? "");
      showMessagePopups();
    });
    super.initState();
  }

  void showMessagePopups() async {
    final messages = Momentum.controller<AuthController>(context)
            .model
            .userData!
            .rewardsMessages ??
        [];
    // final messages = [
    //   {"message": "This is a short message"}
    // ];

    await Future.delayed(const Duration(seconds: 2));
    for (final message in messages) {
      await Get.defaultDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        titleStyle: const TextStyle(fontSize: 0),
        content: Container(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Momentum.controller<AuthController>(context).postStat(
                          eventType: EVENT_TYPES.USER_CANCELLED_POPUP,
                          idType: ID_TYPE.noIdDataNeeded);
                      Get.back();
                    }),
              ),
              Image.asset(
                'assets/images/big_coupon.png',
              ),
              Text(
                message.message ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  overflow: TextOverflow.clip,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff1a1a1a),
                ),
              ),
              ySpace(20),
              SizedBox(
                width: 171,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xffffc914),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(width: 1.5, color: Colors.black),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Momentum.controller<AuthController>(context).postStat(
                        eventType: EVENT_TYPES.USER_ACCEPTED_POPUP,
                        idType: ID_TYPE.noIdDataNeeded);
                    Get.back();
                    Get.to(() => RewardsView());
                  },
                  child: const Text(
                    'YESS!!',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              ySpace(20),
            ],
          ),
          padding: const EdgeInsets.all(16),
          // height: 283,
          width: 283,
          decoration: BoxDecoration(
            color: const Color(0xffffedb1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
      );
    }
  }

  Widget buildSubCategoryList(List<String> subCats) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: subCats.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCat = subCats[index];
                });
              },
              child: Container(
                margin: const EdgeInsets.only(left: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selectedCat == subCats[index]
                      ? const Color(0xffffc914)
                      : const Color(0xfff8f8fa),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffdedede),
                  ),
                ),
                height: 41,
                child: Center(
                  child: Text(subCats[index],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Momentum.controller<AuthController>(context).postStat(
            eventType: EVENT_TYPES.USER_CLOSED_CATEGORY,
            idType: ID_TYPE.categoryId,
            data: widget.category.sId);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.BGCOLOR,
        body: Stack(
          children: [
            MomentumBuilder(
                controllers: [ItemController],
                builder: (context, snapshot) {
                  List<ItemResData> allItems =
                      snapshot<ItemModel>().currentFetchedItems;
                  List<String> subCats = snapshot<ItemModel>().subCats;
                  if (subCats.isNotEmpty) {
                    subCats = ["All", ...subCats];
                  }

                  List<ItemResData> filteredItems = allItems;
                  if (selectedCat != "All") {
                    filteredItems = [];
                    for (final element in allItems) {
                      if (element.subCategory == selectedCat) {
                        filteredItems.add(element);
                      }
                    }
                  }
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredItems.length + 2,
                      itemBuilder: (context, index) {
                        if (index == 0) return ySpace(118);
                        if (index == 1) {
                          return buildSubCategoryList(subCats);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: ItemContainer(item: filteredItems[index - 2]),
                        );
                      });
                }),
            Container(
              padding: const EdgeInsets.all(16),
              height: 110,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfff5d4c1),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    backButton(onPressed: () {
                      Momentum.controller<AuthController>(context).postStat(
                          eventType: EVENT_TYPES.USER_CLOSED_CATEGORY,
                          idType: ID_TYPE.categoryId,
                          data: widget.category.sId);
                      Get.back();
                    }),
                    xSpace(16),
                    Text(
                      widget.category.name ?? "",
                      style: TextStyle(
                        color: AppColors.DARKCOLOR,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    xSpace(8),
                    CachedNetworkImage(
                      imageUrl: widget.category.imageUrl ?? "",
                      width: 40,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemContainer extends StatefulWidget {
  ItemResData item;
  ItemContainer({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Momentum.controller<AuthController>(context).postStat(
            eventType: EVENT_TYPES.USER_OPENED_ITEM,
            idType: ID_TYPE.itemId,
            data: widget.item.sId);
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 14, bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name!.trim(),
                          style: const TextStyle(
                            overflow: TextOverflow.clip,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      xSpace(10),
                      Image.asset(widget.item.isNonVeg ?? true
                          ? "assets/images/non_veg.png"
                          : 'assets/images/veg.png')
                    ],
                  ),
                  ySpace(10),
                  Text(
                    widget.item.description ?? "",
                    maxLines: isExpanded ? 50 : 2,
                    style: const TextStyle(
                      letterSpacing: 1.2,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                  ySpace(10),
                  Text(
                    "₹${widget.item.rate}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            widget.item.imageUrl != null && widget.item.imageUrl!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: CachedNetworkImage(
                      imageUrl: widget.item.imageUrl ?? '',
                      height: 90,
                      width: 90,
                    ),
                  )
                : nothingWidget
            // xSpace(24),
          ],
        ),
        // height: 130,
        decoration: BoxDecoration(
          color: const Color(0xfff7f7f7),
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(
            13,
          ),
        ),
      ),
    );
  }
}
