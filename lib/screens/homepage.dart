import 'package:car_rental/screens/historypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../components/Order_Body.dart';
import 'login_page.dart';
import 'newOrder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLottie = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: isLottie
          ? Container(
              color: Colors.white,
              width: double.infinity,
              alignment: Alignment.center,
              child: Lottie.asset('images/security-car-black.json'),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.exit_to_app_outlined),
                ),
                centerTitle: true,
                title: Text(
                  'Syukri Car Rental',
                  style: GoogleFonts.manrope(
                    textStyle: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoryPage()));
                      },
                      icon: const Icon(Icons.history))
                ],
              ),
              body: const OrderBody(
                msg: 'home',
              ),
              floatingActionButton: FloatingActionButton(
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
                ),
              ),
            ),
    );
  }
}
