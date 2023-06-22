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
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  final _formKey = GlobalKey<FormState>();
  final status = ['Pending', 'Done', 'Cancelled', 'Reschedule'];
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
  final carController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                // carField,
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
                        endDate =
                            DateFormat('d MMM yyyy, EEEE').format(newdate.end);
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Icon(Icons.calendar_month_outlined,
                      color: Color(0xFF702c00)),
                ),
                startDate != null
                    ? Text(
                        'From:\n$startDate\nTo:\n$endDate',
                        textAlign: TextAlign.center,
                      )
                    : Container(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
