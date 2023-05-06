import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../theme/app_animation.dart';
import '../../../../theme/app_color.dart';
import '../widgets/category.dart';
import '../widgets/search/intro_card.dart';
import '../widgets/search/result_card.dart';
import '../widgets/search/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final List<dynamic> results = [
  '',
  '',
  '',
  '',
];

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getData();
    controller = TextEditingController();
    super.initState();
  }

  Future<List<dynamic>> getData() async {
    var url = Uri.parse("https://dummyjson.com/quotes");
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    print(responsebody["quotes"][1]);
    return responsebody["quotes"];
  }

  late final TextEditingController controller;
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            32.r,
          ),
          bottomRight: Radius.circular(
            32.r,
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: AnimatedSwitcher(
                  duration: AppAnimation.kAnimationDuration,
                  switchInCurve: AppAnimation.kAnimationCurve,
                  switchOutCurve: Curves.easeInOutBack,
                  child: !isSearching
                      ? Text(
                          'Explore',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      : Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSearching = false;
                                });
                              },
                              child: SizedBox(
                                width: 24.w,
                                child: SvgPicture.asset(
                                  'assets/images/back.svg',
                                  width: 24.w,
                                  color: AppColor.kTitle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Search Result',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: AppColor.kTitle,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: 24.w,
                            )
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SearchBar(
                  controller: controller,
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  hintText: 'Search by name...',
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              !isSearching ? _buildSearching(context) : _buildResult()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    return FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Showing search result \'${controller.text}\'',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  ...List.generate(
                    //results.length,
                    snapshot.data!.length,
                    (index) => Column(
                      children: [
                        ResultCard(
                          //results[index],
                          assetName: 'assets/images/image_placeholder.svg',
                          categories: ['Children', 'Education'],
                          days: 13,
                          desc: 'this is more info about the project',
                          organizer: 'Organizer',
                          people: 50,
                          percent: '70',
                          remaining: '300.00',
                          target: '700.00',
                          title: 'Title',
                        ),
                        SizedBox(
                          height: 32.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildSearching(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Category(),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return IntroCard(
                                title: 'Title',
                                category: 'Category',
                                Owner: 'Qwner',
                                Date: (DateTime(2023, 5, 4)));
                          }),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
