import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'bottomnav.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 2),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = false);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Bottom_Nav()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Verify Email'),
          ),
          body: Container(
            color: Colors.green[200],
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ('A verification mail has been sent to your adress. check SPAM folder if you did not find it in inbox'),
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      color: Colors.green,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size.fromHeight(50),
                        ),
                        icon: Icon(
                          Icons.email,
                          size: 32,
                        ),
                        label: Text(
                          'Resend Email',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                          if (canResendEmail) {
                            sendVerificationEmail();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text(
                        'Cancel',
                        style:
                            TextStyle(fontSize: 24, color: Colors.green[700]),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    )
                  ],
                )),
          ));
}
