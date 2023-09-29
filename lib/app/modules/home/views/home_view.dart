import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:CardioTunes/app/modules/events/views/events_view.dart';
import 'package:CardioTunes/app/modules/newsfeed/views/newsfeed_view.dart';
import 'package:CardioTunes/app/modules/newsfeed/views/flights_page.dart';
import 'package:CardioTunes/app/modules/notifications/views/notifications_view.dart';
import 'package:CardioTunes/app/modules/profile/views/profile_view.dart';
import 'package:badges/badges.dart' as badges;
import 'package:CardioTunes/app/modules/timeline/views/timeline_view.dart';

import 'package:get/get.dart';

import '../controllers/bottom_navigation_bar_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const listRoute = [
      FlightsPage(),
      TimelineView(),
      EventsView(),
      NotificationsView(),
      ProfileView()
    ];

    final BottomNavigationBarController bottomNavigationController =
        Get.put(BottomNavigationBarController());
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      /*appBar: AppBar(
        title: Text(
          "Pa'Cuba",
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),*/
      //drawer: AppDrawer(),
      body: Obx(() {
        return listRoute[bottomNavigationController.currentIndex];
      }),
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          height: 50.0,
          index: bottomNavigationController.currentIndex,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueGrey.shade50,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) {
            bottomNavigationController.changeIndex(index);
          },
          letIndexChange: (index) => true,
          //backgroundColor: ColorConstants.BACKGROUND,
          items: <Widget>[
            Icon(
              Icons.newspaper,
              size: 25,
              color: bottomNavigationController.currentIndex == 0
                  ? Colors.blue
                  : Colors.grey,
            ),
            Icon(
              Icons.timeline,
              size: 25,
              color: bottomNavigationController.currentIndex == 1
                  ? Colors.blue
                  : Colors.grey,
            ),
            Icon(
              Icons.event_available_outlined,
              size: 25,
              color: bottomNavigationController.currentIndex == 2
                  ? Colors.blue
                  : Colors.grey,
            ),
            badges.Badge(
              badgeContent: const Text('5'),
              badgeStyle: const badges.BadgeStyle(
                badgeColor: Colors.redAccent,
                elevation: 5,
              ),
              child: Icon(
                Icons.notifications,
                size: 25,
                color: bottomNavigationController.currentIndex == 3
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            Icon(
              Icons.person,
              size: 25,
              color: bottomNavigationController.currentIndex == 4
                  ? Colors.blue
                  : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
