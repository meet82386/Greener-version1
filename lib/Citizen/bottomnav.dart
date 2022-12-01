import 'package:flutter/material.dart';
import 'package:greener_v1/Citizen/free_slot.dart';
import 'SWT.dart';
import 'abouttree.dart';
import 'homepage.dart';
import 'plant.dart';
import 'profile_page.dart';
// import 'package:profilepage.dart';
import 'scanner.dart';
import 'image_data.dart';

class Bottom_Nav extends StatefulWidget {
  const Bottom_Nav({Key? key}) : super(key: key);

  @override
  State<Bottom_Nav> createState() => _Bottom_NavState();
}

class _Bottom_NavState extends State<Bottom_Nav> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  List<Widget> myChilders = [
    HomePage(),
    Plantation(),
    SWT(),
    Scanner(),
    ProfilePage(),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChilders,
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: BottomAppBar(
          child: TabBar(
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            indicator: const UnderlineTabIndicator(
                insets: EdgeInsets.only(bottom: kBottomNavigationBarHeight),
                borderSide: BorderSide(color: Colors.green, width: 2)),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabs: [
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                // icon: selectedIndex == 0
                //     ? Icon(Icons.home)
                //     : Icon(Icons.home_mini),
                icon: Icon(Icons.home),
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.park),
                child: Text(
                  'Tree',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.book),
                child: Text(
                  'Growth',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.qr_code_scanner),
                child: Text(
                  'Scanner',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.person),
                child: Text(
                  'Profile',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
