// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:kickfunding/ui/tab/widgets/category.dart';
// import 'package:kickfunding/ui/tab/widgets/home/header.dart';
// import 'package:kickfunding/ui/tab/widgets/home/urgent_card.dart';
// import '../../models/urgent.dart';
// import '/initials/constants.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'widgets/profile/constants.dart';

// import '../../../routes/routes.dart';
// import '../../../theme/app_color.dart';
// import 'home/home_screen.dart';
// import 'profile/proflle_screen.dart';
// import 'search/search_screen.dart';
// import 'swap/swap_screen.dart';

// final List<Widget> Requests = [
//   HomeScreen(),
//   SearchScreen(),
//   Scaffold(
//     backgroundColor: AppColor.kForthColor,
//   ),
//   SwapScreen(),
//   ProfileScreen(),
// ];

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen();

//   @override
//   _CategoryScreenState createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   late int tabIndex;
//   late PageController pageController;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     tabIndex = 0;
//     pageController = PageController(initialPage: tabIndex);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     pageController.dispose(); // Dispose the PageController
//     super.dispose();
//   }

//   void navigateToTab(int index) async {
//     setState(() {
//       tabIndex = index;
//     });
//     if (index == 2) {
//       await Navigator.of(context).pushNamed(RouteGenerator.startCharity);

//       setState(() {
//         tabIndex = 0;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getData(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (snapshot.hasData) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(
//                     32.r,
//                   ),
//                   bottomRight: Radius.circular(
//                     32.r,
//                   ),
//                 ),
//               ),
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).viewPadding.top,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Spacer(),
//                   Header(),
//                   Spacer(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 16.0.w,
//                     ),
//                     child: Container(
//                       width: double.infinity,
//                       height: 120.h,
//                       decoration: BoxDecoration(
//                         color: AppColor.kForthColor,
//                         borderRadius: BorderRadius.circular(
//                           12.r,
//                         ),
//                       ),
//                       child: Stack(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/images/mask_diamond.svg',
//                             fit: BoxFit.fitWidth,
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Change the world with',
//                                   textAlign: TextAlign.center,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                                 Text(
//                                   'your little help',
//                                   textAlign: TextAlign.center,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headline6!
//                                       .copyWith(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                 ),
//                                 SizedBox(
//                                   height: 4.h,
//                                 ),
//                                 ElevatedButton(
//                                   style: ButtonStyle(
//                                     minimumSize: MaterialStateProperty.all(
//                                       Size(
//                                         0,
//                                         0,
//                                       ),
//                                     ),
//                                     shape: MaterialStateProperty.all(
//                                       RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(
//                                           8.r,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   onPressed: () {},
//                                   child: Text('Donate'),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Spacer(),
//                   buildcategory(),
//                   // Category(
//                   //   onTap: () {
//                   //     setState(() {
//                   //       _buildurgent(context);
//                   //     });
//                   //   },
//                   // ),
//                   Spacer(),
//                   Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 16.0.w,
//                     ),
//                     child: Row(
//                       children: [
//                         Text(
//                           'Urgently Needed',
//                           style:
//                               Theme.of(context).textTheme.headline6!.copyWith(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                         ),
//                         Spacer(),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: List.generate(
//                             specificurgents.length,
//                             (index) => Row(
//                               children: [
//                                 SizedBox(
//                                   width: 2.w,
//                                 ),
//                                 Container(
//                                   width: 8.w,
//                                   height: 8.w,
//                                   decoration: BoxDecoration(
//                                     color: index == currentIndex
//                                         ? AppColor.kAccentColor
//                                         : AppColor.kPlaceholder1,
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   _buildurgent(context),

//                   Spacer(),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         });
//   }

//   Widget buildcategory() {
//     return Category(onTap: () {
//       setState(() {
//         //  _buildurgent(context);
//       });
//     });
//   }

//   Widget _buildurgent(BuildContext context) {
//     return FutureBuilder(
//       future: getData(),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           return Padding(
//             padding: EdgeInsets.only(
//               left: 16.0.w,
//             ),
//             child: SingleChildScrollView(
//               // controller: controller,
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.only(
//                 top: 8.h,
//                 bottom: 8.h,
//                 right: 8.w,
//               ),
//               child: Row(
//                 children: List.generate(
//                   specificurgents.length,
//                   (index) => Row(
//                     children: [
//                       UrgentCard(specificurgents[index]),
//                       SizedBox(
//                         width: 16.w,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   Future getData(String category) async {
//     try {
// /**FOR TEST */
//       final response2 =
//           await http.get(Uri.parse('${constant.server}/api/projects/$category/filter'));

//       if (response2.statusCode == 200) {
//         // Parse the JSON response
//         final jsonData = json.decode(response2.body);

//         // Clear the specificurgents list before starting the loop
//         specificurgents.clear();

//         // Iterate over the parsed data and append to the urgents list
//         for (var data in jsonData) {
//           int target = data['target_amount'];
//           String target2 = data['target_amount'].toString();
//           int current_amount = data['current_amount'];
//           int remaining = ((target - current_amount));
//           double percent;
//           if (target == 0) {
//             percent = 0;
//           } else {
//             percent = ((target - remaining) / target) * 100;
//           }

//           DateTime end_date = DateTime.parse(data['end_date']).toLocal();
//           DateTime currentDate = DateTime.now().toLocal();
//           Duration remainingDuration = end_date.difference(currentDate);
//           int days = remainingDuration.inDays;
//           Urgent urgent = Urgent(
//             userimage: data['user_image'],
//             id: data['id'],
//             title: data['title'],
//             target: target2,
//             percent: percent
//                 .toStringAsFixed(2), // Convert to string with 2 decimal places
//             assetName: data['image'],
//             category: data['category'],
//             organizer: data['created_by'],
//             remaining: remaining.toString(),
//             rate: double.parse(data['rate']['avg_rate'].toString()),
//             details: data['details'],
//             end_date: data['end_date'],
//             start_date: data['start_date'],
//             days: days,
//             tags: data['tags'],
//           );

//           if (urgent.category == charityform.specificCategory) {
//             urgents.add(urgent);
//             specificurgents.add(urgent);
//           }
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//     return specificurgents;
//   }
// }
