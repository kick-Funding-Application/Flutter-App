import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../routes/routes.dart';
import '../../../theme/app_color.dart';
import 'home/home_screen.dart';
import 'profile/proflle_screen.dart';
import 'search/search_screen.dart';
import 'swap/swap_screen.dart';

final List<Widget> pages = [
  HomeScreen(),
  SearchScreen(),
  Scaffold(
    backgroundColor: AppColor.kForthColor,
  ),
  SwapScreen(),
  ProfileScreen(),
];

class TabScreen extends StatefulWidget {
  const TabScreen();

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late int tabIndex;
  late PageController pageController;

  @override
  void initState() {
    tabIndex = 0;
    pageController = PageController(initialPage: tabIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose(); // Dispose the PageController
    super.dispose();
  }

  void navigateToTab(int index) async {
    setState(() {
      tabIndex = index;
    });
    if (index == 2) {
      await Navigator.of(context).pushNamed(RouteGenerator.startCharity);

      setState(() {
        tabIndex = 0;
      });
    }
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve:
          Curves.easeInCubic, // Use Curves.easeOutCubic for a faded animation
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          iconSize: 24.w,
          backgroundColor: AppColor.kForthColor,
          currentIndex: tabIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: navigateToTab, // Modify the onTap callback
          // (index) async {
          //   setState(() {
          //     tabIndex = index;
          //   });
          //   if (index == 2) {
          //     await Navigator.of(context)
          //         .pushNamed(RouteGenerator.startCharity);

          //     setState(() {
          //       tabIndex = 0;
          //     });
          //   }
          // },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          enableFeedback: true,
          items: [
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kTitle.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/category.svg',
                    width: 24.w,
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/category.svg',
                width: 24.w,
                color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kTitle.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/search.svg',
                    width: 24.w,
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/search.svg',
                width: 24.w,
                color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kAccentColor,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/add.svg',
                    width: 24.w,
                  ),
                ),
              ),
              label: '',
              icon: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.kAccentColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.kAccentColor.withOpacity(0.6),
                        offset: Offset(
                          0,
                          2.h,
                        ),
                        blurRadius: 5,
                      )
                    ]),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/add.svg',
                    width: 24.w,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kTitle.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/swap.svg',
                    width: 24.w,
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/swap.svg',
                width: 24.w,
                color: AppColor.kTextColor1,
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.kTitle.withOpacity(0.5),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/profile.svg',
                    width: 24.w,
                    color: Colors.white,
                  ),
                ),
              ),
              label: '',
              icon: SvgPicture.asset(
                'assets/images/profile.svg',
                width: 24.w,
                color: AppColor.kTextColor1,
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: PageView(
          controller: pageController, // Use the PageController
          onPageChanged: (index) {
            setState(() {
              tabIndex = index;
            });
          },
          children: pages,
        ),
      ),
    );
  }
}
