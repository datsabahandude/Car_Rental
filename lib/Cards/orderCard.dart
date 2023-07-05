import 'package:car_rental/models/order_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import '../screens/homepage.dart';

class OrderCard extends StatelessWidget {
  final OrderList card;
  const OrderCard(this.card, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// Status
    var statusColor = card.status == 'Completed'
        ? const Color(0xFF000000)
        : card.status == 'In Progress'
            ? const Color(0xFF00B406)
            : Colors.amber[900];

    /// Date
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse('${card.time}'));
    // String displayDate = DateFormat('d MMM yyyy').format(date);

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
    final priceEditingController = TextEditingController();
    final infoEditingController = TextEditingController();
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
            aspectRatio: 3 / 2,
            child: Row(children: [
              AspectRatio(
                aspectRatio: 3 / 5,
                child: InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: card.img == 'MYVI GEN3'
                        ? Image.asset(
                            'images/Myvi.jpg',
                            fit: BoxFit.cover,
                          )
                        : card.img == 'AXIA'
                            ? Image.asset('images/Axia.jpg', fit: BoxFit.cover)
                            : card.img == 'ALZA'
                                ? Image.asset('images/Alza.jpg',
                                    fit: BoxFit.cover)
                                : card.img == 'AVANZA'
                                    ? Image.asset('images/Avanza.jpg',
                                        fit: BoxFit.cover)
                                    : card.img == 'BEZZA'
                                        ? Image.asset('images/Bezza.jpg',
                                            fit: BoxFit.cover)
                                        : card.img == 'EXORA TURBO'
                                            ? Image.asset('images/Exora.jpg',
                                                fit: BoxFit.cover)
                                            : Image.asset(
                                                'images/Saga.jpg',
                                                fit: BoxFit.cover,
                                              ),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            backgroundColor: Colors.transparent,
                            content: card.img == 'MYVI GEN3'
                                ? Image.asset(
                                    'images/Myvi.jpg',
                                    fit: BoxFit.cover,
                                  )
                                : card.img == 'AXIA'
                                    ? Image.asset('images/Axia.jpg',
                                        fit: BoxFit.cover)
                                    : card.img == 'ALZA'
                                        ? Image.asset('images/Alza.jpg',
                                            fit: BoxFit.cover)
                                        : card.img == 'AVANZA'
                                            ? Image.asset('images/Avanza.jpg',
                                                fit: BoxFit.cover)
                                            : card.img == 'BEZZA'
                                                ? Image.asset(
                                                    'images/Bezza.jpg',
                                                    fit: BoxFit.cover)
                                                : card.img == 'EXORA TURBO'
                                                    ? Image.asset(
                                                        'images/Exora.jpg',
                                                        fit: BoxFit.cover)
                                                    : Image.asset(
                                                        'images/Saga.jpg',
                                                        fit: BoxFit.cover,
                                                      ),
                          );
                        }));
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              AspectRatio(
                aspectRatio: 4 / 5,
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              '${card.img}',
                              style: GoogleFonts.manrope(
                                  fontSize: 14,
                                  textStyle: const TextStyle(
                                      color: Color(0xFF702c00),
                                      fontWeight: FontWeight.bold)),
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${card.status}',
                              style: GoogleFonts.manrope(
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
                              displayTime,
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.amber[900],
                                      fontWeight: FontWeight.w600)),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'RM $price',
                              style: GoogleFonts.manrope(
                                  textStyle: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF00B406),
                                      fontWeight: FontWeight.w600)),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                      Text(
                        '${card.range}',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      card.status == 'Pending'
                          ? Text(
                              bila,
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: bilaColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            )
                          : Container(),
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
                                card.status == 'Completed'
                                    ? Container()
                                    : InkWell(
                                        splashColor: const Color(0xff360c72),
                                        onTap: () {
                                          card.status == 'Pending'
                                              ? _edit('Pending')
                                              : _edit('In Progress');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomePage()),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.green,
                                              ),
                                            ),
                                            card.status == 'Pending'
                                                ? Text(
                                                    'In Progress',
                                                    style: GoogleFonts.manrope(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF00B406),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                  )
                                                : Text(
                                                    'Completed',
                                                    style: GoogleFonts.manrope(
                                                        textStyle:
                                                            const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF00B406),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                                  )
                                          ],
                                        ),
                                      ),
                                InkWell(
                                  splashColor: const Color(0xff360c72),
                                  onTap: () {
                                    priceEditingController.text = '$price';
                                    infoEditingController.text = '${card.info}';
                                    showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: Text('Info',
                                                style: GoogleFonts.manrope()),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    minLines: 1,
                                                    maxLines: 6,
                                                    autofocus: false,
                                                    textInputAction:
                                                        TextInputAction.newline,
                                                    controller:
                                                        infoEditingController,
                                                    onSaved: (value) {
                                                      priceEditingController
                                                          .text = value!;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 200),
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never,
                                                      prefixIcon: Icon(
                                                          Icons.description,
                                                          color: Color(
                                                              0xff360c72)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  TextFormField(
                                                      maxLength: 7,
                                                      autofocus: false,
                                                      controller:
                                                          priceEditingController,
                                                      keyboardType:
                                                          const TextInputType
                                                                  .numberWithOptions(
                                                              decimal: true),
                                                      inputFormatters: <TextInputFormatter>[
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'^(\d+)?\.?\d{0,2}'))
                                                      ],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Price?';
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (value) {
                                                        priceEditingController
                                                            .text = value!;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        constraints:
                                                            const BoxConstraints(
                                                                maxWidth: 200),
                                                        floatingLabelBehavior:
                                                            FloatingLabelBehavior
                                                                .never,
                                                        errorStyle:
                                                            GoogleFonts.manrope(
                                                          textStyle:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFFFF1C0C),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        fillColor: const Color(
                                                            0xFFE9E9E9),
                                                        filled: true,
                                                        prefixIcon: const Icon(
                                                            Icons
                                                                .monetization_on_outlined,
                                                            color: Color(
                                                                0xff360c72)),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                20, 15, 20, 15),
                                                        // contentPadding: const EdgeInsets.symmetric(vertical: 40)
                                                        hintText: "Price (RM)",
                                                        hintStyle:
                                                            GoogleFonts.manrope(
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 5, 0, 5),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      _editInfo(
                                                          priceEditingController
                                                              .text,
                                                          infoEditingController
                                                              .text);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const HomePage()),
                                                      );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                            Colors.white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12))),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: Text(
                                                      'update info'
                                                          .toUpperCase(),
                                                      style: GoogleFonts.manrope(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        }));
                                  },
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.fact_check,
                                          color: Color(0xff360c72),
                                        ),
                                      ),
                                      Text(
                                        'Info details',
                                        style: GoogleFonts.manrope(
                                            textStyle: const TextStyle(
                                          fontSize: 18,
                                          // color: Color(0xFFC21C1C),
                                          fontWeight: FontWeight.w500,
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  splashColor: const Color(0xff360c72),
                                  onTap: () {
                                    _delete();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomePage()),
                                    );
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
                                        style: GoogleFonts.manrope(
                                            textStyle: const TextStyle(
                                          fontSize: 18,
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

  Future _delete() async {
    try {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc('${card.oid}')
          .delete();
      Fluttertoast.showToast(
          msg: "Deleted",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color(0xFFC21C1C),
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong!\n(｡•᎔•｡)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future _edit(status) async {
    String sts;
    if (status == 'Pending') {
      sts = 'In Progress';
    } else {
      sts = 'Completed';
    }
    try {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc('${card.oid}')
          .update({'status': sts});
      Fluttertoast.showToast(
          msg: "Status Changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong!\n(｡•᎔•｡)",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future _editInfo(price, info) async {
    try {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc('${card.oid}')
          .update({'price': price, 'info': info});
      Fluttertoast.showToast(
          msg: "Status Changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
