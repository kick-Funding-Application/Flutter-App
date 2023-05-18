import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/models/donator.dart';

import '../../../../models/result.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class DonatorCard extends StatefulWidget {
  const DonatorCard(this._donator);

  final Donator _donator;
  @override
  State<DonatorCard> createState() => _DonatorCardState();
}

class _DonatorCardState extends State<DonatorCard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        '${widget._donator.name}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        '${widget._donator.phone}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.kTextColor1,
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget._donator.price}',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.kPrimaryColor,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Divider(),
          ],
        ),
      ],
    );
  }
}
