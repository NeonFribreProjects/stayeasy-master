import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import '../../constants/colorPallete.dart';
import '../../reusable_widgets/back_button.dart';
import '../../reusable_widgets/my_text_widget.dart';
import 'payment_controller.dart';

PaymentController _controller = Get.put(PaymentController());

class PaymentOneView extends StatelessWidget {
  const PaymentOneView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: MediaQuery.of(context).size.height / 8,
          color: kprimary,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: '\$150',
                      color: kwhite,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xffDD9F0D),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MyText(
                            text: 'Includes taxes and Charges',
                            color: kwhite,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Get.snackbar(
                  //   'Note',
                  //   'Payment Successful',
                  //   snackPosition: SnackPosition.TOP,
                  //   colorText: kwhite,
                  //   backgroundColor: kprimary,
                  // );
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: kwhite,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: MyText(
                      text: 'Book Now',
                      weight: FontWeight.bold,
                      size: 15.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          centerTitle: true,
          leading: MyBackButton(kwhite),
          title: Image.asset(
            'assets/images/payment.png',
            height: 30,
          ),
        ),
        body: GetBuilder<PaymentController>(
          init: PaymentController(),
          initState: (_) {},
          builder: (_) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: 'When would you like to pay?',
                      size: 18.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Pay Later',
                          size: 15.sp,
                          weight: FontWeight.bold,
                        ),
                        Radio(
                          value: 'pay later',
                          groupValue: _controller.selectedValue,
                          onChanged: (value) {
                            _controller.setRadio(value);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'Pay Now',
                          size: 15.sp,
                          weight: FontWeight.bold,
                        ),
                        Radio(
                          value: 'pay now',
                          groupValue: _controller.selectedValue,
                          onChanged: (value) {
                            _controller.setRadio(value);
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Container(
                            margin: EdgeInsets.only(bottom: 15),
                            padding: EdgeInsets.only(right: 10),
                            child: Image.asset(
                              index == 0
                                  ? 'assets/images/download.png'
                                  : index == 1
                                      ? 'assets/images/Visa.svg.png'
                                      : 'assets/images/download (1).png',
                              height: 20,
                              width: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyText(
                      text:
                          'The property will handle payment. the date you\'ll be charge \ndepends on your booking conditions.',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          text: 'At the property you\'ll pay',
                          size: 15.sp,
                          weight: FontWeight.bold,
                        ),
                        MyText(
                          text: '\$150',
                          size: 15.sp,
                          weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    MyText(
                      text: 'Payment',
                      size: 15.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kblack,
                                  border: Border.all(color: kwhite),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    index == 0
                                        ? 'assets/images/Icon awesome-credit-card.png'
                                        : index == 1
                                            ? 'assets/images/Icon awesome-paypal.png'
                                            : 'assets/images/Icon awesome-apple-pay.png',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              MyText(
                                text: index == 0
                                    ? 'New Card'
                                    : index == 1
                                        ? 'Paypal'
                                        : 'Apple Pay',
                                size: 8.sp,
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    MyText(
                      text: 'Your Name',
                      size: 14.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),
                    MyText(
                      text: 'YourEmail@mail.com',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),
                    MyText(
                      text: 'U.S.A',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(height: 5),
                    MyText(
                      text: '+1234567890',
                      size: 12.sp,
                      weight: FontWeight.bold,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            text: 'Freehand Hotel\nCalifornia',
                            size: 16.sp,
                            weight: FontWeight.bold,
                          ),
                          Divider(thickness: 2.0),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: 'Check-in',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                MyText(
                                  text: 'Sun, 24 Jan 2023',
                                  size: 10.sp,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2.0),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: 'Check-out',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                MyText(
                                  text: 'Mon, 30 Jan 2023',
                                  size: 10.sp,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2.0),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: 'Guests',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                MyText(
                                  text: '2 adults',
                                  size: 10.sp,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 2.0),
                          MyText(
                            text: '2 Nights, 1 room, 2 adults and 1 child',
                            size: 12.sp,
                            weight: FontWeight.bold,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  text: 'Total',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    MyText(
                                      text: '\$150',
                                      size: 15.sp,
                                      weight: FontWeight.bold,
                                    ),
                                    MyText(
                                      text: 'Includes taxes and Charges',
                                      size: 8.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  text: 'Price Information',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Icon awesome-money-bill-alt.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(width: 10),
                                    MyText(
                                      text:
                                          'Includes \$20 in taxes and Charges',
                                      size: 8.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                MyText(
                                  text: 'Booking Condition',
                                  size: 12.sp,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Icon material-do-not-disturb-alt.png',
                                      height: 15,
                                      width: 15,
                                    ),
                                    SizedBox(width: 10),
                                    MyText(
                                      text:
                                          'Includes \$20 in taxes and Charges',
                                      size: 8.sp,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // createPaymentIntent(String amount) async {
  //   try {
  //     Map<String, dynamic> body = {
  //       'amount': amount,
  //       'currency': "USD",
  //     };
  //     var response = await http.post(
  //       Uri.parse('https://api.stripe.com/v1/payment_intents'),
  //       headers: {
  //         'Authorization':
  //             'Bearer sk_test_51NG0RlHF0xvIwO3qjWr4rhNFcYVu9xO5MwLd7XIm25BHtuF1YdX5gAfNdIuCA6rkkad4QrHRqBikEgIYxTJublIC00SfeuMGZe',
  //         'Content-Type': 'application/x-www-form-urlencoded'
  //       },
  //       body: body,
  //     );
  //     return json.decode(response.body);
  //   } catch (err) {
  //     throw Exception(err.toString());
  //   }
  // }

  // displayPaymentSheet() async {
  //   try {
  //     await Stripe.instance.presentPaymentSheet().then((value) {
  //       print("Payment Successfully");
  //     });
  //   } catch (e) {
  //     print('$e');
  //   }
  // }

  // Future<void> makePayment() async {
  //   try {
  //     var paymentIntent = await createPaymentIntent('10000');

  //     // var gpay = PaymentSheetGooglePay(
  //     //   merchantCountryCode: "USD",
  //     //   currencyCode: "USD",
  //     //   testEnv: true,
  //     // );

  //     //STEP 2: Initialize Payment Sheet
  //     await Stripe.instance
  //         .initPaymentSheet(
  //           paymentSheetParameters: SetupPaymentSheetParameters(
  //             paymentIntentClientSecret:
  //                 paymentIntent!['client_secret'], //Gotten from payment intent
  //             style: ThemeMode.light,
  //             merchantDisplayName: 'Norman Schneider',
  //             // googlePay: gpay,
  //           ),
  //         )
  //         .then(
  //           (value) {},
  //         );

  //     //STEP 3: Display Payment sheet
  //     displayPaymentSheet();
  //   } catch (err) {
  //     print(err);
  //   }
  // }
}
