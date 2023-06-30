import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/Order_Body.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Completed History',
          style: GoogleFonts.manrope(
            textStyle:
                const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: const OrderBody(
        msg: 'history',
      ),
    );
  }
}
