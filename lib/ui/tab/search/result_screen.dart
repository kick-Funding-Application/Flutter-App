import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kickfunding/models/result.dart';

import '../../../../models/result.dart';
import '../../../../theme/app_color.dart';
import '../../../routes/routes.dart';
import '../widgets/home/calculator_builder.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen(this.result);

  final Result result;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

var rate;

class _ResultScreenState extends State<ResultScreen> {
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
                                borderRadius: BorderRadius.circular(
                                  8.r,
                                ),
                                image: DecorationImage(
                                    image:
                                        NetworkImage(widget.result.assetName),
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
                                            widget.result.category,
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
                                      '${widget.result.days} Days left',
                                      style: TextStyle(
                                        color: AppColor.kAccentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  widget.result.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Spacer(),
                                Text(
                                  'By: ${widget.result.organizer}',
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
                                          double.parse(widget.result.percent) /
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
                                                  widget.result.percent)) /
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
                                          '\$${widget.result.target}',
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
                                          '\$${widget.result.remaining}',
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
                                  widget.result.details,
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
                                        itemSize: 30,
                                        initialRating:
                                            widget.result.rate != null
                                                ? widget.result.rate!
                                                : 0,
                                        ignoreGestures: true,
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
                                      Text('${widget.result.rate}'),
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
                width: double.infinity,
                //  height: 120.h,
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
                    onTap: () => Navigator.of(context).pop(),
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

  void updateRate() async {
    /**Remove when online */
    // Map<String, dynamic> body = {
    //   "value": rate,
    // };
    // String jsonBody = json.encode(body);
    // final encoding = Encoding.getByName('utf-8');

    // var url =
    //     Uri.parse("https://1a62-102-186-239-195.eu.ngrok.io/caregiver/login");

    // var response = await http.post(url,
    //     headers: {
    //       'content-Type': 'application/json',
    //     },
    //     body: jsonBody,
    //     encoding: encoding);

    // var data = json.decode(response.body);
    // print(data);
    /**Remove when online */
    print(rate);
  }
}
