import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/initials/constants.dart';
import 'package:kickfunding/ui/tab/widgets/swap/editproject.dart';

import '../../../../bloc/swap/swap_bloc.dart';
import '../../../../models/urgent.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import 'percentage_indicator.dart';

class CharityCard extends StatefulWidget {
  const CharityCard(this.urgent);

  final Urgent urgent;

  @override
  State<CharityCard> createState() => _CharityCardState();
}

class _CharityCardState extends State<CharityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          print(widget.urgent.id);
          charityform.donationID = widget.urgent.id.toString();
        });
        BlocProvider.of<SwapBloc>(context).add(SetDetail(true));
      },
      child: Container(
        height: 340.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.kPlaceholder1,
              offset: Offset(0, 4),
              blurRadius: 15,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0.w),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColor.kPlaceholder1,
                        image: DecorationImage(
                          image: NetworkImage(widget.urgent.assetName),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8.w,
                      right: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: AppColor.kForthColor.withOpacity(0.5),
                        ),
                        child: Text(
                          '${widget.urgent.category}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.w,
                      left: 8.w,
                      child: Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.kPlaceholder1.withOpacity(0.3),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              RouteGenerator.details,
                              arguments: widget.urgent,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColor.kForthColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.w,
                      right: 8.w,
                      child: Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColor.kPlaceholder2.withOpacity(0.3),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProject(
                                  category: '${widget.urgent.category}',
                                  Target: '${widget.urgent.target}',
                                  Title: '${widget.urgent.title}',
                                  deadline: '${widget.urgent.end_date}',
                                  desc: '${widget.urgent.details}',
                                  tags: '${widget.urgent.tags}',
                                  createdAt: '${widget.urgent.start_date}',
                                  image: '${widget.urgent.assetName}',
                                  widget.urgent.id.toString(),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: const Color.fromARGB(255, 36, 50, 61)
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: 16.h,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      child: Text(
                        '${widget.urgent.title}',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: AppColor.kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '\$${widget.urgent.remaining}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Remaining',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                          ],
                        ),
                        PercentageIndicatior(
                          percentage: '${widget.urgent.percent}',
                        ),
                        Column(
                          children: [
                            Text(
                              '\$${widget.urgent.target}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppColor.kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Target',
                              style: TextStyle(
                                color: AppColor.kTextColor1,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
