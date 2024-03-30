import 'package:tugsuyoo/features/home/screens/home_screen.dart';
import 'package:tugsuyoo/features/ondboarding/screens/onboarding_screen.dart';
import 'package:tugsuyoo/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && namecontroller.text != "" && mailcontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password,);
            User? user = userCredential.user;
if (user != null) {
  await user.updateDisplayName(name);
}
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/3_evening.jpeg",
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Name';
                              }
                              return null;
                            },
                            controller: namecontroller,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            controller: mailcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                          decoration: BoxDecoration(
                              color: Color(0xFFedf0f8),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }
                              return null;
                            },
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    color: Color(0xFFb2b7bf), fontSize: 18.0)),
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
                                name = namecontroller.text;
                                password = passwordcontroller.text;
                              });
                              registration();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Transparent background
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white, width: 1), // White border
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/google.png",
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Image.asset(
                      "assets/images/apple1.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(
                            color: Color(0xFF8c8e98),
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LogIn()));
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                            color: Color.fromARGB(255, 249, 249, 250),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}