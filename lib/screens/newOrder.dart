import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../models/order_model.dart';
import 'homepage.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder>
    with SingleTickerProviderStateMixin {
  _NewOrderState() {
    _selectedVal = status[0];
  }
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final status = [
    'MYVI GEN3',
    'AXIA',
    'ALZA',
    'AVANZA',
    'BEZZA',
    'EXORA TURBO',
    'SAGA'
  ];
  String? _selectedVal = '';
  DateTime datenow = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();
  String date = DateFormat('d MMM yyyy, EEEE').format(DateTime.now());
  String day = DateFormat('d (EEEE)').format(DateTime.now());
  String? startDate;
  String? endDate;
  String time = DateFormat("h:mm a").format(DateTime.now());
  final priceEditingController = TextEditingController();
  final details = TextEditingController();
  bool isLoading = false;

  /// Firebase
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // User? user = FirebaseAuth.instance.currentUser;
  // order model
  OrderModel orderModel = OrderModel();
  @override
  void dispose() {
    priceEditingController.dispose();
    details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final priceField = TextFormField(
        maxLength: 7,
        autofocus: false,
        controller: priceEditingController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Price?';
          }
          return null;
        },
        onSaved: (value) {
          priceEditingController.text = value!;
        },
        decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 300),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.manrope(
              textStyle: const TextStyle(
                color: Color(0xFFFF1C0C),
                fontWeight: FontWeight.w500,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.monetization_on_outlined,
                color: Color(0xff360c72)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            // contentPadding: const EdgeInsets.symmetric(vertical: 40)
            hintText: "Price (RM)",
            hintStyle: GoogleFonts.manrope(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    final detailsField = TextFormField(
        minLines: 1,
        maxLines: 6,
        autofocus: false,
        controller: details,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return value = 'No Detail';
          } else {
            return null;
          }
        },
        onSaved: (value) {
          details.text = value!;
        },
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 300),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.manrope(
              textStyle: const TextStyle(
                color: Color(0xFFFF1C0C),
                fontWeight: FontWeight.w500,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.description, color: Color(0xff360c72)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            // contentPadding: const EdgeInsets.symmetric(vertical: 40)
            hintText: "Info",
            hintStyle: GoogleFonts.manrope(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Car Booking',
          style: GoogleFonts.manrope(),
        )),
        body: isLoading
            ? Center(
                child: Lottie.asset('images/car-revolving-animation.json'),
              )
            : Center(
                child: Container(
                  height: height,
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 15),
                            CircleAvatar(
                              backgroundColor: const Color(0xff360c72),
                              radius: 82,
                              child: _selectedVal == 'MYVI GEN3'
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage("images/Myvi.jpg"),
                                      backgroundColor: Colors.transparent,
                                      radius: 80)
                                  : _selectedVal == 'AXIA'
                                      ? const CircleAvatar(
                                          backgroundImage:
                                              AssetImage("images/Axia.jpg"),
                                          backgroundColor: Colors.transparent,
                                          radius: 80)
                                      : _selectedVal == 'ALZA'
                                          ? const CircleAvatar(
                                              backgroundImage:
                                                  AssetImage("images/Alza.jpg"),
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 80)
                                          : _selectedVal == 'AVANZA'
                                              ? const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "images/Avanza.jpg"),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 80)
                                              : _selectedVal == 'BEZZA'
                                                  ? const CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          "images/Bezza.jpg"),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius: 80)
                                                  : _selectedVal ==
                                                          'EXORA TURBO'
                                                      ? const CircleAvatar(
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "images/Exora.jpg"),
                                                          backgroundColor: Colors
                                                              .transparent,
                                                          radius: 80)
                                                      : _selectedVal == 'SAGA'
                                                          ? const CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      "images/Saga.jpg"),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              radius: 80)
                                                          : const CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      "images/Alza.jpg"),
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              radius: 80),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton.icon(
                              onPressed: () async {
                                TimeOfDay? newtime = await showTimePicker(
                                  context: context,
                                  initialTime: timenow,
                                );
                                if (newtime != null) {
                                  setState(() {
                                    timenow = newtime;

                                    /// format(context) means follow device default clock format (12hr-24hr)
                                    time = timenow.format(context).toString();
                                  });
                                }
                              },
                              icon: const Icon(Icons.av_timer_outlined,
                                  color: Color(0xff360c72)),
                              label: Text(
                                time,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.manrope(
                                    textStyle:
                                        const TextStyle(color: Colors.black)),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () async {
                                DateTimeRange? newdate =
                                    await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2040),
                                );
                                if (newdate != null) {
                                  setState(() {
                                    selectedDates = newdate;
                                    startDate = DateFormat('d MMM yyyy, EEEE')
                                        .format(newdate.start);
                                    endDate = DateFormat('d MMM yyyy, EEEE')
                                        .format(newdate.end);
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white)),
                              child: const Icon(Icons.calendar_month_outlined,
                                  color: Color(0xff360c72)),
                            ),
                            const SizedBox(height: 15),
                            startDate != null
                                ? Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20.0,
                                            spreadRadius: 2.0,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                        '$startDate\n-\n$endDate\n${selectedDates.duration.inDays} Day(s)',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.manrope()),
                                  )
                                : Container(),
                            const SizedBox(height: 15),
                            DropdownButtonFormField(
                              value: _selectedVal,
                              items: status
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedVal = val as String;
                                });
                              },
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                constraints:
                                    const BoxConstraints(maxWidth: 300),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              ),
                            ),
                            const SizedBox(height: 30),
                            priceField,
                            const SizedBox(height: 15),
                            detailsField,
                            const SizedBox(height: 100)
                          ]),
                    ),
                  ),
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final isValid = _formKey.currentState!.validate();
            if (selectedDates.duration.inDays == 0) {
              Fluttertoast.showToast(
                  msg: "Please select date",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else if (isValid) {
              setState(() {
                isLoading = true;
              });
              postDetailsToFireStore();
            } else if (!isValid) {
              Fluttertoast.showToast(
                  msg: "Insufficient credentials",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: "Waduuh Error APAKA!!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          backgroundColor: Colors.white,
          icon: Text('submit'.toUpperCase(),
              style: GoogleFonts.manrope(
                  textStyle:
                      const TextStyle(fontSize: 16, color: Colors.black))),
          label: const Icon(
            Icons.fact_check,
            color: Color(0xff360c72),
          ),
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
        ),
      ),
    );
  }

  Future postDetailsToFireStore() async {
    var oid = DateTime.now().toString();
    int sendtime = DateTime(selectedDates.start.year, selectedDates.start.month,
            selectedDates.start.day, timenow.hour, timenow.minute)
        .millisecondsSinceEpoch;
    // User? user = _auth.currentUser;
    // orderModel.uid = user!.uid;
    orderModel.oid = oid;
    orderModel.price = priceEditingController.text;
    orderModel.info = details.text;
    orderModel.time = sendtime;
    orderModel.range =
        '$startDate\n-\n$endDate\n${selectedDates.duration.inDays} Day(s)';
    orderModel.status = 'Pending';
    orderModel.img = _selectedVal!;

    await firebaseFirestore
        .collection('Orders')
        .doc(oid) //empty = random generate
        .set(orderModel.toMap());
    Fluttertoast.showToast(
      msg: "Added Successfully!\n (,,･`∀･)ﾉ",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
    setState(() => isLoading = false);
  }
}
