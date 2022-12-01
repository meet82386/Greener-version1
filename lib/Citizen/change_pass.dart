import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'hamburger.dart';
import 'profile_info.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}




class _ChangePassState extends State<ChangePass> {
  bool login = false;

  var email = TextEditingController();
  var password = TextEditingController();

  var displayName = TextEditingController();

  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          login = true;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[200],
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Center(
        child: login
          ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Home Page'),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(FirebaseAuth.instance.currentUser!.email!),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    FirebaseAuth.instance.currentUser!.displayName ??
                    'No Name'),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                  controller: displayName,
                  decoration: InputDecoration(
                  hintText: FirebaseAuth
                      .instance.currentUser!.displayName ??
                  'Name'),
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                  obscureText: true,
                  controller: currentPass,
                  decoration:
                  const InputDecoration(hintText: 'Current Password'),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                obscureText: true,
                controller: newPass,
                decoration:
                const InputDecoration(hintText: 'New Password'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                  onPressed: () async {
                    if (displayName.value.text.isNotEmpty) {
                    try {
                    FirebaseAuth.instance.currentUser!
                        .updateDisplayName(displayName.text);
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePass()));
                    } catch (e) {
                    if (kDebugMode) {
                    print(e);
                    }
                    }
                    }
                    if (currentPass.value.text.isNotEmpty &&
                        newPass.value.text.isNotEmpty) {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                        email: FirebaseAuth
                            .instance.currentUser!.email!,
                        password: currentPass.text);
                        await FirebaseAuth.instance.currentUser!
                            .updatePassword(newPass.text);
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                          content: Text('Update Success')));
                    }
                  },
                  child: const Text('UPDATE')),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                  onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  setState(() {});
                  login = false;
                  },
                  child: const Text('Sign out')),
              )
          ],
          ),
          )
        : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
              children: [
              const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Login'),
              ),
                TextField(
                controller: email,
                decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(labelText: 'Password'),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                onPressed: () async {
                try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                email: email.text,
                password: password.text);
                final user = userCredential.user;
                if (kDebugMode) {
                print(user?.uid);
                }
                setState(() {});
                login = true;
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())));
                }
                },
                    child: const Text('Login')),
    )
    ],
    ),
    ),
        ),
    );
  }
}
