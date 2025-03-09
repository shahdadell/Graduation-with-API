import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/app_images/app_images.dart';
import 'package:graduation_project/home_screen/UI/homewidgets.dart';
import 'package:graduation_project/home_screen/UI/homevariables.dart';
import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/home_event.dart';
import 'package:graduation_project/home_screen/bloc/home_state.dart';
import 'package:graduation_project/home_screen/data/model/home_model_response/home_model_response.dart';
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
    return BlocProvider(
      create: (context) =>
          HomeBloc()..add(FetchHomeDataEvent(HomeModelResponse())),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                homeTopBar(),
                searchField(w),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: horizontalListTitle("Special Offer"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      CarouselSlider.builder(
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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is FetchLoadingHomeDataState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchSuccessHomeDataState) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4),
                        itemCount: state.categories.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            overlayColor:
                                WidgetStatePropertyAll(MyTheme.transparent),
                            onTap: () {},
                            child: Column(
                              children: [
                                ClipRRect(
                                  child: Image.network(
                                    state.categories[index].categoriesImage ??
                                        '',
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.broken_image,
                                          size: 48);
                                    },
                                  ),
                                ),
                                Text(
                                  state.categories[index].categoriesName ??
                                      'Unknown',
                                  style: textStyle(
                                      14, FontWeight.w600, MyTheme.blackColor),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is HomeErrorState) {
                      return Center(child: Text("Error: ${state.message}"));
                    }
                    return const SizedBox.shrink();
                  },
                ),
                horizontalListTitle("Discount guaranteed!"),
                const SizedBox(height: 20),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is FetchLoadingHomeDataState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchSuccessHomeDataState) {
                      return SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.items.length,
                            itemBuilder: (context, index) {
                              final item = state.items[index];

                              return Container(
                                width: 180,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    )
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(12)),
                                            child: Image.network(
                                              item.itemImage ?? '',
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  height: 500,
                                                  color: Colors.grey,
                                                  child: const Icon(
                                                      Icons.broken_image,
                                                      size: 50,
                                                      color: Colors.white),
                                                );
                                              },
                                            ),
                                          ),
                                          if (item.itemDiscount != null &&
                                              item.itemDiscount != "0")
                                            Positioned(
                                              top: 8,
                                              left: 8,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "${item.itemDiscount}% off",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.itemName ?? 'Unknown',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Price: ${item.itemPrice ?? 'N/A'} EGP",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green),
                                            ),
                                            Text(
                                              "Rating: ⭐ ${item.itemRating ?? 'N/A'}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.orangeAccent),
                                            ),
                                            Text(
                                              "📍 ${item.itemLocation ?? 'Unknown'}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey),
                                            ),
                                            Text(
                                              "📞 ${item.itemPhone ?? 'No Contact'}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
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
                          // ),
                          );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
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
