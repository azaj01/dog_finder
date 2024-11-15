import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../common/routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/constants.dart';
import '../../gen/assets.gen.dart';
import '../../global_config/global.dart';
import '../main/widgets/splash_single_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController pageController = PageController();
  var currentPage = 0;

  List<Widget> pages = [
    singleSplashPage(
      imgUrl: Assets.images.sp1.path,
      title: 'Page One',
      description: 'Lorem ipsum dolor sit amet consecrate adipisicing elite.',
    ),
    singleSplashPage(
      imgUrl: Assets.images.sp2.path,
      title: 'Page Two',
      description: 'Lorem ipsum dolor sit amet consecrate adipisicing elite. ',
    ),
    singleSplashPage(
      imgUrl: Assets.images.sp3.path,
      title: 'Page Three',
      description: 'Lorem ipsum dolor sit amet consecrate adipisicing elite. ',
    ),
  ];

// next slide
  void next() {
    pageController.animateToPage(
      currentPage + 1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

// launch app
  void launch() {
    Global.storageService.setBoolValue(AppConstants.isAppPreviouslyRan, true);
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.homeScreen,
      (route) => false,
    );
  }

// skip slides
  void skip() {
    pageController.animateToPage(
      pages.length - 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          currentPage != pages.length - 1
              ? TextButton(
                  onPressed: () => skip(),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.paddingOf(context).top,
          left: 18,
          right: 18,
        ),
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          controller: pageController,
          children: pages,
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmoothPageIndicator(
              controller: pageController,
              count: pages.length,
              effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                  width: 25,
                  height: 3,
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                dotDecoration: DotDecoration(
                  width: 25,
                  height: 3,
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor),
              onPressed: () =>
                  currentPage != pages.length - 1 ? next() : launch(),
              child: Text(
                currentPage != pages.length - 1 ? 'Next' : 'Launch',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
