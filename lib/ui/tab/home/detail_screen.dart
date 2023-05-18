import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kickfunding/ui/tab/widgets/home/Ratefeedback.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import '../../../../models/urgent.dart';
import '../../../../theme/app_color.dart';
import '../../../auth/login_form.dart';
import '../../../models/comment.dart';
import '../../../routes/routes.dart';
import '../widgets/home/calculator_builder.dart';
import '../widgets/home/peoplecomment.dart';
import 'rate.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  DetailScreen(this.urgent);

  final Urgent urgent;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

final List<Comment> feedbacks = [];
bool showTextField = true;
bool nocomments = false;

var rate;
String feedback = '';
String id = '1';

String test = '''
[
    {
        "id": 2,
        "title": "Help the Deer",
        "details": "Deer are medium-sized mammals known for their grace and agility. They have slender bodies, long legs, and hooves, which enable them to move swiftly through various habitats. Their fur can vary in color, ranging from reddish-brown to grayish-brown, depending on the species and the season. Both male and female deer have antlers, although they differ in size and complexity. These antlers are shed and regrown annually.",
        "created_by": "admin",
        "user_image": "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
        "target_amount": 1000,
        "current_amount": 350,
        "start_date": "2023-05-17",
        "end_date": "2023-05-23",
        "category": "Animals",
        "tags": "Deer, Animal",
        "image": "https://th.bing.com/th/id/OIP.tVRTBzsGSBUjijte71jTsgHaE8?pid=ImgDet&rs=1",
        "rate": {
            "avg_rate": 5.0
        },
        "feedback": [
            {
                "id": 10,
                "user": "admin",
                "user_image": "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
                "project": "Help the Deer",
                "created_dt": "2023-05-18",
                "rate": 5,
                "content": "the deer is amazing"
            }
        ]
    },
    {
        "id": 1,
        "title": "Hospital",
        "details": "A hospital is a vital healthcare facility that serves the community by providing comprehensive medical services. It is staffed by a diverse team of healthcare professionals, including doctors, nurses, specialists, and support staff, who work together to deliver high-quality care.",
        "created_by": "admin",
        "user_image": "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
        "target_amount": 4500,
        "current_amount": 2890,
        "start_date": "2023-05-17",
        "end_date": "2023-10-11",
        "category": "Health",
        "tags": "Health, Hospital",
        "image": "https://media.gettyimages.com/photos/building-with-large-h-sign-for-hospital-picture-id1130389312",
        "rate": {
            "avg_rate": 3.0
        },
        "feedback": [
            {
                "id": 9,
                "user": "admin",
                "user_image": "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg",
                "project": "Hospital",
                "created_dt": "2023-05-18",
                "rate": 3,
                "content": "good hospital"
            }
        ]
    }
]
''';

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    setState(() {
      id = widget.urgent.id.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 1.sw,
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
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                32.r,
                              ),
                              bottomRight: Radius.circular(
                                32.r,
                              ),
                            ),
                            color: AppColor.kPlaceholder1,
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(widget.urgent.assetName),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(
                                32.r,
                              ),
                              bottomRight: Radius.circular(
                                32.r,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(
                                            8.w,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColor.kPlaceholder2,
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Text(
                                            widget.urgent.category,
                                            style: TextStyle(
                                              color: AppColor.kTextColor1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Text(
                                      '${widget.urgent.days} Days left',
                                      style: TextStyle(
                                        color: AppColor.kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  widget.urgent.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Spacer(),
                                Text(
                                  'By: ${widget.urgent.organizer}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.kTextColor1,
                                      ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Container(
                                      width: (1.sw - 36.w) *
                                          double.parse(widget.urgent.percent) /
                                          100,
                                      height: 6.h,
                                      decoration: ShapeDecoration(
                                        shape: const StadiumBorder(),
                                        color: AppColor.kAccentColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: (1.sw - 36.w) *
                                          (100 -
                                              double.parse(
                                                  widget.urgent.percent)) /
                                          100,
                                      height: 6.h,
                                      decoration: ShapeDecoration(
                                        shape: const StadiumBorder(),
                                        color: AppColor.kPlaceholder1,
                                      ),
                                    )
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Target: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: AppColor.kTextColor1,
                                              ),
                                        ),
                                        Text(
                                          '\$${widget.urgent.target}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Remaining: ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: AppColor.kTextColor1,
                                              ),
                                        ),
                                        Text(
                                          '\$${widget.urgent.remaining}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  widget.urgent.details,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: AppColor.kTextColor1,
                                        height: 2,
                                      ),
                                ),
                                Spacer(),
                                Container(
                                  child: Row(
                                    children: [
                                      Text('Avg Rate:'),
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 25,
                                        initialRating:
                                            widget.urgent.rate != null
                                                ? widget.urgent.rate!
                                                : 0,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      Text('  ${widget.urgent.rate} avg'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0.w,
                  vertical: 30.h,
                ),
                // width: double.infinity,
                //  height: 120.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              AppColor.kPlaceholder2,
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                0,
                                48.h,
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                            ),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.r),
                              ),
                              builder: (_) => CalculatorBuilder(),
                            );
                          },
                          child: Text(
                            'Donate',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                              ),
                            ),
                            foregroundColor: MaterialStateProperty.all(
                              AppColor.kPlaceholder2,
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(
                                0,
                                48.h,
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 24.w,
                              ),
                            ),
                          ),
                          onPressed: () {
                            updateRate();
                          },
                          child: Text(
                            'Rate',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacementNamed(
                      RouteGenerator.main,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/back.svg',
                      width: 24.w,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<List<Comment>> fetchAndParseFeedbacks(String projectName) async {
    try {
      final response = await http.get(
          Uri.parse('https://kickfunding-backend.herokuapp.com/api/projects/'));

      if (2 == 2) {
        List<dynamic> jsonData = json.decode(response.body);

        if (jsonData is List) {
          List<Map<String, dynamic>> parsedData =
              jsonData.cast<Map<String, dynamic>>();
          List<Comment> feedbacks =
              FeedbackParser.parseFeedbacks(projectName, parsedData);
          return feedbacks;
        } else {
          print('Invalid JSON data format');
        }
      } else {
        print('Failed to fetch feedbacks');
      }
    } catch (e) {
      print(e.toString());
    }
    return []; // Return an empty list if an error occurs or no feedbacks are found
  }

  // Future<void> getFeedback() async {
  //   try {
  //     String projectName = widget.urgent.title;
  //     List<Map<String, dynamic>> desiredFeedbacks = [];

  //     final response2 = await http.get(
  //         Uri.parse('https://kickfunding-backend.herokuapp.com/api/projects/'));

  //     if (response2.statusCode == 200) {
  //       List<dynamic> jsonData = json.decode(response2.body);

  //       for (Map<String, dynamic> project in jsonData) {
  //         if (project['title'] == projectName) {
  //           desiredFeedbacks =
  //               List<Map<String, dynamic>>.from(project['feedback']);
  //           break;
  //         }
  //       }

  //       feedbacks.clear();
  //       if (desiredFeedbacks.isNotEmpty) {
  //         for (Map<String, dynamic> feedback in desiredFeedbacks) {
  //           DateTime startDate =
  //               DateTime.parse(feedback['created_dt']).toLocal();
  //           DateTime currentDate = DateTime.now().toLocal();
  //           Duration remainingDuration = currentDate.difference(startDate);
  //           int days = remainingDuration.inDays;

  //           Comment comment = Comment(
  //             comment: feedback['content'],
  //             userimage: feedback['user_image'],
  //             date: feedback['created_dt'],
  //             days: days,
  //             rate: feedback['rate'],
  //             username: feedback['user'],
  //           );
  //           feedbacks.add(comment);
  //         }
  //       } else {
  //         print('No feedback found');
  //       }
  //     } else {
  //       print('Request failed with status: ${response2.statusCode}');
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void updateRate() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.r),
      ),
      builder: (_) {
        return FutureBuilder(
          future: fetchAndParseFeedbacks('${widget.urgent.title}'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              // Handle error state
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Comment> feedbacks = snapshot.data;
              return Container(
                height: 600,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                    top: 32.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 14.h,
                        ),
                        //if (showTextField)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Submit Your Feedback',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.kPrimaryColor,
                                  ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            RatingBar.builder(
                              itemSize: 30,
                              initialRating: rate != null ? rate! : 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                setState(() {
                                  rate = rating;
                                });
                              },
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'People Will be pleased to see your comment'),
                                SizedBox(
                                  height: 8.h,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Field must not be empty';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    setState(() {
                                      feedback = value;
                                      print(feedback);
                                    });
                                  },
                                  minLines: null,
                                  maxLines: 3,
                                  textAlignVertical: TextAlignVertical.top,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColor.kPlaceholder1,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        8.r,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: AppColor.kTextColor1,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  AppColor.kPrimaryColor,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      8.r,
                                    ),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  Size(
                                    double.infinity,
                                    56.h,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  showTextField = false;
                                });
                                submitComment();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 25.h,
                            ),
                          ],
                        ),
                        // if (!showTextField)
                        //   Column(
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Text('Thank you for your feedback!'),
                        //       SizedBox(
                        //         height: 25.h,
                        //       ),
                        //     ],
                        //   ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.notes,
                                color: AppColor.kTextColor1,
                              ),
                            ),
                            Text('Feedbacks on this Project'),
                          ],
                        ),
                        if (nocomments)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  '      No Comments Yet, Be the first to submit :)')
                            ],
                          ),
                        if (!nocomments)
                          Column(
                            children: [
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: feedbacks.length,
                                  itemBuilder: (context, i) {
                                    return PeopleComment(feedbacks[i]);
                                  }),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
    print(rate);
  }

  Future submitComment() async {
    if (!mounted) {
      return; // Widget is no longer mounted, exit early
    }
    /**removecomment when online */
    try {
      Map<String, dynamic> body = {
        "rate": rate,
        "content": feedback,
      };
      String jsonBody = json.encode(body);
      final encoding = Encoding.getByName('utf-8');

      var url = Uri.parse(
          "https://kickfunding-backend.herokuapp.com/api/projects/${id}/feedback/");
      var response = await http.post(url,
          headers: {
            'content-Type': 'application/json',
            "Authorization": "Token ${token}"
          },
          body: jsonBody,
          encoding: encoding);
      var result = response.body;
      print(result);

      if (response.statusCode == 201) {
        print("Registeration succeeded");
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("Comment Posted!"),
                ));
        Navigator.of(context).pushReplacementNamed(
          RouteGenerator.main,
        );

        print('Registration successful');
      } else if (response.statusCode == 403) {
        print(response.statusCode);
        print("Registeration Failed");
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("You Can\'t rate for the same project twice! "),
                ));
      } else if (response.statusCode == 404) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("Server is lagging please wait "),
                ));
      } else {
        print(response.statusCode);
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  content: Text("No Rate Selected"),
                ));
      }
    } catch (e) {
      print(e.toString());
    }

    /**removecomment when online */
  }
}

class FeedbackParser {
  static List<Comment> parseFeedbacks(
      String projectName, List<Map<String, dynamic>> jsonData) {
    List<Comment> feedbacks = [];

    for (Map<String, dynamic> project in jsonData) {
      if (project['title'] == projectName) {
        dynamic feedbackData = project['feedback'];

        if (feedbackData is List) {
          List<Map<String, dynamic>> desiredFeedbacks =
              List<Map<String, dynamic>>.from(feedbackData);

          for (Map<String, dynamic> feedback in desiredFeedbacks) {
            DateTime startDate =
                DateTime.parse(feedback['created_dt']).toLocal();
            DateTime currentDate = DateTime.now().toLocal();
            Duration remainingDuration = currentDate.difference(startDate);
            int days = remainingDuration.inDays;
            double rate = feedback['rate'] is int
                ? feedback['rate'].toDouble()
                : feedback['rate'];

            Comment comment = Comment(
              comment: feedback['content'],
              userimage: feedback['user_image'],
              date: feedback['created_dt'],
              days: days,
              rate: rate,
              username: feedback['user'],
            );
            feedbacks.add(comment);
          }
        }
        break;
      }
    }

    return feedbacks;
  }
}
