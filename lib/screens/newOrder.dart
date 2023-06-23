import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  String week = '';
  int range = 0;
  String time = DateFormat("h:mm a").format(DateTime.now());
  // final carController = TextEditingController();
  final priceEditingController = TextEditingController();
  final details = TextEditingController();
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
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFFFF1C0C),
                fontWeight: FontWeight.w500,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.monetization_on_outlined,
                color: Color(0xFF702c00)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            // contentPadding: const EdgeInsets.symmetric(vertical: 40)
            hintText: "Price (RM)",
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF702c00),
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
            value = 'No Detail';
          }
        },
        onSaved: (value) {
          details.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 300),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color(0xFFFF1C0C),
                fontWeight: FontWeight.w500,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            prefixIcon: const Icon(Icons.description, color: Color(0xFF702c00)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            // contentPadding: const EdgeInsets.symmetric(vertical: 40)
            hintText: "Info",
            hintStyle: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16.0,
                color: Color(0xFF702c00),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )));
    return Scaffold(
      appBar: AppBar(title: const Text('Car Booking')),
      body: Center(
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
                      backgroundColor: Colors.deepPurpleAccent,
                      radius: 82,
                      child: const CircleAvatar(
                          backgroundImage: AssetImage("images/Alza.jpg"),
                          backgroundColor: Colors.transparent,
                          radius: 80),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField(
                      value: _selectedVal,
                      items: status
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color(0xFF702c00),
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
                        constraints: const BoxConstraints(maxWidth: 300),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      ),
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
                          color: Color(0xFF702c00)),
                      label: Text(
                        time,
                        textAlign: TextAlign.start,
                        style: const TextStyle(color: Colors.black),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                    ),
                    const SizedBox(height: 15),
                    // ElevatedButton.icon(
                    //   onPressed: () async {
                    //     DateTime? newdate = await showDatePicker(
                    //       context: context,
                    //       initialDate: datenow,
                    //       firstDate: DateTime(2020),
                    //       lastDate: DateTime(2040),
                    //     );
                    //     if (newdate == null) return;
                    //     setState(() => datenow = newdate);
                    //     date = DateFormat('d MMM yyyy, EEEE').format(datenow);
                    //     day = DateFormat('d (EEEE)').format(datenow);
                    //     DateTime firstDayOfMonth =
                    //         DateTime(datenow.year, datenow.month, 1);
                    //     int startDay = firstDayOfMonth.weekday;
                    //     int currentDay = datenow.day;
                    //     int currentWeek = ((currentDay + startDay - 1) / 7).ceil();
                    //     week =
                    //         '$currentWeek (${DateFormat('MMM').format(datenow)})';
                    //     Duration difference = datenow.difference(DateTime.now());
                    //     range = difference.inDays;
                    //   },
                    //   icon: const Icon(Icons.calendar_month_outlined,
                    //       color: Color(0xFF702c00)),
                    //   label: Text(date),
                    //   style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all(Colors.white)),
                    // ),
                    ElevatedButton(
                      onPressed: () async {
                        DateTimeRange? newdate = await showDateRangePicker(
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
                          color: Color(0xFF702c00)),
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
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              '$startDate\n-\n$endDate\n${selectedDates.duration.inDays} Day(s)',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 15),
                    priceField,
                    const SizedBox(height: 15),
                    detailsField,
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
