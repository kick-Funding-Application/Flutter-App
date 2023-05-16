import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/signup_form.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import 'dart:convert';
import '../../../../bloc/profile/profile_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

import 'details.dart';
import 'profile_card.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent();

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

Future getData() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response = await http.get(url);
  var responsebody = jsonDecode(response.body);
  print(responsebody["quotes"][1]["id"]);
  return responsebody["quotes"];
}

// // Make the HTTP GET request
//   // final response2 = await http.get(Uri.parse('http://example.com/api/urgents'));

// /**FOR TEST */

// //   String test = '''
// //   [
// //     {
// //       "first_name": "Zahraa",
// //       "last_name": "Ashraf",
// //       "phone_number": "+0201222318030",
// //       "birth_date": "2000-05-23",
// //       "email": "zozo@gmail.com",
// //       "country": "Egypt",
// //       "username": "Zahraa"
// //     }
// //   ]
// // ''';

// //   var jsonData = json.decode(test);

// //   constant.Username = jsonData[0]["username"];
// //   constant.first_name = jsonData[0]["first_name"];
// //   constant.last_name = jsonData[0]["last_name"];
// //   constant.email = jsonData[0]["email"];
// //   constant.countryuser = jsonData[0]["country"];
// //   constant.phoneuser = jsonData[0]["phone_number"];
// //   constant.bdateuser = jsonData[0]["birth_date"];

// /**FOR TEST */

//   /*remove this comments*/
// //   var url = Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/chair/data/55");
// //   var response = await http.get(
// //     url,
// //     headers: {
// //       'content-Type': 'application/json',
// //       "Authorization": "Bearer ${constant.token}"
// //     },
// //   );

// //   var data = json.decode(response.body);
// //   print(data);
//   // constant.Username = data["username"];
//   // constant.first_name = data["first_name"];
//   // constant.last_name = data["last_name"];
//   // constant.email = data["email"];
//   // constant.countryuser = data["country"];
//   // constant.phoneuser = data["phone_number"];
//   // constant.bdateuser = data["birth_date"];
// //  /*remove this comments*/
//   return jsonData;
// }

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                Spacer(),
                ProfileCard(
                    firstname: constant.first_name,
                    lastname: constant.last_name,
                    phone: constant.phoneuser),
                Spacer(),
                Details(
                  title: 'Email address',
                  desc: constant.email,
                ),
                Spacer(),
                Details(
                  title: 'Country',
                  desc: constant.countryuser,
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Details(
                        title: 'Username',
                        desc: constant.Username,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Details(
                  title: 'Birth date',
                  desc: constant.bdateuser,
                ),
                Spacer(),
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
                    Navigator.of(context).pushReplacementNamed(
                      RouteGenerator.splash,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logout.svg',
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        'Logout',
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  
}
