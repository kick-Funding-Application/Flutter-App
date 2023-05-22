import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/models/donator.dart';
import 'package:kickfunding/ui/tab/search/start_charity_screen.dart';
import 'package:kickfunding/ui/tab/search/search_screen.dart';
import 'package:kickfunding/ui/tab/widgets/swap/donationstest.dart';
import 'package:kickfunding/ui/tab/widgets/swap/donators.dart';
import 'dart:convert';
import '../../../../models/urgent.dart';
import '../../../constants.dart';
import '../../../../auth/login_form.dart';
import '../../../../bloc/swap/swap_bloc.dart';
import '../../../../models/donation.dart';
//import '../../../../models/donator.dart';
import '/initials/constants.dart';
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

  try {
/**FOR TEST */
    var url2 = Uri.parse("${constant.server}api/dj-rest-auth/user/projects");
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
        Urgent urgent = Urgent(
          id: data['id'],
          userimage: data['user_image'],

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

        myprojects.add(urgent);
      }
    }
  } catch (e) {
    print(e.toString()); // print error
  }
  return myprojects;
}

class _CharityContentState extends State<CharityContent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future to wait for data to be collected
      future: getData(), // call the function
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: BlocBuilder<SwapBloc, SwapState>(
              /// to يسمع في السكرينات
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

List<Donation> mydonations = [];

Future<List<Donation>> getData2() async {
  try {
    var url2 = Uri.parse("${constant.server}api/dj-rest-auth/user/donate/");
    var response2 = await http.get(
      url2,
      headers: {
        'content-Type': 'application/json',
        "Authorization": " Token ${token}"
      },
    );
    List<dynamic> transactions = json.decode(response2.body);

    // Iterate over each transaction entry
    mydonations.clear();
    for (var entry in transactions) {
      Map<String, dynamic> transactionList = entry['transaction_list'];

      // Sort and display transactions for each date
      transactionList.keys.forEach((date) {
        List<dynamic> transactionsByDate = transactionList[date];

        transactionsByDate.sort((a, b) => a['amount'].compareTo(b['amount']));

        for (var transaction in transactionsByDate) {
          Donation mydonation = Donation(
              organization: transaction['project'],
              desc: transaction['details'],
              total: transaction['amount'],
              date: date);
          mydonations.add(mydonation);
          print(mydonations.length);
        }
      });
    }
  } catch (e) {
    print(e.toString());
  }

  return mydonations;
}

class _DonationContentState extends State<DonationContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
        child: FutureBuilder<List<Donation>>(
          future: getData2(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Donation>> snapshot) {
            if (snapshot.hasData) {
              List<Donation> donations = snapshot.data!;
              Set<String> uniqueDates =
                  donations.map((donation) => donation.date).toSet();
              if (uniqueDates.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                      ),
                      Text(
                        'You Haven\'t Donated Yet!',
                        style: TextStyle(
                            color: AppColor.kTextColor1, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: uniqueDates.length,
                itemBuilder: (context, i) {
                  String date = uniqueDates.toList()[i];
                  List<Donation> donationsByDate = donations
                      .where((donation) => donation.date == date)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: $date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: donationsByDate.length,
                        itemBuilder: (context, index) {
                          Donation donation = donationsByDate[index];
                          return donationCard(donation);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
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

List<Donator> donators = [];

Future<List<Donator>> getData3() async {
  try {
    var url2 = Uri.parse(
        "${constant.server}api/donate/${charityform.donationID}/history/");
    var response2 = await http.get(
      url2,
      headers: {
        'content-Type': 'application/json',
        "Authorization": " Token ${token}"
      },
    );
    if (response2.statusCode == 404) {
    } else {
      List<dynamic> jsonData = json.decode(response2.body);

      donators.clear();

      for (var entry in jsonData) {
        Map<String, dynamic> transactionList = entry['donation_list'];

        // Sort and display transactions for each date
        transactionList.keys.forEach((date) {
          List<dynamic> transactionsByDate = transactionList[date];

          transactionsByDate.sort((a, b) => a['amount'].compareTo(b['amount']));

          for (var transaction in transactionsByDate) {
            Donator donator = Donator(
                name: transaction['user'],
                price: transaction['amount'],
                date: date,
                phone: transaction['phone_number']);
            donators.add(donator);
          }
        });
      }
    }
  } catch (e) {
    print(e.toString());
  }

  return donators;
}

class _DonatorContentState extends State<DonatorContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: SingleChildScrollView(
        child: FutureBuilder<List<Donator>>(
          future: getData3(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Donator>> snapshot) {
            if (snapshot.hasData) {
              List<Donator> donations = snapshot.data!;
              Set<String> uniqueDates =
                  donations.map((donation) => donation.date).toSet();

              if (uniqueDates.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                      ),
                      Text(
                        'No Donations Yet!',
                        style: TextStyle(
                            color: AppColor.kTextColor1, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: uniqueDates.length,
                itemBuilder: (context, i) {
                  String date = uniqueDates.toList()[i];
                  List<Donator> donationsByDate = donations
                      .where((donation) => donation.date == date)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: $date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: donationsByDate.length,
                        itemBuilder: (context, index) {
                          Donator donation = donationsByDate[index];
                          return DonatorCard(donation);
                        },
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
