import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/models/donator.dart';

import '../../../../models/donation.dart';
import '../../../../models/result.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class donationCard extends StatefulWidget {
  const donationCard(this._donation);

  final Donation _donation;
  @override
  State<donationCard> createState() => _donationCardState();
}

class _donationCardState extends State<donationCard> {
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
                        '${widget._donation.organization}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        '${widget._donation.desc}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.kTextColor1,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${widget._donation.total}',
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
          ],
        ),
      ],
    );
  }
}
