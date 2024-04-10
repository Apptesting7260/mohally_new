import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohally/Arabic/Arabic_controllers/arabic_CategoryBynameController.dart';
import 'package:mohally/Arabic/Screens/Arabic_CategoryScreen/ArabicSubCategory/ArabicSubCategoryScreen.dart';
import 'package:mohally/Arabic/Screens/Arabic_CategoryScreen/arabic_no_product_found.dart';
import 'package:mohally/Arabic/Screens/Arabic_HomeScreen/arabic_searchHome_histroy_page.dart';
import 'package:mohally/Arabic/Screens/Arabic_HomeScreen/ArabicHomeScreen.dart';
import 'package:mohally/Arabic/Screens/widgets/arabic_customSearchView.dart';
import 'package:mohally/core/app_export.dart';
import 'package:mohally/data/app_exceptions.dart';
import 'package:mohally/data/response/status.dart';
import 'package:mohally/view_models/controller/Home_controller.dart/ArabicHomeController.dart';
import 'package:mohally/widgets/Internet_exception_widget/internet_exception_widget.dart';
import 'package:mohally/widgets/app_bar/appbar_title.dart';
import 'package:mohally/widgets/app_bar/custom_app_bar.dart';
import 'package:mohally/widgets/custom_icon_button.dart';

int arabicselectedTabIndex = 0;

class CategoryScreen_arabic extends StatefulWidget {
  final bool showAppBar;
  final int arabicselectedTabIndex;
  final bool FromHomeToCat;

  const CategoryScreen_arabic(
      {Key? key,
      this.showAppBar = false,
      this.arabicselectedTabIndex = 0,
      this.FromHomeToCat = false})
      : super(key: key);
  @override
  State<CategoryScreen_arabic> createState() => _CategoryScreen_arabicState();
}

class _CategoryScreen_arabicState extends State<CategoryScreen_arabic> {
  File imgFile = File("");

  final imgPicker = ImagePicker();
  void openCamera(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();
  }

  //open camera
  void openCameraa(abc) async {
    var imgCamera = await imgPicker.pickImage(source: abc);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    arabicselectedTabIndex = widget.FromHomeToCat
        ? widget.arabicselectedTabIndex
        : arabicselectedTabIndex;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      pagecontroller = PageController(initialPage: arabicselectedTabIndex);
      _categoryByName.CategoryByNameApiHit(arabiccategoryId);
      homeView_controller.homeview_apihit();
    });
    super.initState();
  }

  PageController pagecontroller = PageController();
  ArabiccategorybyNameController _categoryByName =
      ArabiccategorybyNameController();
  ArabicHomeView_controller homeView_controller = ArabicHomeView_controller();
  TextEditingController searchController = TextEditingController();
  int selectedTabIndex = 0;
  int selectedIndex = 0;

  int pagesCount = 4;
  // @override
  // Widget build(BuildContext context) {
  //   final height = MediaQuery.of(context).size.height;
  //   // mediaQueryData = MediaQuery.of(context);
  //   return Obx(() {
  //     if (homeView_controller.rxRequestStatus.value == Status.LOADING) {
  //       return const Scaffold(
  //         body: Center(child: CircularProgressIndicator()),
  //       );
  //     } else {
  //       return SafeArea(
  //         child: Directionality(
  //           textDirection: TextDirection.rtl,
  //           child: Scaffold(
  //             resizeToAvoidBottomInset: false,
  //             appBar: _buildAppBar(context),
  //             body: RefreshIndicator(
  //               onRefresh: _refreshData,
  //               child: ListView(
  //                 physics: NeverScrollableScrollPhysics(),
  //                 // crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Center(
  //                       child:
  // Stack(children: [
  //                     CustomSearchView_arabic(
  //                       hintText: 'يبحث',
  //                       hintStyle: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.grey),
  //                       readOnly: true,
  //                       enableTap: true,
  //                     ),
  //                     // Positioned(
  //                     //     top: 20,
  //                     //     right: 240,
  //                     //     child: GestureDetector(
  //                     //         onTap: () {
  //                     //           _buildOncameraclick(context);
  //                     //         },
  //                     //         child:
  //                     //             Image.asset('assets/images/greycamera.png'))),
  //                   ])),
  //                   Gap(15),
  //                   Row(
  //                     // mainAxisAlignment: MainAxisAlignment.end,
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Padding(
  //                         padding: EdgeInsets.all(8),
  //                         child: Align(
  //                           alignment: Alignment.topRight,
  //                           child: Text(
  //                             "متميز",
  //                             style: theme.textTheme.titleMedium,
  //                           ),
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 45.0),
  //                         child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "تسوق حسب الاقسام",
  //                             style: theme.textTheme.titleLarge
  //                                 ?.copyWith(fontFamily: 'Almarai'),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Container(
  //                     width: double.infinity,
  //                     height: height,
  //                     child: Align(
  //                       alignment: Alignment.bottomLeft,
  //                       child: Row(
  //                         children: [
  //                           SizedBox(
  //                             width: 120,
  //                             child: ListView.separated(
  //                               itemCount: pagesCount,
  //                               itemBuilder: (context, int index) {
  //                                 return SizedBox(
  //                                   height: 5,
  //                                 );
  //                               },
  //                               separatorBuilder: (context, int index) {
  //                                 return GestureDetector(
  //                                   onTap: () {
  //                                     pagecontroller.animateToPage(index,
  //                                         duration: Duration(milliseconds: 500),
  //                                         curve: Curves.ease);
  //                                   },
  //                                   child: Container(
  //                                     child: Row(
  //                                       children: [
  //                                         AnimatedContainer(
  //                                           duration:
  //                                               Duration(milliseconds: 500),
  //                                           height: (selectedIndex == index)
  //                                               ? 50
  //                                               : 0,
  //                                           color: Color(0xffFF8300),
  //                                         ),
  //                                         Expanded(
  //                                             child: AnimatedContainer(
  //                                           duration:
  //                                               Duration(milliseconds: 500),
  //                                           height: 50,
  //                                           alignment: Alignment.center,
  //                                           color: (selectedIndex == index)
  //                                               ? Colors.orange.shade200
  //                                                   .withOpacity(0.2)
  //                                               : Colors.transparent,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.symmetric(
  //                                                     vertical: 10.0,
  //                                                     horizontal: 5),
  //                                             child: Text(
  //                                               featured_text[index],
  //                                               style: TextStyle(
  //                                                   fontFamily: 'Almarai'),
  //                                             ),
  //                                           ),
  //                                         ))
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 );
  //                               },
  //                             ),
  //                           ),
  //                           Expanded(
  //                               child: Padding(
  //                             padding: const EdgeInsets.all(8.0),
  //                             child: Container(
  //                               child: PageView(
  //                                 physics: NeverScrollableScrollPhysics(),
  //                                 controller: pagecontroller,
  //                                 onPageChanged: (index) {
  //                                   setState(() {
  //                                     selectedTabIndex = index;
  //                                   });
  //                                 },
  //                                 children: [
  //                                   //  for (var i = 0; i <= pagesCount; i++)
  //                                 ],
  //                               ),
  //                             ),
  //                           ))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }

  // int pagesCount = homeView_controller.userList.value.categoryData!.length;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Obx(() {
      switch (homeView_controller.rxRequestStatus.value) {
        case Status.LOADING:
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        case Status.ERROR:
          if (homeView_controller.error.value == 'No internet') {
            return InterNetExceptionWidget(onPress: () {});
          } else {
            return GeneralExceptionWidget(onPress: () {});
          }
        case Status.COMPLETED:
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: widget.showAppBar
                  ? AppBar(
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: CustomIconButton(
                            onTap: () {
                              Get.back();
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
                    )
                  : _buildAppBar(context),
              body: SafeArea(
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.h),
                    //   child: Center(
                    //     child:
                    // Stack(
                    //   children: [
                    //     // CustomSearchView(
                    //     //   readOnly: true,
                    //     //   enableTap: true,
                    //     //   controller: searchController,
                    //     //   hintText: "search",
                    //     // ),
                    //     SizedBox(
                    //       width: Get.width * .9,
                    //       //  width ?? double.maxFinite,
                    //       child: TextFormField(
                    //         onTap: () {
                    //           Get.to(CategorySearch());
                    //         },
                    //         style: CustomTextStyles.bodyLargeOnError_1,
                    //         readOnly: true,
                    //         decoration: InputDecoration(
                    //           hintText: 'Search',
                    //           hintStyle: CustomTextStyles.bodyLargeOnError_1,
                    //           // prefixIcon: Padding(
                    //           //   padding: EdgeInsets.all(
                    //           //     15.h,
                    //           //   ),
                    //           //   child: Icon(
                    //           //     Icons.search,
                    //           //     color: Colors.grey.shade600,
                    //           //   ),
                    //           // ),
                    //           // prefixIconConstraints: BoxConstraints(
                    //           //   maxHeight: 50.v,
                    //           // ),
                    //           suffixIcon: Container(
                    //             padding: EdgeInsets.all(15.h),
                    //             margin: EdgeInsets.only(
                    //               left: 30.h,
                    //             ),
                    //             decoration: BoxDecoration(
                    //               color: theme.colorScheme.primary,
                    //               borderRadius: BorderRadius.horizontal(
                    //                 right: Radius.circular(
                    //                   55.h,
                    //                 ),
                    //               ),
                    //             ),
                    //             child: CustomImageView(
                    //               imagePath:
                    //                   ImageConstant.imgSearchWhiteA70002,
                    //               height: 30.adaptSize,
                    //               width: 20.adaptSize,
                    //             ),
                    //           ),
                    //           suffixIconConstraints: BoxConstraints(
                    //             maxHeight: 60.v,
                    //           ),
                    //           isDense: true,
                    //           contentPadding: EdgeInsets.only(
                    //             left: 16.h,
                    //             top: 17.v,
                    //             bottom: 17.v,
                    //           ),
                    //           fillColor: appTheme.gray100,
                    //           filled: true,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30.h),
                    //             borderSide: BorderSide(
                    //               color: appTheme.gray300,
                    //               width: 1,
                    //             ),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30.h),
                    //             borderSide: BorderSide(
                    //               color: appTheme.gray300,
                    //               width: 1,
                    //             ),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(30.h),
                    //             borderSide: BorderSide(
                    //               color: appTheme.gray300,
                    //               width: 1,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //         top: 20,
                    //         left: 240,
                    //         child: GestureDetector(
                    //             onTap: () {
                    //               _buildOncameraclick(context);
                    //             },
                    //             child: Image.asset(
                    //                 'assets/images/greycamera.png'))),
                    //   ],
                    // ),
                    //   ),
                    // ),
                    Stack(children: [
                      CustomSearchView_arabic(
                        hintText: 'يبحث',
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                        readOnly: true,
                        enableTap: true,
                      ),
                      // Positioned(
                      //     top: 20,
                      //     right: 240,
                      //     child: GestureDetector(
                      //         onTap: () {
                      //           _buildOncameraclick(context);
                      //         },
                      //         child:
                      //             Image.asset('assets/images/greycamera.png'))),
                    ]),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "تسوق حسب الاقسام",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontFamily: 'Almarai'),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * .04,
                    ),
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height:
                            widget.FromHomeToCat ? Get.height : height * .69,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              Container(
                                // color: const Color.fromARGB(36, 158, 158, 158),
                                width: 120,
                                child: Column(
                                  children: [
                                    Container(
                                      height: widget.FromHomeToCat
                                          ? Get.height * .77
                                          : Get.height * .62,
                                      child: ListView.builder(
                                        itemCount: homeView_controller.userList
                                            .value.categoryData!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedTabIndex = index;
                                                arabiccategoryId =
                                                    homeView_controller
                                                        .userList
                                                        .value
                                                        .categoryData?[index]
                                                        .id!
                                                        .toString();

                                                _categoryByName
                                                    .CategoryByNameApiHit(
                                                        arabiccategoryId);
                                                pagecontroller.animateToPage(
                                                    selectedTabIndex,
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.ease);
                                              });
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: Get.height * .08,
                                                    width: Get.width * .3,
                                                    color: selectedTabIndex ==
                                                            index
                                                        ? Colors.white
                                                        : Color.fromARGB(
                                                            36, 158, 158, 158),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              Get.height * .08,
                                                          width:
                                                              Get.width * .02,
                                                          color:
                                                              selectedTabIndex ==
                                                                      index
                                                                  ? Color(
                                                                      0xffFF8300)
                                                                  : null,
                                                        ),
                                                        Container(
                                                          width: 100,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 5),
                                                            child: Text(
                                                              "${homeView_controller.userList.value.categoryData?[index].categoryName.toString()}",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF272727),
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Almarai',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(bottom: 50),
                                child: Container(
                                  child:
                                      // PageView(
                                      //   physics: NeverScrollableScrollPhysics(),
                                      //   controller: pagecontroller,
                                      //   onPageChanged: (index) {
                                      //     categoryId = homeView_controller
                                      //         .userList.value.categoryData?[index].id!
                                      //         .toString();

                                      //     // setState(() {
                                      //     //   widget.FromHomeToCat
                                      //     //       ? selectedTabIndex
                                      //     //       : selectedTabIndex = index;
                                      //     //   _categoryByName.CategoryByNameApiHit(
                                      //     //       categoryId);
                                      //     // });
                                      //     setState(() {
                                      //       widget.FromHomeToCat
                                      //           ? selectedTabIndex
                                      //           : selectedTabIndex = index;
                                      //       _categoryByName.CategoryByNameApiHit(
                                      //           categoryId);
                                      //       // Rebuild the PageView
                                      //       pagecontroller = PageController(
                                      //           initialPage: selectedTabIndex);
                                      //     });
                                      //   },
                                      //   children: [
                                      //     Container(
                                      //       child: Center(
                                      //           child: FeaturedCategoryScreen()),
                                      //     ),
                                      //   ],
                                      // ),
                                      PageView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: pagecontroller,
                                    itemCount: homeView_controller
                                        .userList.value.categoryData!.length,
                                    onPageChanged: (index) {
                                      // categoryId = homeView_controller
                                      //     .userList.value.categoryData?[index].id!
                                      //     .toString();

                                      setState(() {
                                        widget.FromHomeToCat
                                            ? selectedTabIndex
                                            : selectedTabIndex = index;
                                        _categoryByName.CategoryByNameApiHit(
                                            arabiccategoryId);
                                      });
                                    },
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Center(
                                          child: SubCategoryScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      }
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "فئات",
        margin: EdgeInsets.only(top: 10, right: 20),
      ),
    );
  }

  Widget buildGridView(String category) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 70,
                width: 70,
                child: Image.asset(
                  "assets/images/img_mask_group_60x56.png",
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 2.v),
            Center(
                child: Text(
              "للنساءملابس\n منحنى",
              style: theme.textTheme.bodySmall?.copyWith(fontFamily: 'Almarai'),
            ))
          ],
        );
      },
    );
  }

  Future _buildOncameraclick(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 17.v),
              decoration: AppDecoration.fillWhiteA.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgMaskGroup24x24,
                    height: 24.adaptSize,
                    width: 24.adaptSize,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 20.h),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 17.v),
                  Divider(thickness: 0.5, color: Colors.grey),
                  SizedBox(height: 15.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: "assets/images/blackcamera.png",
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 6.h,
                          top: 3.v,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: AlertDialog(
                                      backgroundColor: Color(0xFFFF8300),
                                      title: Text(
                                        "يختار",
                                        style: TextStyle(
                                            fontFamily: 'Almarai',
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      content: Row(
                                        children: [
                                          GestureDetector(
                                            child: Text(
                                              "آلة تصوير",
                                              style: TextStyle(
                                                  fontFamily: 'Almarai',
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            onTap: () {
                                              openCameraa(ImageSource.camera);
                                            },
                                          ),
                                          SizedBox(width: 80),
                                          GestureDetector(
                                            child: Text("صالة عرض",
                                                style: TextStyle(
                                                    fontFamily: 'Almarai',
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            onTap: () {
                                              openCameraa(ImageSource.gallery);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Text(
                            "تصوير",
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontFamily: 'Almarai'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 19.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: "assets/images/blackvideo.png",
                        height: 16.adaptSize,
                        width: 16.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          "اختر من الألبوم",
                          style: theme.textTheme.bodyLarge
                              ?.copyWith(fontFamily: 'Almarai'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 22.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: "assets/images/clock.png",
                        height: 18.adaptSize,
                        width: 18.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 6.h,
                          top: 3.v,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(SearchHistoryArabic());
                          },
                          child: Text(
                            "سجل البحث",
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontFamily: 'Almarai'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 17.v),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "يلغي",
                      style: TextStyle(
                        color: Color(0xFFFF8300),
                        fontSize: 16,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _navigateaftertapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 6:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 7:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      case 8:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoProductFound02()),
        );
        break;
      // Add more cases for other indices and screens
      // ...
    }
  }

  Future<void> _refreshData() async {
    // Implement the logic to refresh your data
    // You can make API calls or perform any other necessary operations
    // For now, let's simulate a delay using Future.delayed
    await Future.delayed(Duration(seconds: 2));

    // Update the UI or reload data
    setState(() {
      // Update any state variables or reload data here
    });
  }
}
