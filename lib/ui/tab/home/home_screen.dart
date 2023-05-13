import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/profile/constants.dart';
import '../../../../models/urgent.dart';
import '../../../../theme/app_color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/category.dart';
import '../widgets/home/header.dart';
import '../widgets/home/urgent_card.dart';

final List<Urgent> urgents = [];

Future getData() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response = await http.get(url);
  var responsebody = jsonDecode(response.body);
  print(responsebody["quotes"][1]["id"]);
  //return responsebody["quotes"];

// Make the HTTP GET request
  final response2 = await http.get(Uri.parse('http://example.com/api/urgents'));

/**FOR TEST */

  String test =
      '''
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
    "category": "Education",
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

  List<dynamic> jsonData = json.decode(test);
  urgents.clear();

  for (var data in jsonData) {
    double target = double.parse(data['target']);
    double remaining = double.parse(data['remaining']);
    double percent = ((target - remaining) / target) * 100;
    DateTime end_date = DateTime.parse(data['end_date']).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration remainingDuration = end_date.difference(currentDate);
    int days = remainingDuration.inDays;
    Urgent urgent = Urgent(
      title: data['title'],
      target: data['target'],
      percent:
          percent.toStringAsFixed(2), // Convert to string with 2 decimal places
      assetName: data['assetName'],
      category: data['category'],
      organizer: data['organizer'],
      remaining: data['remaining'],
      rate: double.parse(data['rate'].toString()),
      details: data['details'],
      end_date: data['end_date'],
      start_date: data['start_date'],
      days: days,
      tags: data['tags'],
    );

    urgents.add(urgent);
  }

/**FOR TEST */

  // if (response2.statusCode == 200) {
  //   // Parse the JSON response
  //   final jsonData = json.decode(response2.body);

  //   // Iterate over the parsed data and append to the urgents list
  //   for (var data in jsonData) {
  //     double target = double.parse(data['target']);
  //     double remaining = double.parse(data['remaining']);
  //     double percent = ((target - remaining) / target) * 100;
  //     DateTime end_date = DateTime.parse(data['end_date']).toLocal();
  //     DateTime currentDate = DateTime.now().toLocal();
  //     Duration remainingDuration = end_date.difference(currentDate);
  //     int days = remainingDuration.inDays;
  //     Urgent urgent = Urgent(
  //       title: data['title'],
  //       target: data['target'],
  //       percent: percent
  //           .toStringAsFixed(2), // Convert to string with 2 decimal places
  //       assetName: data['assetName'],
  //       category: data['category'],
  //       organizer: data['organizer'],
  //       remaining: data['remaining'],
  //       rate: double.parse(data['rate'].toString()),
  //       details: data['details'],
  //       end_date: data['end_date'],
  //       start_date: data['start_date'],
  //       days: days,
  //       tags: data['tags'],
  //     );

  //     urgents.add(urgent);
  //   }

  // }

  /*remove this comments*/
//   var url = Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/chair/data/55");
//   var response = await http.get(
//     url,
//     headers: {
//       'content-Type': 'application/json',
//       "Authorization": "Bearer ${constant.token}"
//     },
//   );

//   var data = json.decode(response.body);
//   print(data);
//  // var heartint = data["pulse_rate"];
  /*remove this comments*/
  return responsebody["quotes"];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController controller;
  int currentIndex = 0;
  final double oneCardWidth = 256.w;
  double position = 0;
  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      position = controller.offset;
      if ((position / oneCardWidth).floor() < 0) {
        return;
      }
      if (controller.offset == 0) {
        setState(() {
          currentIndex = 0;
        });
        return;
      }
      setState(() {
        currentIndex = (position / oneCardWidth).floor() + 1;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
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
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Header(),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: AppColor.kForthColor,
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                      ),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            'assets/images/mask_diamond.svg',
                            fit: BoxFit.fitWidth,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Change the world with',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  'your little help',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    minimumSize: MaterialStateProperty.all(
                                      Size(
                                        0,
                                        0,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Donate'),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Category(),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0.w,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Urgently Needed',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            urgents.length,
                            (index) => Row(
                              children: [
                                SizedBox(
                                  width: 2.w,
                                ),
                                Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    color: index == currentIndex
                                        ? AppColor.kAccentColor
                                        : AppColor.kPlaceholder1,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0.w,
                    ),
                    child: SingleChildScrollView(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 8.h,
                        right: 8.w,
                      ),
                      child: Row(
                        children: List.generate(
                          urgents.length,
                          (index) => Row(
                            children: [
                              UrgentCard(urgents[index]),
                              SizedBox(
                                width: 16.w,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
