import 'package:tugsuyoo/features/ondboarding/screens/onboarding_screen.dart';
import 'package:tugsuyoo/login/forgot_password.dart';
import 'package:tugsuyoo/login/service/auth.dart';
import 'package:tugsuyoo/login/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const OnboardingScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
   
      body: Stack(
        children: [
          Image.asset(
            "assets/images/1_morning_bird.jpeg",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8).withOpacity(0.6), // Adjust opacity here
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter E-mail';
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf),
                                    fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8).withOpacity(0.6), // Adjust opacity here
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            controller: passwordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf),
                                    fontSize: 18.0)),
                            obscureText: true,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = mailcontroller.text;
                                password = passwordcontroller.text;
                              });
                              userLogin();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Transparent background
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white, width: 1), // White border
                            ),
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: const Text("Forgot Password?",
                              style: TextStyle(
                                  color: Color(0xFF8c8e98),
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                       
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                AuthMethods().signInWithGoogle(context);
                              },
                              child: Image.asset(
                                "assets/images/google.png",
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                AuthMethods().signInWithApple();
                              },
                              child: Image.asset(
                                "assets/images/apple1.png",
                                height: 35,
                                width: 35,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: TextStyle(
                                    color: Color(0xFF8c8e98),
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 247, 248, 248),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}