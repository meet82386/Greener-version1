import 'fetch.dart';
import 'AMC_Completed.dart';
import 'AMC_deleted.dart';
import 'AMC_org_slot.dart';
import 'AMC_profile.dart';
import 'amc_home.dart';
import 'package:flutter/material.dart';
import 'package:greener_v1/AMC%20Team%20Home/Team_List.dart';

class AMC_Nav extends StatefulWidget {
  const AMC_Nav({Key? key}) : super(key: key);

  @override
  State<AMC_Nav> createState() => _AMC_NavState();
}

class _AMC_NavState extends State<AMC_Nav> with TickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  List<Widget> myChilders = [
    AMC_Home(),
    AMC_Completed(),
    AMC_Deleted(),
    AMC_Slot(),
    Team_List(),
    AMC_Profile()
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
                icon: Icon(Icons.home),
                child: Text(
                  'Home',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.done_all),
                child: Text(
                  'Accept',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.delete),
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.landscape),
                child: Text(
                  'Slot',
                  style: TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Tab(
                iconMargin: EdgeInsets.only(bottom: 4),
                icon: Icon(Icons.group),
                child: Text(
                  'Team',
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
