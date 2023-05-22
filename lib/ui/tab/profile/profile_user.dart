import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/auth/signup_form.dart';
import 'package:http/http.dart' as http;
import 'package:kickfunding/ui/constants.dart';
import 'dart:convert';
import '../../../../auth/sessionmanage.dart';
import '../../../../bloc/profile/profile_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

import '/ui/tab/widgets/profile/details.dart';
import '/ui/tab/widgets/profile/profile_card.dart';

class UserProfile extends StatefulWidget {
  const UserProfile(
      {required this.User_firstname,
      required this.User_lastname,
      required this.User_username,
      required this.User_country,
      required this.User_phone,
      required this.User_bdate});

  final String User_firstname;
  final String User_lastname;
  final String User_username;
  final String User_country;
  final String User_phone;
  final String User_bdate;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

Future getData() async {
  var url = Uri.parse("https://dummyjson.com/quotes");
  var response = await http.get(url);
  var responsebody = jsonDecode(response.body);
  return responsebody["quotes"];
}

class _UserProfileState extends State<UserProfile> {
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
                    firstname: '${widget.User_firstname}',
                    lastname: '${widget.User_lastname}',
                    phone: '${widget.User_phone}'),
                Spacer(),
                Details(
                  title: 'Country',
                  desc: '${widget.User_country}',
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Details(
                        title: 'Username',
                        desc: '${widget.User_username}',
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Details(
                  title: 'Birth date',
                  desc: '${widget.User_bdate}',
                ),
                Spacer(),
                Text('Projects'),
                Spacer(),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
