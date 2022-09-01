import 'package:flutter/material.dart';
import 'package:myride/authentication/login_screen.dart';
import 'package:myride/global/global.dart';
import 'package:myride/tabPages/earningsTab.dart';
import 'package:myride/tabPages/homeTab.dart';
import 'package:myride/tabPages/profileTab.dart';
import 'package:myride/tabPages/ratingsTab.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedindex = 0;

  onAuthenticated() async {
    if (await fAuth.currentUser != null) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomeTab()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
    }
  }

  onItemClicked(int index) {
    setState(() {
      selectedindex = index;
      tabController!.index = selectedindex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/app_logo.png', fit: BoxFit.contain, height: 75,)
          ],
        ),
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [HomeTab(), EarningsTab(), RatingsTab(), ProfileTab()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Ratings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
        unselectedItemColor: Colors.white54,
        selectedItemColor: Colors.yellow,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedindex,
        onTap: onItemClicked,
      ),
    );
  }
}
