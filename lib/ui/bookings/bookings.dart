import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_easy/constants/colorPallete.dart';
import 'package:stay_easy/reusable_widgets/my_text_widget.dart';

import 'active.dart';
import 'cancellled.dart';
import 'past.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kprimary,
          centerTitle: true,
          title: MyText(
            text: 'Bookings',
            color: kwhite,
            size: 15.sp,
            weight: FontWeight.bold,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Material(
              color: kwhite,
              child: Theme(
                //<-- SEE HERE
                data: ThemeData().copyWith(
                  splashColor: kprimary,
                ),
                child: TabBar(
                  unselectedLabelColor: kblack,
                  labelStyle: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: kprimary,
                  labelColor: kprimary,
                  padding: EdgeInsets.only(top: 10),
                  tabs: [
                    Tab(text: 'Active'),
                    Tab(text: 'Past'),
                    Tab(text: 'Cancelled')
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ActiveCard(),
            PastCard(),
            CancelledCard(),
          ],
        ),
      ),
    );
  }
}
