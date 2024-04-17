import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_Add_whishlistProduct.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_CategoryBynameController.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_add_remove_wishlist_controller.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_singleproductviewController.dart';
import 'package:mohally/Arabic/Screens/ArabicSingleView/ArabicSingleProductView.dart';
import 'package:mohally/Arabic/Screens/Arabic_CategoryScreen/ArabicCategoryScreen.dart';
import 'package:mohally/core/app_export.dart';
import 'package:mohally/data/response/status.dart';
import 'package:mohally/view_models/controller/Home_Banner_Controller/home_banner_controller.dart';
import 'package:mohally/view_models/controller/Home_controller.dart/ArabicHomeController.dart';
import 'package:mohally/widgets/custom_icon_button.dart';
import 'package:mohally/widgets/custom_rating_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var arabicProductId;
var arabicMainCatId;
String? sizeid;
String? colorId;
String? color;
String? size1;
var arabiccategoryId;
var arabicsubmainCatId;

class ArabicHomeScreen extends StatefulWidget {
  const ArabicHomeScreen({Key? key}) : super(key: key);
  @override
  State<ArabicHomeScreen> createState() => _ArabicHomeScreenState();
}

class _ArabicHomeScreenState extends State<ArabicHomeScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ArabiccategorybyNameController _categorybynamecontroller =
      ArabiccategorybyNameController();

  List<bool> tappedList = List.generate(200, (index) => false);

  int selectedIndex = 0;
  HomeBanner_controller homeBanner_controller = HomeBanner_controller();
  List<bool> isButtonTappedList = List.generate(1000, (index) => false);
  Add_remove_wishlistController add_remove_wishlistController =
      Add_remove_wishlistController();
  // HomeBanner_controller homeBanner_controller = HomeBanner_controller();
  ArabicHomeView_controller homeView_controller = ArabicHomeView_controller();
  ArabicSingleProductViewController productviewcontroller =
      ArabicSingleProductViewController();

  RxInt selectedImageIndex = 0.obs;
  RxString selectedImageUrl = ''.obs;
  @override
  void initState() {
    super.initState();
    //homeBanner_controller.homeBanner_apihit();
    homeBanner_controller.homeBanner_apihit();
    homeView_controller.homeview_apihit();
    // productviewcontroller.Single_ProductApiHit();
  }

  // int _currentPage = 0;
  List<String> category = [
    'إلكترونيات',
    'للنساءملابس',
    'مِلك الرجالملابس',
    'منحنى وزائد'
  ];
  int selectedTabIndex = 0;
  List<String> title = ['الجميع', 'نحيف', 'رجال', 'أطفال', "مجوهرات"];
  List<String> recomemded_text = [
    'مُستَحسَن',
    'ملابس رجالية',
    'الصحة و الجمال',
    'الصحة و الجمال',
    "الصحة و الجمال"
  ];
  List<String> carouselImages = [
    "assets/images/arabic_banner.png",
    "assets/images/arabic_banner.png",
  ];
  List<String> categoriesImages = [
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
    "assets/images/img_ellipse_1.png",
  ];
  RxString selectedcolored = "".obs;
  RxInt selectedcolorIndex = (-1).obs;
  RxInt selectedSizeIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      //   if (homeBanner_controller.rxRequestStatus.value == Status.LOADING) {
      //   return const Scaffold(
      //     body: Center(child: CircularProgressIndicator()),
      //   );
      // }
      //  else if (homeBanner_controller.error.value == 'No internet') {
      //   return Scaffold(
      //     body: Center(
      //         child: InterNetExceptionWidget(
      //       onPress: () {},
      //     )),
      //   );
      // }
      if (homeView_controller.rxRequestStatus.value == Status.LOADING) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
        // }
        // else if (homeBanner_controller.error.value == 'No internet') {
        //   return Scaffold(
        //     body: Center(
        //         child: InterNetExceptionWidget(
        //       onPress: () {},
        //     )),
        //   );
      } else if (homeView_controller.rxRequestStatus.value == Status.ERROR) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/error2.png',
            ),
            Center(
              child: Text(
                "عفوا! تواجه خوادمنا مشكلة في الاتصال.\nيرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى",
                style: theme.textTheme.headlineMedium?.copyWith(
                    color: Color.fromARGB(73, 0, 0, 0),
                    fontSize: 12,
                    fontFamily: 'Almarai'),
              ),
            ),
          ],
        ));
      } else {
        return SmartRefresher(
          enablePullDown: true,
          onRefresh: () async {
            homeBanner_controller.homeBanner_apihit();
            homeView_controller.homeview_apihit();
            await Future.delayed(
                Duration(seconds: 1)); // Adjust the duration as needed
            _refreshController.refreshCompleted();
          },
          enablePullUp: false,
          controller: _refreshController,
          child: Container(
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: Get.height * .02,
                ),
                // CarouselSlider(
                //   items: carouselImages.map((String imageUrl) {
                //     return Builder(
                //       builder: (BuildContext context) {
                //         return Container(
                //           width: MediaQuery.of(context).size.width,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(10)),
                //             image: DecorationImage(
                //               image: AssetImage(imageUrl),
                //               fit: BoxFit.fill,
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   }).toList(),
                //   options: CarouselOptions(
                //     autoPlay: true,
                //     aspectRatio: 2.0,
                //     enlargeCenterPage: true,
                //   ),
                // ),

                CarouselSlider(
                  items:
                      //carouselItems,
                      List.generate(
                    homeBanner_controller
                                .userList.value.homeBanner?.bannerUrl ==
                            null
                        ? 0
                        : homeBanner_controller
                            .userList.value.homeBanner!.bannerUrl!.length,
                    (index) => Image.network(
                      homeBanner_controller
                              .userList.value.homeBanner?.bannerUrl?[index]
                              .toString() ??
                          "",
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                ),

                //           CarouselSlider(
                //             items: carouselImages.map((String imageUrl) {
                //        return Builder(
                //          builder: (BuildContext context) {
                //            return Container(
                //              width: MediaQuery.of(context).size.width,

                //              decoration: BoxDecoration(
                //               borderRadius: BorderRadius.all(Radius.circular(10)
                //               ),
                //               image: DecorationImage(image: AssetImage(  imageUrl,),
                //                fit: BoxFit.fill,
                //               )
                //              ),

                //            );
                //          },
                //        );
                //      }).toList(),
                //         // items: List.generate(
                //         //   homeBanner_controller.userList.value.homeBanner?.bannerUrl == null
                //         //       ? 0
                //         //       : homeBanner_controller.userList.value.homeBanner!.bannerUrl!.length,
                //         //   (index) => Image.network(
                //         //     homeBanner_controller.userList.value.homeBanner?.bannerUrl?[index].toString() ?? "",
                //         //   ),
                //         // ),
                //         options: CarouselOptions(
                // autoPlay: true,
                // aspectRatio: 2.0,
                // enlargeCenterPage: true,

                // reverse: false

                //         ),

                //             ),

                SizedBox(
                  height: Get.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: Get.height * .08,
                      width: Get.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(136, 235, 215, 215),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/return.png",
                          ),
                          SizedBox(
                            width: Get.width * .01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'إرجاع مجاني',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Almarai'),
                              ),
                              Text(
                                'في غضون 90 يوما',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'Almarai'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * .08,
                      width: Get.width * .4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Color.fromARGB(135, 236, 213, 213),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "assets/images/ship.png",
                          ),
                          SizedBox(
                            width: Get.width * .01,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ًالشحن مجانا',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Almarai'),
                              ),
                              Text(
                                'وقت محدود العرض',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontFamily: 'Almarai'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'فئات',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Almarai'),
                    ),
                    SizedBox(
                      width: Get.width * .4,
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedTabIndex = 0;
                        arabiccategoryId = homeView_controller
                            .userList.value.categoryData?[0].id!
                            .toString();
                        _categorybynamecontroller.CategoryByNameApiHit(
                            arabiccategoryId);

                        Get.to(CategoryScreen_arabic(
                            showAppBar: true,
                            FromHomeToCat: true,
                            arabicselectedTabIndex: selectedTabIndex));
                      },
                      child: Text(
                        'اظهار الكل',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffff8300),
                            fontFamily: 'Almarai'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * .04,
                ),
                homeView_controller.userList.value.categoryData == null ||
                        homeView_controller
                                .userList.value.categoryData?.length ==
                            0
                    ? Center(
                        child: Column(
                        children: [
                          Image.asset(
                            'assets/images/no_product.png',
                            color: Color(0xffff8300),
                          ),
                          SizedBox(
                            height: Get.height * .03,
                          ),
                          Text(
                            "الصفحة غير موجودة",
                            style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                fontFamily: 'Almarai'),
                          ),
                        ],
                      ))
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: Get.height * .17,
                            crossAxisCount: 4,
                            mainAxisSpacing: 17.h,
                            crossAxisSpacing: 15.h,
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount: homeView_controller
                                  .userList.value.categoryData?.length ??
                              0,
                          // homeView_controller
                          //     .userList.value.categoryData?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    arabiccategoryId = homeView_controller
                                        .userList.value.categoryData?[index].id!
                                        .toString();

                                    selectedTabIndex = index;
                                    print(selectedTabIndex);

                                    arabiccategoryId = homeView_controller
                                        .userList.value.categoryData?[index].id!
                                        .toString();
                                    _categorybynamecontroller
                                        .CategoryByNameApiHit(arabiccategoryId);

                                    Get.to(CategoryScreen_arabic(
                                        showAppBar: true,
                                        FromHomeToCat: true,
                                        arabicselectedTabIndex:
                                            selectedTabIndex));
                                  },
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(38.0),
                                      child: Image.network(
                                        "${homeView_controller.userList.value.categoryData?[index].imageUrl.toString()}",
                                        height: 68,
                                        width: 68,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.v),
                                Center(
                                  child: Text(
                                    "${homeView_controller.userList.value.categoryData?[index].categoryName.toString()}",
                                    style: TextStyle(
                                      color: Color(0xFF272727),
                                      fontSize: 12,
                                      fontFamily: 'Almarai',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: Get.height * .05,
                ),

                _buildHomePageSection(context),
              ]),
            ),
          ),
        );
      }
    });
  }

  Widget _buildHomePageSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: Get.height * .4,
            crossAxisCount: 2,
            // mainAxisSpacing: 2,
            crossAxisSpacing: 10.h,
          ),
          physics: BouncingScrollPhysics(),
          itemCount:
              homeView_controller.userList.value.recommendedProduct?.length ??
                  0,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width, padding: EdgeInsets.only(left: 20),
                  // height: 160.adaptSize,
                  // width: 160.adaptSize,
                  // height: Get.height*.2,
                  // width: Get.width*.3,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: CustomImageView(
                          fit: BoxFit.cover,
                          imagePath:
                              "${homeView_controller.userList.value.recommendedProduct?[index].imageUrl.toString()}",
                          onTap: () {
                            arabicMainCatId = homeView_controller.userList.value
                                .recommendedProduct![index].mainCategoryId!
                                .toString();
                            arabicProductId = homeView_controller
                                .userList.value.recommendedProduct![index].id!
                                .toString();
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
                            onTap: () {
                              Arabic_Add_remove_productid = homeView_controller
                                  .userList.value.recommendedProduct![index].id!
                                  .toString();
                              ArabicAdd_remove_wishlistController()
                                  .AddRemoveWishlish_apihit();

                              setState(() {
                                isButtonTappedList[index] =
                                    !isButtonTappedList[index];
                              });
                            },
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                            padding: EdgeInsets.all(5.h),
                            decoration: IconButtonStyleHelper.fillWhiteA,
                            alignment: Alignment.topRight,
                            child: CustomImageView(
                              imagePath: isButtonTappedList[index]
                                  ? ImageConstant
                                      .imgGroup239531 // Change this to your tapped image
                                  : ImageConstant.imgSearch, // Default image
                            ),
                          )),
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
                          fontFamily: 'Almarai'),
                    ),
                  ),
                ),
                // CustomElevatedButton(
                //   height: 16.v,
                //   width: 48.h,
                //   text: "10% Off",
                //   buttonTextStyle:
                //       theme.textTheme.labelSmall!.copyWith(color: Colors.white).copyWith(backgroundلون: Color.fromARGB(214, 252, 204, 220)),
                // ),
                SizedBox(height: 5.v),
                SizedBox(
                  width: 131.h,
                  child: Text(
                    "${homeView_controller.userList.value.recommendedProduct?[index].title.toString()}",
                    // "ساعة كوارتز حجر الراين الفاخرة السيدات روما...",
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
                              "${homeView_controller.userList.value.recommendedProduct?[index].price.toString()}",
                              //"\$99 ",
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
                        onTap: () async {
                          arabicMainCatId = homeView_controller.userList.value
                              .recommendedProduct?[index].mainCategoryId
                              .toString();
                          // String? arproductId = homeView_controller
                          //     .userList.value.recommendedProduct?[index].id
                          //     ?.toString();
                        },
                        height: 30.adaptSize,
                        width: 30.adaptSize,
                        padding: EdgeInsets.all(6.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgGroup239533,
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

  Widget buildAvatarColumn() {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(
            "assets/images/img_ellipse_1.png",
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          "إلكترونيات",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'Almarai',
          ),
        ),
      ],
    );
  }

  Widget _buildRowSize(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("مقاس", style: theme.textTheme.titleMedium),
            Padding(
              padding: EdgeInsets.only(bottom: 2.v),
              child: Text("دليل المقاسات",
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
