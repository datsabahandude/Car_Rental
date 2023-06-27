import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  late String _email, _password;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xff360c72),
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const Center(
                            child: CircleAvatar(
                          backgroundColor: Color(0xff360c72),
                          radius: 120,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/Alza.jpg'),
                            radius: 118,
                          ),
                        )),
                        _buildEmail(),
                        const SizedBox(height: 5),
                        _buildPassword(),
                        const SizedBox(height: 10),
                        _buildLogin(),
                        const Padding(padding: EdgeInsets.all(5.0)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const Register()));
                                Fluttertoast.showToast(
                                    msg: "(☞ﾟ∀ﾟ)☞ HAHAHAHA",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: const Color(0xff360c72),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xff360c72),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  void _loginSave() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      Fluttertoast.showToast(
          msg: "(☞ﾟ∀ﾟ)☞ Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomePage()),
      // );
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      Fluttertoast.showToast(
          msg: "ｰ(  ｰ̀дｰ́ )Incorrect Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {},
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFFF1100),
              fontWeight: FontWeight.w700,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.email,
            color: Color(0xff360c72),
          ),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.purple),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter your Email !';
          } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid Email");
          }
          return null;
        },
        onSaved: (val) => setState(() => _email = val!),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: TextFormField(
        obscureText: true,
        onChanged: (value) {},
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          errorStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Color(0xFFFF1100),
              fontWeight: FontWeight.w700,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(
            Icons.lock,
            color: Color(0xff360c72),
          ),
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.purple),
          ),
        ),
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return 'Minimum 6 characters !';
          }
          if (!regex.hasMatch(value)) {
            return ("Please Enter Valid Password !");
          }
        },
        onSaved: (val) => setState(() => _password = val!),
      ),
    );
  }

  Widget _buildLogin() {
    return Material(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width * 0.6,
        onPressed: () {
          if (_formkey.currentState!.validate()) {
            _formkey.currentState!.save();
            setState(() => isLoading = true);
            _loginSave();
          }
        },
        child: Text(
          "LOGIN",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
                fontSize: 20,
                color: Color(0xff360c72),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
