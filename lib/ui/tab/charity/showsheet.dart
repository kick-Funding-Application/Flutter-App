/**
 * 
 showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.r),
                        ),
                        builder: (_) => Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewPadding.bottom,
                            top: 32.h,
                            left: 16.w,
                            right: 16.w,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 64.h,
                              ),
                              SvgPicture.asset(
                                'assets/images/check.svg',
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'Successful',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.kPrimaryColor,
                                    ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'Your charity program has been successsfully created. '
                                'Now you can check and maintain it in your \'activity\' menu.',
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 80.h,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColor.kPrimaryColor,
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        8.r,
                                      ),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(
                                      double.infinity,
                                      56.h,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      RouteGenerator.main, (route) => false);
                                },
                                child: Text(
                                  'Home',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
 */