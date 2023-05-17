import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/models/donator.dart';
import 'package:kickfunding/ui/tab/charity/start_charity_screen.dart';
import 'package:kickfunding/ui/tab/search/search_screen.dart';
import 'package:kickfunding/ui/tab/widgets/swap/donators.dart';
import 'dart:convert';
import '../../../../auth/login_form.dart';
import '../../../../bloc/swap/swap_bloc.dart';
import '../../../../models/donation.dart';
//import '../../../../models/donator.dart';
import '../../../../models/result.dart';
import '../../../../theme/app_color.dart';

import 'charity_card.dart';
import 'donationscard.dart';

List<Widget> contents = [DonationContent(), CharityContent()];

class PageContent extends StatelessWidget {
  const PageContent();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: BlocProvider.of<SwapBloc>(context).state.controller,
      itemCount: contents.length,
      onPageChanged: (index) {
        BlocProvider.of<SwapBloc>(context).add(SetSwap(index == 0));
      },
      itemBuilder: (_, index) => contents[index],
    );
  }
}

class CharityContent extends StatefulWidget {
  const CharityContent();

  @override
  _CharityContentState createState() => _CharityContentState();
}

final List<dynamic> myprojects = [];

Future getData() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response = await http.get(url);
  var responsebody = jsonDecode(response.body);
  print(responsebody["quotes"][1]["id"]);
  //return responsebody["quotes"];

// Make the HTTP GET request

/**FOR TEST */

  String test =
      '''
    [
      {    "title": "Title of project",
    "target": "500.00",
    "percent": "50",
    "assetName": "assets/images/image_placeholder.svg",
    "category": "Education",
     "organizer": "organizer",
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
     "organizer": "organizer",
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
     "organizer": "organizer",
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
     "organizer": "organizer",
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
    "organizer": "organizer",
    "remaining": "100.00",
    "rate": "0.0",
    "details": "details..",
    "end_date": "2024-05-26",
    "start_date": "2022-02-01",
    "days": "10",
    "tags": "help"}
    ]
  '''; // Example JSON data

  // List<dynamic> jsonData = json.decode(test);
  // myprojects.clear();

  // for (var data in jsonData) {
  //   double target = double.parse(data['target']);
  //   double remaining = double.parse(data['remaining']);
  //   double percent = ((target - remaining) / target) * 100;
  //   DateTime end_date = DateTime.parse(data['end_date']).toLocal();
  //   DateTime currentDate = DateTime.now().toLocal();
  //   Duration remainingDuration = end_date.difference(currentDate);
  //   int days = remainingDuration.inDays;
  //   Result result = Result(
  //     userimage:
  //         'https://th.bing.com/th/id/OIP.OF59vsDmwxPP1tw7b_8clQHaE8?pid=ImgDet&rs=1',
  //     title: data['title'],
  //     target: data['target'],
  //     percent:
  //         percent.toStringAsFixed(0), // Convert to string with 2 decimal places
  //     assetName: data['assetName'],
  //     category: data['category'],
  //     organizer: data['organizer'],
  //     remaining: data['remaining'],
  //     rate: double.parse(data['rate'].toString()),
  //     details: data['details'],
  //     end_date: data['end_date'],
  //     start_date: data['start_date'],
  //     days: days,
  //     tags: data['tags'],
  //   );

  //   myprojects.add(result);

// Access the filtered results

/**FOR TEST */
  var url2 = Uri.parse(
      "https://kickfunding-backend.herokuapp.com/api/dj-rest-auth/user/projects");
  var response2 = await http.get(
    url2,
    headers: {
      'content-Type': 'application/json',
      "Authorization": " Token ${token}"
    },
  );

  if (response2.statusCode == 200) {
    // Parse the JSON response
    final jsonData = json.decode(response2.body);
    print(jsonData);

    // Clear the specificurgents list before starting the loop
    myprojects.clear();

    // Iterate over the parsed data and append to the urgents list
    for (var data in jsonData) {
      int target = data['target_amount'];
      String target2 = data['target_amount'].toString();
      int current_amount = data['current_amount'];
      int remaining = ((target - current_amount));
      double percent;
      if (target == 0) {
        percent = 0;
      } else {
        percent = ((target - remaining) / target) * 100;
      }

      DateTime end_date = DateTime.parse(data['end_date']).toLocal();
      DateTime currentDate = DateTime.now().toLocal();
      Duration remainingDuration = end_date.difference(currentDate);
      int days = remainingDuration.inDays;
      Result result = Result(
        userimage:
            'https://th.bing.com/th/id/OIP.OF59vsDmwxPP1tw7b_8clQHaE8?pid=ImgDet&rs=1',
        title: data['title'],
        target: target2,
        percent: percent
            .toStringAsFixed(0), // Convert to string with 2 decimal places
        assetName: data['image'],
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

      myprojects.add(result);
    }
  }
  return myprojects;
}

class _CharityContentState extends State<CharityContent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(), // Replace with your async operation or future
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: BlocBuilder<SwapBloc, SwapState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      state.isDetail
                          ? DonatorContent()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  //horizontal: 16.0.w,
                                  ),
                              child: Column(
                                children: [
                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: myprojects.length,
                                      itemBuilder: (context, i) {
                                        return CharityCard(myprojects[i]);
                                      }),
                                ],
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class DonationContent extends StatefulWidget {
  const DonationContent();

  @override
  State<DonationContent> createState() => _DonationContentState();
}

final List<dynamic> mydonations = [];
Future getData2() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response2 = await http.get(url);
  var responsebody = jsonDecode(response2.body);
  print(responsebody["quotes"][1]["id"]);
  //return responsebody["quotes"];

// Make the HTTP GET request
  final response3 = await http.get(Uri.parse('http://example.com/api/urgents'));

/**FOR TEST */

  String test2 =
      '''
    [
      {"organization": "project",
      "desc": "description",
      "total": "100",
      "date":"2023-05-01"
      },
      {"organization": "project",
      "desc": "description",
      "total": "100",
      "date":"2023-05-01"
      },
      {"organization": "project",
      "desc": "description",
      "total": "100",
      "date":"2023-05-01"
      },
      {"organization": "project",
      "desc": "description",
      "total": "100",
      "date":"2023-05-01"
      },
      {"organization": "project",
      "desc": "description",
      "total": "100",
      "date":"2023-05-01"
      }
    ]
  ''';

  List<dynamic> jsonData = json.decode(test2);
  mydonations.clear();

  for (var data in jsonData) {
    Donation mydonation = Donation(
      date: data["date"],
      desc: data["desc"],
      organization: data["organization"],
      total: data["total"],
    );
    print(mydonation);
    mydonations.add(mydonation);
  }

/**FOR TEST */

  // if (response2.statusCode == 200) {
  //   // Parse the JSON response
  //   final jsonData = json.decode(response2.body);

  //   // Iterate over the parsed data and append to the urgents list
  //  mydonations.clear();

  // for (var data in jsonData) {
  //   DateTime date = DateTime.parse(data['date']).toLocal();

  //   Donation mydonation = Donation(
  //     date: date,
  //     desc: data['desc'],
  //     organization: data['organization'],
  //     total: data['total'],
  //   );

  //   mydonations.add(mydonation);
  // }

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
  return mydonations;
}

class _DonationContentState extends State<DonationContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: getData2(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: mydonations.length,
                itemBuilder: (context, i) {
                  return donationCard(mydonations[i]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

class DonatorContent extends StatefulWidget {
  const DonatorContent();

  @override
  State<DonatorContent> createState() => _DonatorContentState();
}

final List<dynamic> donators = [];
Future getData3() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response2 = await http.get(url);
  var responsebody = jsonDecode(response2.body);
  print(responsebody["quotes"][1]["id"]);
  //return responsebody["quotes"];

// Make the HTTP GET request
  final response4 = await http.get(Uri.parse('http://example.com/api/urgents'));

/**FOR TEST */

  String test3 =
      '''
    [
      {"name": "Zahraa",
      "phone": "+0201222318030",
      "price": "100",
      "date":"2023-05-01"
      },
      {"name": "Zahraa",
      "phone": "+0201222318030",
      "price": "100",
      "date":"2023-05-01"
      },
      {"name": "Zahraa",
      "phone": "+0201222318030",
      "price": "100",
      "date":"2023-05-01"
      },
      {"name": "Zahraa",
      "phone": "+0201222318030",
      "price": "100",
      "date":"2023-05-01"
      },
      {"name": "Zahraa",
      "phone": "+0201222318030",
      "price": "100",
      "date":"2023-05-01"
      }
    ]
  ''';

  List<dynamic> jsonData = json.decode(test3);
  donators.clear();

  for (var data in jsonData) {
    Donator donator = Donator(
      date: data['date'],
      name: data['name'],
      phone: data['phone'],
      price: data['price'],
    );

    donators.add(donator);
  }

/**FOR TEST */

  // if (response2.statusCode == 200) {
  //   // Parse the JSON response
  //   final jsonData = json.decode(response2.body);

  //   // Iterate over the parsed data and append to the urgents list
  //  mydonations.clear();

  // for (var data in jsonData) {
  //   DateTime date = DateTime.parse(data['date']).toLocal();

  //   Donation mydonation = Donation(
  //     date: date,
  //     desc: data['desc'],
  //     organization: data['organization'],
  //     total: data['total'],
  //   );

  //   mydonations.add(mydonation);
  // }

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
  return donators;
}

class _DonatorContentState extends State<DonatorContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: getData3(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: donators.length,
                itemBuilder: (context, i) {
                  return DonatorCard(donators[i]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
