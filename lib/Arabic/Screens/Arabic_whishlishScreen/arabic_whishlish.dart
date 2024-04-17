import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_Add_whishlistProduct.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_add_remove_wishlist_controller.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_singleproductviewController.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_viewwishlistController.dart';
import 'package:mohally/Arabic/Screens/ArabicSingleView/ArabicSingleProductView.dart';
import 'package:mohally/Arabic/Screens/Arabic_HomeScreen/ArabicHomeScreen.dart';
import 'package:mohally/core/utils/image_constant.dart';
import 'package:mohally/core/utils/size_utils.dart';
import 'package:mohally/data/response/status.dart';
import 'package:mohally/theme/app_decoration.dart';
import 'package:mohally/theme/custom_button_style.dart';
import 'package:mohally/theme/custom_text_style.dart';
import 'package:mohally/theme/theme_helper.dart';
import 'package:mohally/view_models/controller/Home_controller.dart/ArabicHomeController.dart';
import 'package:mohally/widgets/app_bar/appbar_subtitle.dart';
import 'package:mohally/widgets/app_bar/custom_app_bar.dart';
import 'package:mohally/widgets/custom_elevated_button.dart';
import 'package:mohally/widgets/custom_icon_button.dart';
import 'package:mohally/widgets/custom_image_view.dart';
import 'package:mohally/widgets/custom_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore_for_file: must_be_immutable
class WishlistPage_arabic extends StatefulWidget {
  final bool showAppBar;

  const WishlistPage_arabic({Key? key, this.showAppBar = false})
      : super(
          key: key,
        );

  @override
  State<WishlistPage_arabic> createState() => _WishlistPage_arabicState();
}

class _WishlistPage_arabicState extends State<WishlistPage_arabic> {
  RxInt selectedImageIndex = 0.obs;
  RxString selectedImageUrl = ''.obs;
  RxString selectedcolored = "".obs;
  RxInt selectedcolorIndex = (-1).obs;
  RxInt selectedSizeIndex = (-1).obs;
  ArabicSingleProductViewController productviewcontroller =
      ArabicSingleProductViewController();

  List<bool> isButtonTappedList = List.generate(12, (index) => false);
  ArabicHomeView_controller homeView_controller = ArabicHomeView_controller();
  ArabicViewwishlist viewWishlistcontroller = ArabicViewwishlist();
  Add_remove_wishlistController add_remove_wishlistController =
      Add_remove_wishlistController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    viewWishlistcontroller.ViewWishlish_apihit();
    homeView_controller.homeview_apihit();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(child: Obx(() {
      if (viewWishlistcontroller.rxRequestStatus.value == Status.LOADING) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (homeView_controller.rxRequestStatus.value == Status.LOADING) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (homeView_controller.rxRequestStatus.value == Status.ERROR) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error2.png',
            ),
            Center(
              child: Text(
                "Oops! Our servers are having trouble connecting.\nPlease check your internet connection and try again",
                style: theme.textTheme.headlineMedium?.copyWith(
                    color: Color.fromARGB(73, 0, 0, 0), fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      } else if (viewWishlistcontroller.rxRequestStatus.value == Status.ERROR) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error2.png',
            ),
            Text(
              "Oops! Our servers are having trouble connecting.\nPlease check your internet connection and try again",
              style: theme.textTheme.headlineMedium
                  ?.copyWith(color: Color.fromARGB(73, 0, 0, 0), fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        );
      } else {
        return Scaffold(
          appBar: widget.showAppBar
              ? CustomAppBar(
                  leadingWidth: 80,
                  leading: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: CustomIconButton(
                        onTap: () {
                          Get.back();
                          // Get.offAll(TabScreen(index: 0));
                        },
                        height: 40.adaptSize,
                        width: 40.adaptSize,
                        decoration: IconButtonStyleHelper.fillGrayTL20,
                        child: Center(
                            child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ))),
                  ),
                  title: AppbarSubtitle(
                    text: "قائمة الرغبات",
                    // margin: EdgeInsets.only(left: 10),
                  ),
                )
              : null,
          body: SmartRefresher(
            enablePullDown: true,
            onRefresh: () async {
              viewWishlistcontroller.ViewWishlish_apihit();
              await Future.delayed(
                  Duration(seconds: 1)); // Adjust the duration as needed
              _refreshController.refreshCompleted();
            },
            enablePullUp: false,
            controller: _refreshController,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: AppDecoration.fillWhiteA,
                  child: Container(
                    // padding: EdgeInsets.symmetric(horizontal: 20.h,),
                    child: Column(
                      children: [
                        SizedBox(height: 25.v),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "قائمة الرغبات",
                              style: theme.textTheme.headlineMedium
                                  ?.copyWith(fontFamily: "Almarai"),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.v),
                        _buildEdit(context),
                        SizedBox(height: 27.v),
                        _buildWishlistGrid(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }));
  }

  /// Section Widget
  Widget _buildEditButton(BuildContext context) {
    return CustomElevatedButton(
      height: 35.v,
      width: 65.h,
      text: "يحرر",
      margin: EdgeInsets.only(bottom: 2.v),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 5.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgEdit,
          height: 15.adaptSize,
          width: 15.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillGray,
      buttonTextStyle: CustomTextStyles.bodyMediumGray9000115
          ?.copyWith(fontFamily: "Almarai"),
    );
  }

  /// Section Widget
  Widget _buildEdit(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  '${viewWishlistcontroller.userList.value.wishlistViewList!.length.toString()} عنصر',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontFamily: "Almarai"),
                ),
              ),
              SizedBox(height: 6.v),
              Text(
                'في قائمة الرغبات',
                style: CustomTextStyles.bodyLargeGray50001_3
                    ?.copyWith(fontFamily: "Almarai"),
              ),
            ],
          ),
          // _buildEditButton(context),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid(BuildContext context) {
    return viewWishlistcontroller.userList.value.wishlistViewList == null ||
            viewWishlistcontroller.userList.value.wishlistViewList!.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/wishlist.png',
                  width: 100,
                ),
                SizedBox(
                  height: Get.height * .03,
                ),
                Center(
                  child: Text(
                    "قائمة رغباتك فارغة!",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      fontFamily: 'Almarai',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      "استكشف المزيد وقم بوضع قائمة مختصرة لبعض العناصر",
                      style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Color.fromARGB(73, 0, 0, 0),
                          fontFamily: 'Almarai'),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Container(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: Get.height * .4,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.h,
                ),
                physics: BouncingScrollPhysics(),
                itemCount: viewWishlistcontroller
                    .userList.value.wishlistViewList!.length,
                itemBuilder: (context, index) {
                  final wishlistProduct = viewWishlistcontroller
                      .userList.value.wishlistViewList![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.only(left: 20),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: CustomImageView(
                                fit: BoxFit.cover,
                                imagePath: wishlistProduct.imageUrl.toString(),
                                onTap: () {
                                  arabicMainCatId =
                                      wishlistProduct.categoryId.toString();

                                  arabicProductId =
                                      wishlistProduct.id!.toString();
                                  productviewcontroller.Single_ProductApiHit(
                                      arabicMainCatId, arabicProductId);
                                  Get.to(ArabicMensSingleViewScreen());
                                },
                                height: 190.adaptSize,
                                width: 190.adaptSize,
                                radius: BorderRadius.circular(
                                  10.h,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 10.v,
                                right: 10.h,
                              ),
                              child: CustomIconButton(
                                height: 20.adaptSize,
                                width: 20.adaptSize,
                                padding: EdgeInsets.all(5.h),
                                decoration: IconButtonStyleHelper.fillWhiteA,
                                alignment: Alignment.topRight,
                                child: CustomImageView(
                                  imagePath: isButtonTappedList[index]
                                      ? ImageConstant.imgSearch
                                      : ImageConstant.imgGroup239531,
                                  onTap: () {
                                    //
                                    Arabic_Add_remove_productid =
                                        wishlistProduct.id!.toString();
                                    ArabicAdd_remove_wishlistController()
                                        .AddRemoveWishlish_apihit();

                                    setState(() {
                                      // Add_remove_productidd;
                                      //  isButtonTapped = !isButtonTapped;
                                      isButtonTappedList[index] =
                                          !isButtonTappedList[index];
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.v),
                      Container(
                        height: 16.v,
                        width: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color.fromARGB(71, 228, 193, 204),
                        ),
                        child: Center(
                          child: Text(
                            'خصم 10',
                            style: TextStyle(
                              fontSize: 8,
                              color: Color(0xffff8300),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Almarai',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 131.h,
                        child: Text(
                          wishlistProduct.aTitle.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelLarge!
                              .copyWith(
                                height: 1.33,
                              )
                              .copyWith(fontFamily: 'Almarai'),
                        ),
                      ),
                      SizedBox(height: 3.v),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.h),
                                      child: CustomRatingBar(
                                        ignoreGestures: true,
                                        initialRating: homeView_controller
                                            .userList
                                            .value
                                            .recommendedProduct?[index]
                                            .averageRating
                                            ?.toDouble(),
                                      ),
                                    ),
                                    Text(
                                      "${homeView_controller.userList.value.recommendedProduct?[index].averageRating.toString()}",
                                      // "4.8",
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(fontFamily: 'Almarai'),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.v),
                              Row(
                                children: [
                                  Text(
                                    "2k+ مُباع  ",
                                    style: theme.textTheme.bodySmall
                                        ?.copyWith(fontFamily: 'Almarai'),
                                  ),
                                  Text(
                                    wishlistProduct.price.toString(),
                                    style: CustomTextStyles.titleMediumPrimary_2
                                        .copyWith(fontFamily: 'Almarai'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 58.h,
                              top: 3.v,
                            ),
                            child: CustomIconButton(
                              height: 30.adaptSize,
                              width: 30.adaptSize,
                              padding: EdgeInsets.all(6.h),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgGroup239533,
                                onTap: () async {
                                  arabicMainCatId =
                                      wishlistProduct.categoryId.toString();
                                  // String? arproductId =
                                  //     wishlistProduct.id?.toString();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
  }
}
