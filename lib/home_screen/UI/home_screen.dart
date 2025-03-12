import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/app_images/app_images.dart';
import 'package:graduation_project/home_screen/UI/homewidgets.dart';
import 'package:graduation_project/home_screen/UI/homevariables.dart';
import 'package:graduation_project/home_screen/UI/service_for_category.dart';
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
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Special Offer",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is FetchLoadingHomeDataState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is FetchSuccessHomeDataState) {
                            return CarouselSlider.builder(
                              itemCount: state.items.length,
                              itemBuilder: (BuildContext context, int index,
                                  int realIndex) {
                                final item = state.items[index];
                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        item.itemsImage ?? '',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Container(
                                            color: Colors.grey[300],
                                            child: const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey,
                                            child: const Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: Colors.white),
                                          );
                                        },
                                      ),
                                    ),
                                    if (item.itemsDiscount != null &&
                                        item.itemsDiscount != 0)
                                      Positioned(
                                        bottom: 8,
                                        right: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            "${item.itemsDiscount}% OFF",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                              options: CarouselOptions(
                                initialPage: 1,
                                viewportFraction: 1,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 1000),
                                scrollDirection: Axis.horizontal,
                              ),
                            );
                          } else {
                            return const Center(
                                child: Text("Error loading images"));
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
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
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: state.categories.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServicesScreen(
                                    categoryId: state
                                        .categories[index].categoriesId
                                        .toString(),
                                    categoryName: state
                                            .categories[index].categoriesName ??
                                        'Unknown',
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Colors.purpleAccent,
                                        Colors.deepPurpleAccent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.15),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.network(
                                      state.categories[index].categoriesImage ??
                                          '',
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.broken_image,
                                              size: 35, color: Colors.white),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  state.categories[index].categoriesName ??
                                      'Unknown',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Discount guaranteed!",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 15),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(12)),
                                          child: Image.network(
                                            item.itemsImage ?? '',
                                            height: 120,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                height: 120,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      size: 50,
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        if (item.itemsDiscount != null &&
                                            item.itemsDiscount != 0)
                                          Positioned(
                                            top: 8,
                                            left: 0,
                                            child: ClipPath(
                                              clipper: RibbonClipper(),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4,
                                                        horizontal: 12),
                                                color: Colors.redAccent
                                                    .withOpacity(0.9),
                                                child: Text(
                                                  "${item.itemsDiscount}% OFF",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
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
                                            item.itemsName ?? 'Unknown',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Price: ${item.itemsPrice ?? 'N/A'} EGP",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.star,
                                                      size: 14,
                                                      color:
                                                          Colors.orangeAccent),
                                                  Text(
                                                    item.serviceRating
                                                            ?.toString() ??
                                                        'N/A', // تحويل serviceRating لـ String
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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

class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - 10, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - 10, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
