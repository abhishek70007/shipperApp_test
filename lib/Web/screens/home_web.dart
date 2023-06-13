// ignore_for_file: non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/responsive.dart';
import 'package:shipper_app/functions/shipperApis/isolatedShipperGetData.dart';
import '../../constants/screens.dart';
import '../../functions/shipperApis/runShipperApiPost.dart';
import '/constants/colors.dart';
import 'package:sizer/sizer.dart';
import '../logo.dart';

class HomeScreenWeb extends StatefulWidget {
  final int? index;
  final int? selectedIndex;
  const HomeScreenWeb({Key? key, this.index, this.selectedIndex})
      : super(key: key);
  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {
  int _selectedIndex = 0;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    runShipperApiPost(
        emailId: FirebaseAuth.instance.currentUser!.email.toString());
    if (widget.index != null) {
      setState(() {
        _index = widget.index!;
        _selectedIndex = widget.selectedIndex!;
      });
    }
    isolatedShipperGetData();
  }

  //TODO: This is the list for Navigation Rail List Destinations,This contains icons and it's labels
  List<NavigationRailDestination> destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.space_dashboard),
      label: Text("Dashboard"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.inventory_2_rounded),
      label: Text("My Loads"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.receipt_long),
      label: Text("Invoice"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.person_outline_outlined),
      label: Text("Account"),
    ),
    // const NavigationRailDestination(
    //   icon: Icon(Icons.supervised_user_circle_outlined),
    //   label: Text("Add User"),
    // ),
    const NavigationRailDestination(
      icon: Icon(Icons.support_agent_outlined),
      label: Text("Help and Support"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.phone_in_talk_outlined),
      label: Text("Contact Us"),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.logout_outlined),
      label: Text("Logout"),
    ),
  ];

  //TODO : This is the list for Bottom Navigation Bar
  List<BottomNavigationBarItem> bottom_destinations = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.space_dashboard), label: "Dashboard"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.inventory_2_rounded), label: "My Loads"),
    //const BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Invoice"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.person_outline_outlined), label: "Account"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle_outlined), label: "Add User"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO : Bottom Navigation Bar is only displayed when the screen size is in between sizes of mobile devices
      bottomNavigationBar: Responsive.isMobile(context)
          ? BottomNavigationBar(
              selectedItemColor: kLiveasyColor,
              unselectedItemColor: Colors.blueGrey,
              showUnselectedLabels: true,
              items: bottom_destinations,
              currentIndex: _selectedIndex,
              onTap: (updatedIndex) {
                setState(() {
                  if (updatedIndex == 2 || updatedIndex == 3) {
                    _index = updatedIndex + 1;
                  } else {
                    _index = updatedIndex;
                  }
                  _selectedIndex = updatedIndex;
                });
              },
            )
          : null,
      appBar: AppBar(
        backgroundColor: kLiveasyColor,
        title: TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreenWeb()));
          },
          child: SizedBox(
            width: Responsive.isMobile(context) ? 10.w : 9.w,
            child: Row(
              children: [
                const LiveasyLogoImage(),
                SizedBox(
                  width: 0.5.w,
                ),
                Text(
                  'Liveasy',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.isMobile(context) ? 4.5.sp : 5.sp,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _index = 5;
                });
              },
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: Colors.white,
              ),
              label: const Text(''),
            ),
          ),
          SizedBox(
            width: 48,
            height: 40,
            child: TextButton.icon(
              onPressed: () {
                setState(() {
                  _index = 7;
                });
              },
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
              label: const Text(''),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SizedBox(
              width: 48,
              height: 40,
              child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _index = screens.indexOf(accountVerificationStatusScreen);
                    });
                  },
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.white,
                  ),
                  label: const Text('')),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          //TODO : Similar to bottom navigation bar, Navigation rail is only displayed when it is not mobile screen
          Responsive.isMobile(context)
              ? const SizedBox(
                  width: 0.01,
                )
              : NavigationRail(
                  extended: Responsive.isDesktop(context) ? true : false,
                  selectedIconTheme: const IconThemeData(color: kLiveasyColor),
                  unselectedLabelTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.6.sp,
                      color: Colors.black),
                  selectedLabelTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 3.9.sp,
                      color: kLiveasyColor),
                  indicatorColor: const Color(0xFFC4C4C4),
                  labelType: Responsive.isDesktop(context)
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  destinations: destinations,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _selectedIndex = index;
                      _index = index;
                    });
                  },
                  elevation: 20,
                ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(
            child: Center(
              child: screens[_index],
            ),
          ),
        ],
      ),
    );
  }
}
