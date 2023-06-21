import 'package:flutter/material.dart';
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
  final _formKey = GlobalKey<FormState>();
  final status = ['Pending', 'Done', 'Cancelled', 'Reschedule'];
  String? _selectedVal = '';
  DateTime datenow = DateTime.now();
  TimeOfDay timenow = TimeOfDay.now();
  String date = DateFormat('d MMM yyyy, EEEE').format(DateTime.now());
  String day = DateFormat('d (EEEE)').format(DateTime.now());
  String week = '';
  int range = 0;
  String time = DateFormat("h:mm a").format(DateTime.now());
  final carController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    final carField = TextFormField(
        maxLength: 15,
        autofocus: false,
        controller: carController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Car ?';
          }
        },
        onSaved: (value) {
          carController.text = value!;
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
            prefixIcon: const Icon(Icons.directions_car_filled,
                color: Color(0xFF702c00)),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Car",
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
              child: Column(children: [
                carField,
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
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    DateTime? newdate = await showDatePicker(
                      context: context,
                      initialDate: datenow,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2040),
                    );
                    if (newdate == null) return;
                    setState(() => datenow = newdate);
                    date = DateFormat('d MMM yyyy, EEEE').format(datenow);
                    day = DateFormat('d (EEEE)').format(datenow);
                    DateTime firstDayOfMonth =
                        DateTime(datenow.year, datenow.month, 1);
                    int startDay = firstDayOfMonth.weekday;
                    int currentDay = datenow.day;
                    int currentWeek = ((currentDay + startDay - 1) / 7).ceil();
                    week =
                        '$currentWeek (${DateFormat('MMM').format(datenow)})';
                    Duration difference = datenow.difference(DateTime.now());
                    range = difference.inDays;
                  },
                  icon: const Icon(Icons.calendar_month_outlined,
                      color: Color(0xFF702c00)),
                  label: Text(date),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
