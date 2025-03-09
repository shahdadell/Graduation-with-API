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
