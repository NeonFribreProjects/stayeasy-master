import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colorPallete.dart';
import '../../../lists/customer_service_list.dart';
import '../../../reusable_widgets/back_button.dart';
import '../../../reusable_widgets/my_text_widget.dart';

class ContactCustomerService extends StatelessWidget {
  const ContactCustomerService({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          leading: MyBackButton(kwhite),
          title: MyText(
            text: 'Customer Service',
            color: kwhite,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 50,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'How Can We Help? We\'re Available 24 Hours A Day',
                  size: 15.sp,
                  weight: FontWeight.bold,
                ),
                Container(
                  width: Get.width,
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kwhite,
                    boxShadow: [
                      BoxShadow(
                        color: kblack.withOpacity(0.16),
                        offset: Offset(0, 6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Icon ionic-md-chatboxes.png',
                            height: 25,
                          ),
                          SizedBox(width: 15),
                          MyText(
                            text: 'Send Us A Message',
                            size: 15.sp,
                            weight: FontWeight.bold,
                          )
                        ],
                      ),
                      SizedBox(height: 35),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Icon feather-phone-call.png',
                            height: 25,
                          ),
                          SizedBox(width: 15),
                          MyText(
                              text: 'Call Us',
                              size: 15.sp,
                              weight: FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyText(
                  text: 'Frequently Asked Questions',
                  size: 15.sp,
                  weight: FontWeight.bold,
                ),
                SizedBox(height: 30),
                ...List.generate(
                  expandHeader.length,
                  (index) => Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(iconColor: kblack),
                          header: MyText(
                            text: expandHeader[index],
                            size: 10.sp,
                            weight: FontWeight.bold,
                            color: kblack,
                          ),
                          collapsed: Text(
                            '',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Text(
                            'article.body',
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
