//import 'dart:html';
import 'package:shared_preferences/shared_preferences.dart';

import '../Citizen/free_slot.dart';
import '../Citizen/verify_email_page.dart';
import 'database.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../AMC Team Home/amc_nav.dart';
import '../Citizen/bottomnav.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Welcome_Page.dart';
import '../Citizen/notification.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  void toast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => Welcome_Page());
    }
    // } else {
    //   //Get.offAll(() => WelcomePage());
    //   // -> MEET: Because of welcome page is incomplete i redirected to LoginPage()
    //   // Get.offAll(() => LoginPage());
    //   DatabaseMethods().getUserFromDBUser()
    //
    // }
  }

  late DatabaseReference dbRef;

  CollectionReference users =
      FirebaseFirestore.instance.collection('AskToPlant');

  Future<void> slotBook(
      String name,
      String area,
      String email,
      String mno,
      String date,
      String timeSlot,
      String plan,
      int? free,
      int? subscription,
      String selectedPlan) async {
    late DatabaseReference dbRef =
        FirebaseDatabase.instance.ref().child('AskToPlant');

    // CollectionReference users =
    // FirebaseFirestore.instance.collection('AskToPlant');
    Map<String, String> ReqForSlot = {
      'Name': name,
      'PlaceName': area,
      'email': email,
      'mobile_number': mno,
      'date': date,
      'time_slot': timeSlot,
      'plan': plan,
    };
    if (ReqForSlot['Name'] != '') {
      if (ReqForSlot['mobile_number']?.length == 10) {
        if (ReqForSlot['date'] != '') {
          await dbRef.push().set(ReqForSlot);
          toast('Slot Booked successfully.');
          Get.offAll(() => Bottom_Nav());
          if (plan == "Free") {
            return FirebaseFirestore.instance
                .collection("counter")
                .doc('Zc46be3BLL4nniTDk72R')
                .update({'free': free! + 1});
          }
          if (plan == 'Subscription') {
            return FirebaseFirestore.instance
                .collection("counter")
                .doc('Zc46be3BLL4nniTDk72R')
                .update({'paid': subscription! + 1});
          }
        } else {
          toast('Invalid date.');
        }
      } else {
        toast("Invalid mobile number.");
      }
    } else {
      toast("Name can not be null.");
    }
  }

  int? total;
  int? tree_per_user = 0;
  getPlan() async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    final vari = await FirebaseFirestore.instance
        .collection('counter')
        .doc('Zc46be3BLL4nniTDk72R')
        .get();
    final vari2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    total = vari.data()!['total_planted'];
    tree_per_user = vari2.data()!['tree'];
    return 1;
  }

  Future<void> TreeAdded(String? uid) async {
    bool a = await getPlan();
    var it = FirebaseFirestore.instance
        .collection("counter")
        .doc('Zc46be3BLL4nniTDk72R')
        .update({'total_planted': total! + 1});
    var it2 = FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.uid)
        .set({'tree': tree_per_user! + 1});
  }

  Future<void> registerCitizen(String email, password, String fname,
      String lname, String mob, String dob) async {
    try {
      var number = int.parse(mob);
      final numericRegex = RegExp(r'[0-9]');
      if (fname != '') {
        if (lname != '') {
          if (mob.length == 10) {
            if (EmailValidator.validate(email)) {
              if ((password.length >= 8 && password.length <= 16) &&
                  numericRegex.hasMatch(password)) {
                UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                Map<String, dynamic> userInfoMap = {
                  "email": email,
                  "fname": fname,
                  "lname": lname,
                  "mobile": number,
                  "birthDate": dob,
                  "role": "citizen",
                  "tree": 0,
                  "profile-image":
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
                };
                DatabaseMethods()
                    .addUserInfoToDBUser(auth.currentUser!.uid, userInfoMap);
                DatabaseMethods().initTreeConfig(auth.currentUser!.uid, email);
                // for (int i = 0; i < 100; i++) {
                //   DateTime diffDuration = DateTime(
                //       birthDate.year + i, birthDate.month, birthDate.year);
                //   notification_controller.getInstance.showNotification(
                //       i,
                //       "Happy Birthday to You!",
                //       "Plant a tree on this special ocassion",
                //       diffDuration);
                // }
                Get.offAll(() => VerifyEmailPage());
              } else {
                toast("Invalid Password please try again");
              }
            } else {
              toast("Invalid Email please try again");
            }
          } else {
            toast("Invalid Mobile number please try again");
          }
        } else {
          toast("Last name can not be null.");
        }
      } else {
        toast("First name can not be null.");
      }
    } catch (e) {
      Get.snackbar("About User", "User massage",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  Future<void> registerTeamMember(String nameOfTeam, String email, password,
      String fname, String lname, String mob, String teamID) async {
    try {
      var number = int.parse(mob);
      final numericRegex = RegExp(r'[0-9]');
      if (fname != '') {
        if (lname != '') {
          if ((password.length >= 8 && password.length <= 16) &&
              numericRegex.hasMatch(password)) {
            if (mob.length == 10) {
              if (EmailValidator.validate(email)) {
                UserCredential usserCredential =
                    await auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                Map<String, dynamic> userInfoMap = {
                  "team_name": nameOfTeam,
                  "email": email,
                  "fname": fname,
                  "lname": lname,
                  "mobile": number,
                  "TeamId": int.parse(teamID),
                  "role": "teamMember",
                  "profile-image":
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png',
                };
                DatabaseMethods()
                    .addUserInfoToDBUser(auth.currentUser!.uid, userInfoMap);
                FirebaseDatabase.instance
                    .ref()
                    .child('Team Members')
                    .push()
                    .set(userInfoMap);
                Get.offAll(() => AMC_Nav());
              } else {
                toast("Invalid Email try again.");
              }
            } else {
              toast("Invalid Mobile number try again.");
            }
          } else {
            toast("Invalid Password try again.");
          }
        } else {
          toast("Last name can not be null.");
        }
      } else {
        toast("First name can not be null.");
      }
    } catch (e) {
      Get.snackbar("About User", "User massage",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Account creation failed",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  // Future<void> registerORG(String email, password, String name, String headName,
  //     String mob, String yearOfEstablishment, String pincode) async {
  //   try {
  //     var number = int.parse(mob);
  //     final numericRegex = RegExp(r'[0-9]');
  //     if (name != '') {
  //       if (headName != '') {
  //         if (pincode.length == 6) {
  //           if ((password.length >= 8 && password.length <= 16) &&
  //               numericRegex.hasMatch(password)) {
  //             if (mob.length == 10) {
  //               if (EmailValidator.validate(email)) {
  //                 UserCredential userCredential =
  //                     await auth.createUserWithEmailAndPassword(
  //                         email: email, password: password);
  //                 var pin = int.parse(pincode);
  //                 Map<String, dynamic> userInfoMap = {
  //                   "email": email,
  //                   "nameOfOrg": name,
  //                   "headName": headName,
  //                   "mobile": number,
  //                   "yearOfEstablishment": int.parse(yearOfEstablishment),
  //                   "pincode": pin,
  //                   "role": "ORG"
  //                 };
  //                 DatabaseMethods()
  //                     .addUserInfoToDBUser(auth.currentUser!.uid, userInfoMap);
  //                 Get.offAll(() => Org_Bottom_Nav());
  //               } else {
  //                 toast("Invalid E mail try again.");
  //               }
  //             } else {
  //               toast("Invalid Mobile number try again.");
  //             }
  //           } else {
  //             toast("Invalid Password try again.");
  //           }
  //         } else {
  //           toast("Invalid Pincode try again.");
  //         }
  //       } else {
  //         toast("Name of head can not be empty.");
  //       }
  //     } else {
  //       toast("Name of head can not be empty.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("About User", "User massage",
  //         backgroundColor: Colors.redAccent,
  //         snackPosition: SnackPosition.BOTTOM,
  //         titleText: const Text(
  //           "Account creation failed",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         messageText: Text(
  //           e.toString(),
  //           style: const TextStyle(color: Colors.white),
  //         ));
  //   }
  // }
  //
  // Future<void> registerSponsor(
  //     String email,
  //     password,
  //     String name,
  //     String headName,
  //     String mob,
  //     String pincode,
  //     String type,
  //     String gst) async {
  //   try {
  //     var number = int.parse(mob);
  //     final numericRegex = RegExp(r'[0-9]');
  //     if (name != '') {
  //       if (headName != '') {
  //         if (pincode.length == 6) {
  //           if (gst.length == 15) {
  //             if ((password.length >= 8 && password.length <= 16) &&
  //                 numericRegex.hasMatch(password)) {
  //               if (mob.length == 10) {
  //                 if (EmailValidator.validate(email)) {
  //                   UserCredential userCredential =
  //                       await auth.createUserWithEmailAndPassword(
  //                           email: email, password: password);
  //                   var pin = int.parse(pincode);
  //                   Map<String, dynamic> userInfoMap = {
  //                     "email": email,
  //                     "nameOfSponser": name,
  //                     "headName": headName,
  //                     "mobile": number,
  //                     "pincode": pin,
  //                     "typeOfProducts": type,
  //                     "GST": gst,
  //                     "role": "sponsor"
  //                   };
  //                   DatabaseMethods().addUserInfoToDBUser(
  //                       auth.currentUser!.uid, userInfoMap);
  //                   Get.offAll(() => Sponsor_Home());
  //                 } else {
  //                   toast("Invalid Email try again.");
  //                 }
  //               } else {
  //                 toast("Invalid Mobile number try again.");
  //               }
  //             } else {
  //               toast("Invalid Password try again.");
  //             }
  //           } else {
  //             toast("Invalid GST number try again.");
  //           }
  //         } else {
  //           toast("Invalid PIN code try again.");
  //         }
  //       } else {
  //         toast("Name of head can not be empty.");
  //       }
  //     } else {
  //       toast("Name of organization can not be empty.");
  //     }
  //   } catch (e) {
  //     Get.snackbar("About User", "User massage",
  //         backgroundColor: Colors.redAccent,
  //         snackPosition: SnackPosition.BOTTOM,
  //         titleText: const Text(
  //           "Account creation failed",
  //           style: TextStyle(color: Colors.white),
  //         ),
  //         messageText: Text(
  //           e.toString(),
  //           style: const TextStyle(color: Colors.white),
  //         ));
  //   }
  // }

  void login(String email, password) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', email);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      DatabaseMethods().getUserFromDBUser(email);
    } catch (e) {
      Get.snackbar("About Login", "Login massage",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            "Login failed. Check your Credentials.",
            style: TextStyle(color: Colors.white),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Colors.white),
          ));
    }
  }

  void logout() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    await auth.signOut();
  }
}
