import 'package:flutter/material.dart';
import '../hotel_page/hotel_page.dart';
import 'body.dart';

// ignore: must_be_immutable
class SelectRoomsView extends StatelessWidget {
  var data;

  SelectRoomsView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    print(data['rooms'].length);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(
                title: data["name"],
                subHeading: data['country'],
                propertyId: data['id'],
                propertyType:
                    data['longstayProperty'] ? "longStay" : "shortStay",
                bookMarkId: "N/A",
              ),
              ...List.generate(
                data['rooms'].length,
                (index) => Body(
                  data['rooms'][index],
                  context,
                  data['id'],
                  data['pictures'],
                  index,
                  data['longstayProperty'] ? "longStay" : "shortStay",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/* 
{
   numberOfRooms: 2, 
   roomType: SingleRoom, 
   numberOfBathrooms: 1, 
   availability: Immediately, 
   furnished: true, 
   lease: MinimumSixMonths, 
   parking: true, 
   pricePerNight: 1050, 
   discountedPrice: 100, 
   cancellation: NonRefundable, 
   cancellationFine: FirstNightPrice, 
}
 */