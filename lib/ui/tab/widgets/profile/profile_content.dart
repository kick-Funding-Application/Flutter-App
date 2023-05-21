import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/signup_form.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import 'dart:convert';
import '../../../../auth/sessionmanage.dart';
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
  return responsebody["quotes"];
}

class _ProfileContentState extends State<ProfileContent> {
  late final SessionManager sessionManager;

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
