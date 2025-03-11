import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/app_images/app_images.dart';
import 'package:graduation_project/home_screen/UI/homevariables.dart';
import 'package:graduation_project/home_screen/UI/homewidgets.dart';
import 'package:graduation_project/home_screen/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              homeTopBar(),
              searchField(w),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Special offer",
                  style: Theme.of(context).textTheme.bodyLarge,
                  // textStyle(20, FontWeight.w700, MyTheme.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CarouselSlider.builder(
                        itemCount: 4,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return carouselSliderImage(AppImages.offerimg);
                        },
                        options: CarouselOptions(
                          initialPage: 0,
                          viewportFraction: 1,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentindex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: AnimatedSmoothIndicator(
                        activeIndex: currentindex,
                        count: 4,
                        effect: SlideEffect(
                          activeDotColor: MyTheme.whiteColor,
                          dotColor: MyTheme.grayColor,
                          dotWidth: 85,
                          dotHeight: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: categories.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  TextAndImageClass item = categories[index];
                  return InkWell(
                    overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
                    onTap: () {},
                    child: Column(
                      children: [
                        Image.asset(
                          item.icon!,
                          height: 48,
                          width: 48,
                        ),
                        Text(
                          item.name!,
                          style: textStyle(
                              14, FontWeight.w600, MyTheme.blackColor),
                        )
                      ],
                    ),
                  );
                },
              ),
              horizontalListTitle("Discount guaranteed!"),
              horizontalList(Row1),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  width: 327,
                  height: 116,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(AppImages.chicken))),
                      ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(16)),
                          child: Image.asset(AppImages.discovershape)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                "Some interesting events of YUMMY FOOD",
                                textAlign: TextAlign.start,
                                style: textStyle(
                                  16,
                                  FontWeight.w700,
                                  MyTheme.whiteColor,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyTheme.whiteColor,
                              ),
                              child: Text(
                                "Discover",
                                style: textStyle(
                                    12, FontWeight.w600, MyTheme.blackColor),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              horizontalListTitle("What's delicious around here?"),
              horizontalList(Row2),
              horizontalDishesList(dishes),
              horizontalListTitle("Highlights of March"),
              horizontalList(Row3),
              horizontalListTitle("Nearby Restaurants"),
              horizontalRestaurantList(restaurants),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Recommended For You ",
                  style: textStyle(20, FontWeight.w700, MyTheme.blackColor),
                ),
              ),
              recommendedListView(recommendedList)
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation_project/Theme/theme.dart';
// import 'package:graduation_project/app_images/app_images.dart';
// import 'package:graduation_project/home_screen/UI/homewidgets.dart';
// import 'package:graduation_project/home_screen/UI/homevariables.dart';
// import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
// import 'package:graduation_project/home_screen/bloc/home_event.dart';
// import 'package:graduation_project/home_screen/bloc/home_state.dart';
// import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';
// import 'package:graduation_project/home_screen/data/repo/home_repo.dart';
// import 'package:graduation_project/home_screen/style.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// class HomeScreen extends StatefulWidget {
//   static const String routName = 'HomeScreen';
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     return BlocProvider(
//       create: (context) => HomeBloc()..add(FetchHomeDataEvent(HomeModelResponse())),
//  // جلب البيانات عند فتح الصفحة
//       child: Scaffold(
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 homeTopBar(),
//                 searchField(w),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Text(
//                     "Special offer",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Stack(
//                     alignment: Alignment.topCenter,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: CarouselSlider.builder(
//                           itemCount: 4,
//                           itemBuilder:
//                               (BuildContext context, int index, int realIndex) {
//                             return carouselSliderImage(AppImages.offerimg);
//                           },
//                           options: CarouselOptions(
//                             initialPage: 0,
//                             viewportFraction: 1,
//                             reverse: false,
//                             autoPlay: true,
//                             autoPlayInterval: const Duration(seconds: 3),
//                             autoPlayAnimationDuration:
//                                 const Duration(milliseconds: 800),
//                             scrollDirection: Axis.horizontal,
//                             onPageChanged: (index, reason) {
//                               setState(() {
//                                 currentindex = index;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 30),
//                         child: AnimatedSmoothIndicator(
//                           activeIndex: currentindex,
//                           count: 4,
//                           effect: SlideEffect(
//                             activeDotColor: MyTheme.whiteColor,
//                             dotColor: MyTheme.grayColor,
//                             dotWidth: 85,
//                             dotHeight: 4,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 /// 🔹 BlocBuilder لعرض الأقسام (Categories)
//                 BlocBuilder<HomeBloc, HomeState>(
//   builder: (context, state) {
//     if (state is FetchLoadingHomeDataState) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is FetchSuccessHomeDataState) {
//       return GridView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 4),
//         itemCount: state.categories.length,
//         shrinkWrap: true,
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
//             onTap: () {},
//             child: Column(
//               children: [
//                 Image.network(
//                   state.categories[index].categoriesImage ?? '',
//                   width: 48,
//                   height: 48,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return const Icon(Icons.broken_image, size: 48);
//                   },
//                 ),
//                 Text(
//                   state.categories[index].categoriesName ?? 'Unknown',
//                   style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//     } else if (state is HomeErrorState) {
//       return Center(child: Text("Error: ${state.message}"));
//     }
//     return const SizedBox.shrink();
//   },
// ),
//                 // BlocBuilder<HomeBloc, HomeState>(
//                 //   builder: (context, state) {
//                 //     if (state is FetchLoadingHomeDataState) {
//                 //       return Center(child: CircularProgressIndicator());
//                 //     } else if (state is FetchSuccessHomeDataState) {
//                 //       return GridView.builder(
//                 //         physics: const NeverScrollableScrollPhysics(),
//                 //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 //             crossAxisCount: 4),
//                 //         itemCount: state.categories.length,
//                 //         shrinkWrap: true,
//                 //         itemBuilder: (BuildContext context, int index) {
//                 //           return InkWell(
//                 //             overlayColor: WidgetStatePropertyAll(MyTheme.transparent),
//                 //             onTap: () {},
//                 //             child: Column(
//                 //               children: [
//                 //                 Icon(Icons.category, size: 48), // استبدال الصورة الثابتة
//                 //                 Text(
//                 //                   state.categories[index].categoriesName?? 'Unknown'
//                 //                   , style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
//                 //                 )
//                 //               ],
//                 //             ),
//                 //           );
//                 //         },
//                 //       );
//                 //     } else if (state is HomeErrorState) {
//                 //       return Center(child: Text("Error: ${state.message}"));
//                 //     }
//                 //     return SizedBox.shrink();
//                 //   },
//                 // ),

//                 horizontalListTitle("Discount guaranteed!"),

//                 /// 🔹 BlocBuilder لعرض المنتجات المخفضة
//                 BlocBuilder<HomeBloc, HomeState>(
//   builder: (context, state) {
//     if (state is FetchLoadingHomeDataState) {
//       return const Center(child: CircularProgressIndicator());
//     } else if (state is FetchSuccessHomeDataState) {
//       return ListView.builder(
//         shrinkWrap: true,
//         // scrollDirection: Axis.horizontal,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: state.items.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             leading: Image.network(
//               state.items[index].itemImage ?? '',
//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.broken_image, size: 50);
//               },
//             ),
//             title: Text(state.items[index].itemName ?? 'Unknown'),
//             subtitle: Text("Discount: ${state.items[index].itemDiscount}%"),
//           );
//         },
//       );
//     } else if (state is HomeErrorState) {
//       return Center(child: Text("Error: ${state.message}"));
//     }
//     return const SizedBox.shrink();
//   },
// ),
// //                 BlocBuilder<HomeBloc, HomeState>(
// //                   builder: (context, state) {
// //                     if (state is FetchLoadingHomeDataState) {
// //                       return Center(child: CircularProgressIndicator());
// //                     } else if (state is FetchSuccessHomeDataState) {
// //                       return ListView.builder(
// //                         shrinkWrap: true,
// //                         physics: NeverScrollableScrollPhysics(),
// //                         itemCount: state.items.length,
// //                         itemBuilder: (BuildContext context, int index) {
// //                           return ListTile(
// //                             title: Text(state.items[index].itemName ?? 'Unknown'
// // ),
// //                             subtitle: Text("Discount: ${state.items[index].itemDiscount}%"),
// //                           );
// //                         },
// //                       );
// //                     } else if (state is HomeErrorState) {
// //                       return Center(child: Text("Error: ${state.message}"));
// //                     }
// //                     return SizedBox.shrink();
// //                   },
// //                 ),

//                 horizontalListTitle("What's delicious around here?"),
//                 horizontalList(Row2),
//                 horizontalDishesList(dishes),
//                 horizontalListTitle("Highlights of March"),
//                 horizontalList(Row3),
//                 horizontalListTitle("Nearby Restaurants"),
//                 horizontalRestaurantList(restaurants),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     "Recommended For You ",
//                     style: textStyle(20, FontWeight.w700, MyTheme.blackColor),
//                   ),
//                 ),
//                 recommendedListView(recommendedList)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
  // ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: state.items.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return Container(
                          //       width: 160,
                          //       margin: const EdgeInsets.symmetric(horizontal: 8),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(12),
                          //         color: Colors.white,
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.grey.withOpacity(0.2),
                          //             blurRadius: 5,
                          //             spreadRadius: 2,
                          //           )
                          //         ],
                          //       ),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               ClipRRect(
                          //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          //                 child: Image.network(
                          //                   state.items[index].itemImage ?? '',
                          //                   height: 100,
                          //                   width: double.infinity,
                          //                   fit: BoxFit.cover,
                          //                   errorBuilder: (context, error, stackTrace) {
                          //                     return Container(
                          //                       height: 100,
                          //                       color: Colors.grey,
                          //                       child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //               Positioned(
                          //                 top: 8,
                          //                 left: 8,
                          //                 child: Container(
                          //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //                   decoration: BoxDecoration(
                          //                     color: Colors.black.withOpacity(0.6),
                          //                     borderRadius: BorderRadius.circular(8),
                          //                   ),
                          //                   child: Text(
                          //                     "${state.items[index].itemDiscount}% off",
                          //                     style: const TextStyle(color: Colors.white, fontSize: 12),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               state.items[index].itemName ?? 'Unknown',
                          //               style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),  // ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: state.items.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return Container(
                          //       width: 160,
                          //       margin: const EdgeInsets.symmetric(horizontal: 8),
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(12),
                          //         color: Colors.white,
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.grey.withOpacity(0.2),
                          //             blurRadius: 5,
                          //             spreadRadius: 2,
                          //           )
                          //         ],
                          //       ),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               ClipRRect(
                          //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          //                 child: Image.network(
                          //                   state.items[index].itemImage ?? '',
                          //                   height: 100,
                          //                   width: double.infinity,
                          //                   fit: BoxFit.cover,
                          //                   errorBuilder: (context, error, stackTrace) {
                          //                     return Container(
                          //                       height: 100,
                          //                       color: Colors.grey,
                          //                       child: const Icon(Icons.broken_image, size: 50, color: Colors.white),
                          //                     );
                          //                   },
                          //                 ),
                          //               ),
                          //               Positioned(
                          //                 top: 8,
                          //                 left: 8,
                          //                 child: Container(
                          //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          //                   decoration: BoxDecoration(
                          //                     color: Colors.black.withOpacity(0.6),
                          //                     borderRadius: BorderRadius.circular(8),
                          //                   ),
                          //                   child: Text(
                          //                     "${state.items[index].itemDiscount}% off",
                          //                     style: const TextStyle(color: Colors.white, fontSize: 12),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Text(
                          //               state.items[index].itemName ?? 'Unknown',
                          //               style: textStyle(14, FontWeight.w600, MyTheme.blackColor),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     );
                          //   },
                          // ),