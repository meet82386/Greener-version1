import 'package:greener_v1/controllers/auth_controller.dart';
import 'package:greener_v1/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'forgot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topRight,
      //     end: Alignment.bottomLeft
      //   , colors: [
      //     Colors.teal,
      //     Colors.cyanAccent,
      //   ])
      // ),

      child: Scaffold(
        // backgroundColor: Colors.transparent,
        backgroundColor: Colors.green[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   width: w,
              //   height: h*0.3,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage(
              //         "img/tree_PNG104381.png"
              //       ),
              //       fit: BoxFit.cover
              //     )
              //   ),
              // ),
              SizedBox(
                height: 45,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Greener",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text(
                          "E-mail:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "xyz@gmail.com",
                            prefixIcon: Icon(Icons.email, color: Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Password:",
                          style:
                              TextStyle(fontSize: 20, color: Colors.green[600]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ]),
                      child: TextField(
                        controller: passwordController,
                        obscureText: !_isVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: _isVisible
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.green,
                                  ),
                          ),
                          // focusedBorder: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(10),
                          //     borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        RichText(
                            text: TextSpan(
                          text: "Forgot Password?",
                          style:
                              TextStyle(color: Colors.green[600], fontSize: 20),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => const Forgot_Pass()),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  AuthController.instance.login(emailController.text.trim(),
                      passwordController.text.trim());
                },
                child: Container(
                    width: w * 0.5,
                    height: h * 0.08,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: AssetImage("img/g.jpg"), fit: BoxFit.cover)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          // backgroundColor: Colors.green[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              SizedBox(height: h * 0.2),
              RichText(
                  text: TextSpan(
                      text: "Don't Have an Account? ",
                      style: TextStyle(color: Colors.green[600], fontSize: 20),
                      children: [
                    TextSpan(
                      text: "Create",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => SignUpPage()),
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
