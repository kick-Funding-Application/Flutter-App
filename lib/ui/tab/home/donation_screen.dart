import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kickfunding/ui/tab/widgets/profile/constants.dart';
import '../../../../bloc/payment/payment_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../../theme/app_color.dart';
import 'package:http/http.dart' as http;

import '../widgets/home/payment_method_widget.dart';

class DonationScreen extends StatefulWidget {
  DonationScreen(this.total);

  final String total;

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  Map<String, dynamic>? paymentIntent;
  Future<void> makePayment() async {
    try {
      paymentIntent =
          await createPaymentIntent('${constant.totalpayment}', 'USD');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Zahraa",
            googlePay: const PaymentSheetGooglePay(
                testEnv: true, currencyCode: "USD", merchantCountryCode: "+92"),
          ))
          .then((value) {});
      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        //  Uri.parse('https://donate.stripe.com/test_3cs5nzdRHc4Zf7O144'),
        headers: {
          'Authorization':
              'Bearer sk_test_51N0o6jCUAXypJ6z6NgRInk4wcZyzNBTh1o0XzkprrVlHhdasF40WtKjFZwvGArkkUQqAvsFcayPwU6By2JwkQ1QW00iZeN6Nsf',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  // CreatePaymentIntent() async {
  //   try {
  //     Map<String, dynamic> body = {
  //       "amount": "1000",
  //       "currency": "USD",
  //     };
  //     http.Response response = await http.post(
  //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //         body: body,
  //         headers: {
  //           "Authorization":
  //               "sk_test_51MWx8OAVMyklfe3C3gP4wKOhTsRdF6r1PYhhg1PqupXDITMrV3asj5Mmf0G5F9moPL6zNfG3juK8KHgV9XNzFPlq00wmjWwZYA",
  //           "Content-Type": "application/x-www-form-urlencoded",
  //         });
  //     return json.decode(response.body);
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kForthColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: SizedBox(
                            width: 24.w,
                            child: SvgPicture.asset(
                              'assets/images/back.svg',
                              width: 24.w,
                              color: AppColor.kTitle,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Donation Detail',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: AppColor.kTitle,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        )
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 72.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: 104.w,
                            height: 72.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.r,
                              ),
                              color: AppColor.kPlaceholder1,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/image_placeholder.svg',
                                width: 48.w,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Project title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  'OWNER:',
                                  style: TextStyle(
                                    color: AppColor.kTextColor1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Spacer(),
                    // ElevatedButton(
                    //   style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(
                    //       AppColor.kPrimaryColor,
                    //     ),
                    //     shape: MaterialStateProperty.all(
                    //       RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(
                    //           8.r,
                    //         ),
                    //       ),
                    //     ),
                    //     minimumSize: MaterialStateProperty.all(
                    //       Size(
                    //         double.infinity,
                    //         56.h,
                    //       ),
                    //     ),
                    //   ),
                    //   onPressed: () {},
                    //   child: Text(
                    //     'Donate as anonymous',
                    //   ),
                    // ),
                    Spacer(),
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 18.sp,
                            color: AppColor.kTitle,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Spacer(),
                    BlocProvider(
                      create: (context) => PaymentBloc(),
                      child: Column(
                        children: List.generate(
                          methods.length,
                          (index) => Column(
                            children: [
                              PaymentMethodWidget(index),
                              SizedBox(
                                height: 8.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Row(
                      children: [
                        Text('Total',
                            style: Theme.of(context).textTheme.headline6),
                        Spacer(),
                        Text(
                          '\$${constant.totalpayment}',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.kTextColor1,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 120.h,
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Center(
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
                      double.infinity,
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
                  makePayment();
                  //   showModalBottomSheet(
                  //     context: context,
                  //     isScrollControlled: true,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(32.r),
                  //     ),
                  //     builder: (_) => Padding(
                  //       padding: EdgeInsets.only(
                  //         bottom: MediaQuery.of(context).viewPadding.bottom,
                  //         top: 32.h,
                  //         left: 16.w,
                  //         right: 16.w,
                  //       ),
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           SvgPicture.asset(
                  //             'assets/images/check.svg',
                  //           ),
                  //           SizedBox(
                  //             height: 8.h,
                  //           ),
                  //           Text(
                  //             'Thank You',
                  //             style:
                  //                 Theme.of(context).textTheme.headline4!.copyWith(
                  //                       fontWeight: FontWeight.bold,
                  //                     ),
                  //           ),
                  //           SizedBox(
                  //             height: 8.h,
                  //           ),
                  //           Text(
                  //             'Your donation has been succeed and will be '
                  //             'transferred soon to the needy.',
                  //             textAlign: TextAlign.center,
                  //           ),
                  //           SizedBox(
                  //             height: 64.h,
                  //           ),
                  //           ElevatedButton(
                  //             style: ButtonStyle(
                  //               backgroundColor: MaterialStateProperty.all(
                  //                 AppColor.kPrimaryColor,
                  //               ),
                  //               shape: MaterialStateProperty.all(
                  //                 RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(
                  //                     8.r,
                  //                   ),
                  //                 ),
                  //               ),
                  //               minimumSize: MaterialStateProperty.all(
                  //                 Size(
                  //                   double.infinity,
                  //                   56.h,
                  //                 ),
                  //               ),
                  //             ),
                  //             onPressed: () {
                  //               Navigator.pushNamedAndRemoveUntil(context,
                  //                   RouteGenerator.main, (route) => false);
                  //             },
                  //             child: Text(
                  //               'Home',
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   );
                },
                child: Text('Donate'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
