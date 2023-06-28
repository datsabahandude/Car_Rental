import 'package:car_rental/models/order_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Cards/orderCard.dart';

class OrderBody extends StatefulWidget {
  const OrderBody({Key? key}) : super(key: key);

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  List<Object> _itemlist = [];
  bool _isLoading = true;
  String currentDate = DateFormat('d MMM yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    FilterType();
  }

  void FilterType() {
    // if (widget.status == 'Pending') {
    getItemList();
    // } else {
    //   getTodayList();
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _itemlist.isEmpty
              ? Center(
                  child: Text('No Order',
                      style: GoogleFonts.manrope(
                        textStyle: TextStyle(fontSize: 26),
                      )),
                )
              : Center(
                  child: Container(
                    constraints: const BoxConstraints(
                        maxHeight: double.infinity, maxWidth: 700),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: width,
                            height: height * 0.88,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                FilterType();
                              },
                              child: ListView.builder(
                                itemCount: _itemlist.length,
                                padding: EdgeInsets.all(12),
                                itemBuilder: (context, index) {
                                  final item = _itemlist[index];
                                  return OrderCard(item as OrderList);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Future getItemList() async {
    var data = await FirebaseFirestore.instance
        .collection("Orders")
        // .where("Status", isEqualTo: widget.status)
        .get();
    setState(() {
      _isLoading = false;
      _itemlist =
          List.from(data.docs.map((doc) => OrderList.fromSnapshot(doc)));
    });
  }

  // Future getTodayList() async {
  //   var data = await FirebaseFirestore.instance
  //       .collection("Orders")
  //       .where("Status", isEqualTo: widget.status)
  //       .where('Date', isEqualTo: currentDate)
  //       .get();
  //   setState(() {
  //     _isLoading = false;
  //     _itemlist =
  //         List.from(data.docs.map((doc) => OrderList.fromSnapshot(doc)));
  //   });
  // }
}
