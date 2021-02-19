import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appp/Admin/adminOrderDetails.dart';
import 'package:flutter_appp/Models/item.dart';
import 'package:flutter_appp/Widgets/orderCard.dart';

int counter = 0;

class AdminOrderCard extends StatelessWidget {
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderId;
  final String addressID;
  final String orderBy;

  AdminOrderCard(
      {Key key,
      this.itemCount,
      this.data,
      this.orderId,
      this.addressID,
      this.orderBy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Route route;
        if (counter == 0) {
          counter = counter + 1;
          route = MaterialPageRoute(
              builder: (c) => AdminOrderDetails(
                  orderId: orderId, orderBy: orderBy, addressID: addressID));
        }
        Navigator.push(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount * 190.0,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c, index) {
            ItemModel model = ItemModel.fromJson(data[index].data);
            return sourceOrderInfo(model, context);
          },
        ),
      ),
    );
  }
}
