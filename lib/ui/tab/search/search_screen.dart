import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/models/result.dart';
import 'dart:convert';
import '../../constants.dart';
import '../../../../theme/app_animation.dart';
import '../../../../theme/app_color.dart';
import '../widgets/category.dart';
import 'intro_card.dart';
import 'result_card.dart';
import '../widgets/search/search_bar.dart';
import '/initials/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen();

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

final List<dynamic> results = [];

final List<dynamic> specificresults = [];

final List<dynamic> results2 = [];

final List<dynamic> specificresults2 = [];

String specificCategory =
    'Education'; // Replace 'exampleCategory' with the desired category value

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();

    fetchData(); // Call the fetchData() method

    controller = TextEditingController(); // Initialize the controller
  }

  @override
  void dispose() {
    controller.dispose(); // Dispose the controller
    super.dispose();
  }

  void fetchData() async {
    List<dynamic> specificResults = await getData(charityform.specificCategory);

    if (mounted) {
      // Check if the widget is still mounted before calling setState()
      setState(() {
        // Update the state with the fetched data
        // Perform any other necessary state updates
      });
    }
  }

  Widget buildCategory() {
    return Category(onTap: () {
      fetchData();
    });
  }

  Future getData(String category) async {
    try {
      /**FOR TEST */
      final response2 = await http
          .get(Uri.parse('${constant.server}api/projects/$category/filter'));

      if (response2.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response2.body);
        // Clear the specificurgents list before starting the loop
        specificresults.clear();

        // Iterate over the parsed data and append to the urgents list
        for (var data in jsonData) {
          int target = data['target_amount'];
          String target2 = data['target_amount'].toString();
          int current_amount = data['current_amount'];
          int remaining = ((target - current_amount));
          double percent = ((target - remaining) / target) * 100;
          DateTime end_date = DateTime.parse(data['end_date']).toLocal();
          DateTime currentDate = DateTime.now().toLocal();
          Duration remainingDuration = end_date.difference(currentDate);
          int days = remainingDuration.inDays;
          Result urgent = Result(
            id: data['id'],
            title: data['title'],
            target: target2,
            percent: percent
                .toStringAsFixed(2), // Convert to string with 2 decimal places
            assetName: data['image'],
            userimage: data['user_image'],
            category: data['category'],
            organizer: data['created_by'],
            remaining: remaining.toString(),
            rate: double.parse(data['rate']['avg_rate'].toString()),
            details: data['details'],
            end_date: data['end_date'],
            start_date: data['start_date'],
            days: days,
            tags: data['tags'],
          );

          if (urgent.category == charityform.specificCategory) {
            results.add(urgent);
            specificresults.add(urgent);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return specificresults;
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  child: searchBarWidget(
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
                !isSearching
                    ? buildCategory()
                    : SizedBox(
                        height: 10,
                      ),
                !isSearching ? _buildSearching(context) : _buildResult()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getData2() async {
    try {
/**FOR TEST */
      final response3 = await http.get(Uri.parse(
          'https://kickfunding.herokuapp.com/api/projects/?search=${controller.text}'));

      if (response3.statusCode == 200) {
        // Parse the JSON response
        final jsonData = json.decode(response3.body);
        // Clear the specificurgents list before starting the loop
        specificresults2.clear();

        // Iterate over the parsed data and append to the urgents list
        for (var data in jsonData) {
          int target = data['target_amount'];
          String target2 = data['target_amount'].toString();
          int current_amount = data['current_amount'];
          int remaining = ((target - current_amount));
          int percent = ((target - remaining) * 100 ~/ target);
          DateTime end_date = DateTime.parse(data['end_date']).toLocal();
          DateTime currentDate = DateTime.now().toLocal();
          Duration remainingDuration = end_date.difference(currentDate);
          int days = remainingDuration.inDays;
          Result result2 = Result(
            title: data['title'],
            id: data['id'],
            target: target2,
            percent: percent.toString(),
            assetName: data['image'],
            userimage: data['user_image'],
            category: data['category'],
            organizer: data['created_by'],
            remaining: remaining.toString(),
            rate: double.parse(data['rate']['avg_rate'].toString()),
            details: data['details'],
            end_date: data['end_date'],
            start_date: data['start_date'],
            days: days,
            tags: data['tags'],
          );

          specificresults2.add(result2);
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return specificresults2;
  }

  Widget _buildResult() {
    return FutureBuilder(
        future: getData2(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      //   horizontal: 16.0.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: specificresults2.length,
                            itemBuilder: (context, i) {
                              return ResultCard(specificresults2[i]);
                            }),
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
    return specificresults.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        itemCount: specificresults.length,
                        itemBuilder: (context, i) {
                          return IntroCard(specificresults[i]);
                        }),
                  ],
                ),
              ),
            ],
          );
  }
}
