import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/models/donator.dart';

import '../../../../models/donation.dart';
import '../../../../models/result.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
// ... existing imports

class DonationCard extends StatefulWidget {
  const DonationCard(this._donation);

  final List<Donation> _donation;

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  Map<String, List<Donation>> _groupedDonations = {};

  @override
  void initState() {
    super.initState();
    _groupDonationsByDate();
  }

  void _groupDonationsByDate() {
    for (var donation in widget._donation) {
      DateTime date = DateFormat('yyyy-MM-dd').parse(donation.date);
      String formattedDate = DateFormat('MMMM d, yyyy').format(date);
      if (_groupedDonations.containsKey(formattedDate)) {
        _groupedDonations[formattedDate]!.add(donation);
      } else {
        _groupedDonations[formattedDate] = [donation];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      itemCount: _groupedDonations.length,
      itemBuilder: (context, index) {
        String date = _groupedDonations.keys.toList()[index];
        List<Donation> donations = _groupedDonations[date]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Text(
                date,
                style: TextStyle(
                  color: AppColor.kTextColor1,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemCount: donations.length,
              itemBuilder: (context, index) {
                Donation donation = donations[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              donation.organization,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              donation.desc,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    color: AppColor.kTextColor1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                       " ${donation.total}",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColor.kPrimaryColor,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
