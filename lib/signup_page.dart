import 'package:flutter/material.dart';

import 'Citizen/citizen.dart';
import 'amc_team_signup.dart';

// import 'amc_team_signup.dart';
// import 'Citizen/citizen.dart';
// import 'organization_signup.dart';
// import 'Sponsor/sponsor.dart';

class SignUpPage extends StatelessWidget {
  // const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: Text('Greener'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 50,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: w * 0.78,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Choose the Entity :",
                        style: TextStyle(
                          // backgroundColor: Colors.green[600],
                          fontSize: 25,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Citizen_Signup()));
                  },
                  child: Container(
                      width: w * 0.8,
                      height: h * 0.08,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("img/g.jpg"),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: Text(
                          "Citizen",
                          style: TextStyle(
                            // backgroundColor: Colors.green[600],
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Team_Signup()));
                  },
                  child: Container(
                      width: w * 0.8,
                      height: h * 0.08,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: AssetImage("img/g.jpg"),
                              fit: BoxFit.cover)),
                      child: Center(
                        child: Text(
                          "AMC Team",
                          style: TextStyle(
                            // backgroundColor: Colors.green[600],
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const Org_Signup()));
                //   },
                //   child: Row(
                //     children: [
                //       Container(
                //           width: w * 0.8,
                //           height: h * 0.08,
                //           margin: const EdgeInsets.only(left: 20, right: 20),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               image: DecorationImage(
                //                   image: AssetImage("img/g.jpg"),
                //                   fit: BoxFit.cover)),
                //           child: Center(
                //             child: Text(
                //               "Organization",
                //               style: TextStyle(
                //                 // backgroundColor: Colors.green[600],
                //                 fontSize: 20,
                //                 // fontWeight: FontWeight.bold,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           )),
                //     ],
                //   ),
                // ),
                // // SizedBox(
                // //   height: 10,
                // // ),
                // SizedBox(
                //   height: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => Sponsor_Signup()));
                //   },
                //   child: Row(
                //     children: [
                //       Container(
                //           width: w * 0.8,
                //           height: h * 0.08,
                //           margin: const EdgeInsets.only(left: 20, right: 20),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(20),
                //               image: DecorationImage(
                //                   image: AssetImage("img/g.jpg"),
                //                   fit: BoxFit.cover)),
                //           child: Center(
                //             child: Text(
                //               "Sponsor",
                //               style: TextStyle(
                //                 // backgroundColor: Colors.green[600],
                //                 fontSize: 20,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           )),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
