import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardSkeleton extends StatelessWidget {
  final int itemCount;

  CardSkeleton({this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 226, 21, 21),
            highlightColor: Color.fromARGB(255, 139, 39, 39),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 100.0,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: double.infinity,
                  height: 16.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 100.0,
                  height: 16.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
