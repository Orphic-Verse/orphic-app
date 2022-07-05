import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_parser/color_parser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momentum/momentum.dart';
import 'package:orphicnew/common/helpers.dart';
import 'package:orphicnew/constants.dart';
import 'package:orphicnew/controllers/auth.controller.dart';
import 'package:orphicnew/controllers/items.controller.dart';
import 'package:orphicnew/models/item.model.dart';
import 'package:orphicnew/responses/category.res.dart';
import 'package:orphicnew/views/items.view.dart';
import 'package:orphicnew/views/rewards.view.dart';

class CategoriesView extends StatefulWidget {
  bool isFirstTime;

  CategoriesView({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    if (widget.isFirstTime) {
      // Momentum.controller<AuthController>(context).fetchProfile();
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      Momentum.controller<ItemController>(context).fetchCategories();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BGCOLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.BGCOLOR,
        title: Row(
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
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xff302f3c),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 37.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RewardsView()));
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Discounts",
                          style: TextStyle(
                              color: AppColors.DARKCOLOR,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                      ySpace(5),
                      Image.asset(
                        'assets/images/reward_hand.png',
                        height: 85,
                        width: 108,
                      )
                    ],
                  ),
                ),
                height: 148,
                width: 340,
                decoration: BoxDecoration(
                  color: Color(0xfff7f7f7),
                  border: Border.all(color: AppColors.DARKCOLOR, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            ySpace(16),
            Text(
              "Food Menu",
              style: TextStyle(
                  color: AppColors.DARKCOLOR,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            ySpace(22.5),
            MomentumBuilder(
                controllers: [ItemController],
                builder: (context, snapshot) {
                  List<CategoryData> categories =
                      snapshot<ItemModel>().listOfCategories;
                  return GridView.builder(
                    itemCount: categories.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12),
                    itemBuilder: (context, index) {
                      return CategoryContainer(
                        category: categories[index],
                      );
                    },
                  );
                }),
            ySpace(20),
          ],
        ),
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  CategoryData category;
  CategoryContainer({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Momentum.controller<AuthController>(context).postStat(
            eventType: EVENT_TYPES.USER_OPENED_CATEGORY,
            idType: ID_TYPE.categoryId,
            data: category.sId);
        Momentum.controller<ItemController>(context).clearFetchedItems();
        if (category.name!.contains("Rewards")) {
          Get.to(() => RewardsView());
        } else {
          Get.to(() => ItemsView(category: category));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorParser.hex(category.backgroundColor ?? "0xfff5c1c1")
              .getColor(),
          border: Border.all(
              color: ColorParser.hex(category.borderColor ?? "0xff3d3d3d")
                      .getColor() ??
                  const Color(0xff3d3d3d),
              width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                category.name ?? "Name is empty",
                style: const TextStyle(
                  color: Color(0xff1A1A1A),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            ySpace(10),
            CachedNetworkImage(
              imageUrl: category.imageUrl ?? "",
              height: 76,
              width: 80,
            ),
          ],
        ),
      ),
    );
  }
}
