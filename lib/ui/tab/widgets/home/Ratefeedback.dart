import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/tab/home/detail_screen.dart';
import 'package:kickfunding/ui/tab/widgets/home/peoplecomment.dart';
import 'package:http/http.dart' as http;
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import '../../../../models/comment.dart';
import 'dart:convert';

class rateFeedback extends StatefulWidget {
  const rateFeedback({required this.rate});
  final double rate;

  @override
  State<rateFeedback> createState() => _rateFeedbackState();
}

final List<Comment> comments = [];
Future getData2() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response2 = await http.get(url);
  var responsebody = jsonDecode(response2.body);
  print(responsebody["quotes"][1]["id"]);

  String test = '''
    [
      {
        "comment": "i like this app",
        "userimage": "https://citywildlife.org/wp-content/uploads/DSC_0468.jpg",
        "rate": "5.0",
        "days": "3",
        "date": "2023-05-13",
        "username": "Zahraa"
      },
      {
        "comment": "this is amazing",
        "userimage": "https://www.hindustantimes.com/ht-img/img/2023/02/15/1600x900/Death_Note_is_usually_the_first_anime__1676437361142_1676437361490_1676437361490.jpg",
        "rate": "4.0",
        "days": "7",
        "date": "2023-05-13",
        "username": "Ahmed"
      },
      {
        "comment": "I Rate this 10/10",
        "userimage": "https://w0.peakpx.com/wallpaper/981/593/HD-wallpaper-hacker-dark-mask-thumbnail.jpg",
        "rate": "5.0",
        "days": "1",
        "date": "2023-05-13",
        "username": "Badr"
      }
    ]
    '''; // Example JSON data

  List<dynamic> jsonData = json.decode(test);
  comments.clear();

  for (var data in jsonData) {
    DateTime start_date = DateTime.parse(data['date']).toLocal();
    DateTime currentDate = DateTime.now().toLocal();
    Duration remainingDuration = currentDate.difference(start_date);
    int days = remainingDuration.inDays;
    Comment comment = Comment(
      submitted: true,
      username: data['username'],
      userimage: data['userimage'],
      rate: double.parse(data['rate'].toString()),
      comment: data['comment'],
      date: data['date'],
      days: days,
    );

    comments.add(comment);
  }

  return responsebody["quotes"];
}

TextEditingController feedback = TextEditingController();

class _rateFeedbackState extends State<rateFeedback> {
  bool showTextField = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData2(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
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
                    if (showTextField)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Submit Your Feedback',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.kPrimaryColor,
                                    ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          RatingBar.builder(
                            itemSize: 30,
                            initialRating: rate,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
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
                                  setState(() {});
                                },
                                controller: feedback,
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
                    if (!showTextField)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Thank you for your feedback!'),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      ),
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
                    Column(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (context, i) {
                              return PeopleComment(comments[i]);
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
  }
}
