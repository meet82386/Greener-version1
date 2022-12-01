import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:greener_v1/Citizen/bottomnav.dart';
import 'package:greener_v1/Citizen/citizen.dart';
import '../Citizen/bottomnav.dart';
import '../amc_team_signup.dart';
import 'package:greener_v1/login_page.dart';
import 'package:get/get.dart';

import '../AMC Team Home/amc_nav.dart';

class DatabaseMethods {
  // Add user data to database
  Future addUserInfoToDBUser(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  /*Future<DocumentSnapshot>*/ void getUserFromDBUser(String mail) async {
    //return FirebaseFirestore.instance.collection('users').doc(userId).get();
    String rol = '';
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: mail)
        .get();

    for (var doc in querySnapshot.docs) {
      // Getting data directly
      rol = doc.get('role');
    }

    if (rol == 'citizen') {
      Get.offAll(() => Bottom_Nav());
    }
    if (rol == 'teamMember' || rol == 'teamMember(Leader)') {
      Get.offAll(() => AMC_Nav());
    }
  }
}
