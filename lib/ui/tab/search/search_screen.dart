import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/models/result.dart';
import 'dart:convert';
import '../../../../theme/app_animation.dart';
import '../../../../theme/app_color.dart';
import '../widgets/category.dart';
import '../widgets/search/intro_card.dart';
import '../widgets/search/result_card.dart';
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

    controller = TextEditingController();
    super.initState();
  }

  Future getData() async {
//     var url = Uri.parse("https://dummyjson.com/quotes");
//     var response = await http.get(url);
//     var responsebody = jsonDecode(response.body);
//     print(responsebody["quotes"][1]["id"]);
//     //return responsebody["quotes"];

// // Make the HTTP GET request
//     final response2 =
//         await http.get(Uri.parse('http://example.com/api/urgents'));

/**FOR TEST */

    String test = '''
    [
      {    "title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Education",
    "organizer": "Organizer",
    "remaining": "250.00",
    "rate": "0.0",
    "details": "details",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
      {"title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Animal",
    "organizer": "Organizer",
    "remaining": "250.00",
    "rate": "0.0",
    "details": "details",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
      {"title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Education",
    "organizer": "Organizer",
    "remaining": "200.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
    {"title": "Zahraa",
    "target": "1000.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Health",
    "organizer": "Organizer",
    "remaining": "100.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
    {"title": "Help The environment",
    "target": "1000.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Environment",
    "organizer": "Organizer",
    "remaining": "100.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"}
    ]
  '''; // Example JSON data

//     List<dynamic> jsonData = json.decode(test);
//     results.clear();
//     specificresults.clear();

//     for (var data in jsonData) {
//       double target = double.parse(data['target']);
//       double remaining = double.parse(data['remaining']);
//       double percent = ((target - remaining) / target) * 100;
//       DateTime end_date = DateTime.parse(data['end_date']).toLocal();
//       DateTime currentDate = DateTime.now().toLocal();
//       Duration remainingDuration = end_date.difference(currentDate);
//       int days = remainingDuration.inDays;
//       Result result = Result(
//         title: data['title'],
//         target: data['target'],
//         percent: percent
//             .toStringAsFixed(2), // Convert to string with 2 decimal places
//         assetName: data['assetName'],
//         category: data['category'],
//         organizer: data['organizer'],
//         remaining: data['remaining'],
//         rate: double.parse(data['rate'].toString()),
//         details: data['details'],
//         end_date: data['end_date'],
//         start_date: data['start_date'],
//         days: days,
//         tags: data['tags'],
//       );

//       results.add(result);

// // Access the filtered results

//       if (result.category == charityform.specificCategory) {
//         specificresults.add(result);
//       }
//     }
/**FOR TEST */
    final response2 = await http.get(
        Uri.parse('https://02f3-197-134-102-115.ngrok-free.app/api/projects/'));

    if (response2.statusCode == 200) {
      // Parse the JSON response
      final jsonData = json.decode(response2.body);
      print(jsonData);

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
          title: data['title'],
          target: target2,
          percent: percent
              .toStringAsFixed(2), // Convert to string with 2 decimal places
          assetName: data['img_url']['image'],
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
                    ? buildcategory()
                    : SizedBox(
                        height: 10,
                      ),
                // Category(onTap: () {
                //   setState(() {
                //     _buildSearching(context);
                //   });
                // }),
                !isSearching ? _buildSearching(context) : _buildResult()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getData2() async {
    // var url = Uri.parse("https://dummyjson.com/quotes");
    // var response = await http.get(url);
    // var responsebody = jsonDecode(response.body);
    // print(responsebody["quotes"][1]["id"]);
    //return responsebody["quotes"];

// Make the HTTP GET request

/**FOR TEST */

    String test = '''
    [
      {    "title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Education",
    "organizer": "Organizer",
    "remaining": "250.00",
    "rate": "0.0",
    "details": "details",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
      {"title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Animal",
    "organizer": "Organizer",
    "remaining": "250.00",
    "rate": "0.0",
    "details": "details",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
      {"title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Education",
    "organizer": "Organizer",
    "remaining": "200.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
    {"title": "Zahraa",
    "target": "1000.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Health",
    "organizer": "Organizer",
    "remaining": "100.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"},
    {"title": "Help The environment",
    "target": "1000.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Environment",
    "organizer": "Organizer",
    "remaining": "100.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"}
    ]
  '''; // Example JSON data

//     List<dynamic> jsonData = json.decode(test);
//     results2.clear();
//     specificresults2.clear();

//     for (var data in jsonData) {
//       double target = double.parse(data['target']);
//       double remaining = double.parse(data['remaining']);
//       double percent = ((target - remaining) / target) * 100;
//       DateTime end_date = DateTime.parse(data['end_date']).toLocal();
//       DateTime currentDate = DateTime.now().toLocal();
//       Duration remainingDuration = end_date.difference(currentDate);
//       int days = remainingDuration.inDays;
//       Result result2 = Result(
//         title: data['title'],
//         target: data['target'],
//         percent: percent
//             .toStringAsFixed(0), // Convert to string with 2 decimal places
//         assetName: data['assetName'],
//         category: data['category'],
//         organizer: data['organizer'],
//         remaining: data['remaining'],
//         rate: double.parse(data['rate'].toString()),
//         details: data['details'],
//         end_date: data['end_date'],
//         start_date: data['start_date'],
//         days: days,
//         tags: data['tags'],
//       );

//       results2.add(result2);

// // Access the filtered results

//       if (result2.category == charityform.specificCategory) {
//         specificresults.add(result2);
//       }
//     }

/**FOR TEST */
    final response3 = await http.get(Uri.parse(
        'https://02f3-197-134-102-115.ngrok-free.app/api/projects/?search=${controller.text}'));

    if (response3.statusCode == 200) {
      // Parse the JSON response
      final jsonData = json.decode(response3.body);
      print(jsonData);

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
          target: target2,
          percent: percent.toString(),
          assetName: data['img_url']['image'],
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

  Widget buildcategory() {
    return Category(onTap: () {
      setState(() {
        _buildSearching(context);
      });
    });
  }

  Widget _buildSearching(BuildContext context) {
    return //FutureBuilder<List<dynamic>>(
        FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Column(
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
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
  }
}
