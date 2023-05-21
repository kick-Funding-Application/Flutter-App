import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../models/comment.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';

class PeopleComment extends StatefulWidget {
  const PeopleComment(this.comment);
  final Comment comment;
  @override
  State<PeopleComment> createState() => _PeopleCommentState();
}

class _PeopleCommentState extends State<PeopleComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0, top: 6, right: 3),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.kPlaceholder1,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          widget.comment.userimage),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '  ${widget.comment.username}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "${widget.comment.days}d",
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RatingBar.builder(
                      itemSize: 10,
                      ignoreGestures: true,
                      initialRating: widget.comment.rate,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '   ${widget.comment.comment}',
                      style: TextStyle(
                        color: AppColor.kTextColor1,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
