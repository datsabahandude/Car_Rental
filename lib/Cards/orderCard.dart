import 'package:car_rental/models/order_display.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// import '../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderList card;
  const OrderCard(this.card, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Status
    var statusColor = card.status == 'Done'
        ? const Color(0xFF000000)
        : card.status == 'Cancelled'
            ? const Color(0xFFFF1C0C)
            : card.status == 'Reschedule'
                ? const Color(0xFF3B0B55)
                : Colors.amber[900];

    /// Date
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse('${card.time}'));
    String displayDate = DateFormat('d MMM yyyy').format(date);

    /// Time
    TimeOfDay time = TimeOfDay.fromDateTime(date);
    String displayTime = time.format(context).toString();

    /// Difference
    String bila = '';
    var bilaColor = Colors.white;
    Duration difference = date.difference(DateTime.now());
    int days = difference.inDays;
    int hours = difference.inHours;
    int minutes = difference.inMinutes % 60;
    if (card.status == 'Done') {
    } else if (days == 0) {
      if (int.parse('${card.time}') < DateTime.now().millisecondsSinceEpoch) {
        minutes = 60 - minutes;
        if (minutes == 60) {
          minutes = 0;
        }
        bila = '$hours hour : $minutes minute(s) late';
        bilaColor = const Color(0xFFFF1C0C);
      } else {
        //today
        // int i = index + 1;
        // notifService(displayTime, i);
        bila = '$hours hour : $minutes minute(s)';
        bilaColor = const Color(0xFF00B406);
      }
    } else if (days > 0) {
      bila = '$days Day(s) left';
      bilaColor = const Color(0xFF000000);
    } else {
      days = days * -1;
      bila = '$days day(s) late';
      bilaColor = const Color(0xFFFF1C0C);
    }

    /// price
    double price = double.parse('${card.price}');
    //
    double width = MediaQuery.of(context).size.width;
    return Container(
      constraints:
          const BoxConstraints(maxHeight: double.infinity, maxWidth: 550),
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 3 / 1,
            child: Row(children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: card.img == null
                        ? Image.asset(
                            'assets/ezorder.png',
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            '${card.img}',
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Image.asset('assets/ezorder.png',
                                  fit: BoxFit.cover);
                            },
                          ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: card.img == null
                                ? Image.asset(
                                    'assets/ezorder.png',
                                    fit: BoxFit.cover,
                                    width: width,
                                  )
                                : Image.network('${card.img}',
                                    fit: BoxFit.cover, width: width,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                    return Image.asset('assets/ezorder.png',
                                        fit: BoxFit.cover);
                                  }),
                          );
                        }));
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              AspectRatio(
                aspectRatio: 5 / 3,
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${card.customer}',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  textStyle: const TextStyle(
                                      color: Color(0xFF702c00),
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${card.status}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: statusColor,
                                      fontWeight: FontWeight.w600)),
                              // softWrap: false,
                              // maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${card.location}',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'RM $price',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF00B406),
                                      fontWeight: FontWeight.w600)),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            displayDate,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 121, 97, 255),
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            displayTime,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Color(0xFFC21C1C),
                                    fontWeight: FontWeight.w600)),
                          )
                        ],
                      ),
                      Text(
                        bila,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: bilaColor, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            content: SingleChildScrollView(
                              child: ListBody(children: [
                                InkWell(
                                  splashColor: const Color(0xFF702c00),
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        'Edit',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  splashColor: const Color(0xFF702c00),
                                  onTap: () {
                                    // _delete();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const HomePage()),
                                    // );
                                  },
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        'Delete',
                                        style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFC21C1C),
                                          fontWeight: FontWeight.w500,
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          );
                        }));
                  },
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

  /// Notification
  // Future notifService(time, index) async {
  //   await NotificationService.showNotification(
  //       id: index, title: 'Pending Order', body: 'Today at $time');
  // }

  // Future _delete() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   OrderModel orderModel = OrderModel();
  //   orderModel.uid = user!.uid;
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(user.uid)
  //         .collection('Orders')
  //         .doc('${card.oid}')
  //         .delete();
  //     if (card.img != null) {
  //       // FirebaseStorage.instance.refFromURL('${card.img}').delete();
  //     }
  //     Fluttertoast.showToast(
  //         msg: "Deleted\n(｡•᎔•｡)",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: const Color(0xFFC21C1C),
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } catch (e) {
  //     Fluttertoast.showToast(
  //         msg: "Something went wrong!\n(｡•᎔•｡)",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
