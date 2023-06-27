import 'package:car_rental/screens/newOrder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../Cards/orderCard.dart';
import '../models/order_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLottie = false;

  /// Firebase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  User? user = FirebaseAuth.instance.currentUser;
  // OrderModel orderModel = OrderModel();
  List<Object> _itemlist = [];
  bool display = false;
  double profit = 0;
  double sum = 0;
  @override
  void initState() {
    super.initState();
    getItemList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: isLottie
          ? Center(
              child: Lottie.asset('images/security-car-black.json'),
            )
          : DefaultTabController(
              length: 3,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Syukri Car Rental',
                    style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          getItemList();
                        },
                        icon: const Icon(Icons.refresh))
                  ],
                  bottom: TabBar(
                    labelColor: Colors.white,
                    labelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    unselectedLabelColor: Colors.white,
                    unselectedLabelStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.normal)),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const <Widget>[
                      Tab(child: Text('Pending')),
                      Tab(child: Text('Done')),
                      Tab(child: Text('All')),
                    ],
                  ),
                ),
                body: TabBarView(children: [
                  buildScreen(0),
                  buildScreen(1),
                  buildScreen(2),
                ]),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  onPressed: () async {
                    setState(() => isLottie = true);
                    await Future.delayed(const Duration(seconds: 4), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewOrder()));
                    });
                  },
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF702c00),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildScreen(page) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    if (_itemlist.isEmpty) {
      return const Center(
          child: Text(
        'No Order?',
        style: TextStyle(color: Color(0xFF702c00), fontSize: 26),
      )
          // child: CircularProgressIndicator(
          //   backgroundColor: Color(0xFF702c00),
          //   valueColor: AlwaysStoppedAnimation(Colors.white),
          // ),
          );
    } else {
      return Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              width: width,
              height: height * 0.88,
              child: RefreshIndicator(
                onRefresh: () async {
                  getItemList();
                },
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _itemlist.length,
                    itemBuilder: ((context, index) {
                      final item = _itemlist[index];
                      final screen = page;
                      item as OrderList;
                      if (item.status == 'Done' && page == 1) {
                        profit += double.parse('${item.price}');
                      }
                      return OrderCard(item, index: index, screen: screen);
                    })),
              ),
            ),
          ),
          page == 1
              ? Center(
                  child: ElevatedButton(
                  onPressed: () {
                    if (!display) {
                      setState(() {
                        display = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: display
                      ? Text(
                          '\$ $profit',
                          style: const TextStyle(color: Color(0xFF00B406)),
                        )
                      : const Text('Calculate Profit'),
                ))
              : Container()
        ],
      );
    }
  }

  Future getItemList() async {
    profit = 0;
    display = false;
    var data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .collection('Orders')
        .orderBy('time')
        .get();
    setState(() {
      _itemlist =
          List.from(data.docs.map((doc) => OrderList.fromSnapshot(doc)));
    });
  }
}
