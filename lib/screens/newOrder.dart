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
            value = 'No Detail';
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
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Car Booking',
        style: GoogleFonts.manrope(),
      )),
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
                      backgroundColor: const Color(0xff360c72),
                      radius: 82,
                      child: _selectedVal == 'MYVI GEN3'
                          ? const CircleAvatar(
                              backgroundImage: AssetImage("images/Myvi.jpg"),
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
                                      backgroundColor: Colors.transparent,
                                      radius: 80)
                                  : _selectedVal == 'AVANZA'
                                      ? const CircleAvatar(
                                          backgroundImage:
                                              AssetImage("images/Avanza.jpg"),
                                          backgroundColor: Colors.transparent,
                                          radius: 80)
                                      : _selectedVal == 'BEZZA'
                                          ? const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "images/Bezza.jpg"),
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 80)
                                          : _selectedVal == 'EXORA TURBO'
                                              ? const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "images/Exora.jpg"),
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  radius: 80)
                                              : _selectedVal == 'SAGA'
                                                  ? const CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(
                                                              "images/Saga.jpg"),
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius: 80)
                                                  : const CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(
                                                              "images/Alza.jpg"),
                                                      backgroundColor:
                                                          Colors.transparent,
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
                            textStyle: const TextStyle(color: Colors.black)),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                    ),
                    const SizedBox(height: 15),
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
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
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
        onPressed: () {},
        backgroundColor: Colors.white,
        icon: Text('submit'.toUpperCase(),
            style: GoogleFonts.manrope(
                textStyle: const TextStyle(fontSize: 16, color: Colors.black))),
        label: const Icon(
          Icons.fact_check,
          color: Color(0xff360c72),
        ),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
      ),
    );
  }
}
