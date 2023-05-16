import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../../../models/result.dart';
// import '../../../../routes/routes.dart';
import '../../../../models/result.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class ResultCard extends StatefulWidget {
  ResultCard(this.result);

  final Result result;

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(RouteGenerator.result, arguments: widget.result);
        },
        child: Container(
          height: 104.h,
          child: Row(
            children: [
              Container(
                width: 104.h,
                height: 104.h,
                decoration: BoxDecoration(
                  color: AppColor.kPlaceholder1,
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ),
                ),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(widget.result.assetName),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.result.title,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'By: ${widget.result.organizer}',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColor.kTextColor1,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        '${widget.result.days} Days left',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '\$${widget.result.remaining} left',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 8.h,
                              decoration: ShapeDecoration(
                                shape: StadiumBorder(),
                                color: AppColor.kPlaceholder2,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: int.parse(widget.result.percent),
                                  child: Container(
                                    height: 8.h,
                                    width: 8,
                                    decoration: ShapeDecoration(
                                      shape: StadiumBorder(),
                                      color: AppColor.kPrimaryColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 100 - int.parse(widget.result.percent),
                                  child: Container(
                                    height: 8.h,
                                    width: 8,
                                    decoration: ShapeDecoration(
                                      shape: StadiumBorder(),
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        '${widget.result.percent}%',
                        style: TextStyle(
                          color: AppColor.kTextColor1,
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
