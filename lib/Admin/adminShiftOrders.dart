import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appp/Admin/adminOrderCard.dart';
import 'package:flutter_appp/Config/config.dart';

import '../Widgets/loadingWidget.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<AdminShiftOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            centerTitle: true,
            title: Text(
              'Oy Orders',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.white,
                ),
                onPressed: () {
                  SystemNavigator.pop();
                },
              )
            ],
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("orders").snapshots(),
            builder: (c, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (c, index) {
                        return FutureBuilder<QuerySnapshot>(
                          future: Firestore.instance
                              .collection("items")
                              .where("shortInfo",
                                  whereIn: snapshot.data.documents[index]
                                      .data[EcommerceApp.productID])
                              .getDocuments(),
                          builder: (c, snap) {
                            return snap.hasData
                                ? AdminOrderCard(
                                    itemCount: snap.data.documents.length,
                                    data: snap.data.documents,
                                    orderId: snapshot
                                        .data.documents[index].documentID,
                                    orderBy: snapshot
                                        .data.documents[index].data["orderBy"],
                                    addressID: snapshot.data.documents[index]
                                        .data["addressID"],
                                  )
                                : Center(
                                    child: circularProgress(),
                                  );
                          },
                        );
                      },
                    )
                  : Center(
                      child: circularProgress(),
                    );
            },
          )),
    );
  }
}
