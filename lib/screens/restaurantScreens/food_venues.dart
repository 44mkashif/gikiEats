import 'package:flutter/material.dart';
import 'package:giki_eats/utils/config.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: teal,
          title: Text(
            'Giki Eats',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          bottom: TabBar(
            indicatorColor: tealWhite,
            tabs: <Widget>[
              Tab(
                child:Text(
                  'Restaurants',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Tab(
                child:Text(
                  'Shops',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'GIKI Eats',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: offwhite,
                  ),
                ),
                decoration: BoxDecoration(
                  color: teal,
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: teal,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: teal,
                  ),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 105, 92, 1),
                Color.fromRGBO(0, 135, 121, 1),
                Color.fromRGBO(81, 184, 160, 1),
                Color.fromRGBO(81, 184, 160, 1),
                Color.fromRGBO(81, 184, 160, 1),
              ],
            ),
          ),
          child: TabBarView(
            children: <Widget>[

              // Restaurants TabView
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('Ayaan tapped'),
                    child: ClipRRect(
                      child:Image.asset(
                        "images/ayan.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Ayaan Restaurant',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('Raju Tapped'),
                    child:ClipRRect(
                      child:Image.asset(
                        "images/raju.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Raju Hotel',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('HNS Tapped'),
                    child: ClipRRect(
                      child:Image.asset(
                        "images/hotnspicy.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Hot And Spicy',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              //SHops TabView
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('Ayaan tapped'),
                    child: ClipRRect(
                      child:Image.asset(
                        "images/ayan.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Haji Shop',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('Raju Tapped'),
                    child:ClipRRect(
                      child:Image.asset(
                        "images/raju.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Asraar Bucks',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => debugPrint('HNS Tapped'),
                    child: ClipRRect(
                      child:Image.asset(
                        "images/hotnspicy.jpg",
                        width: 220,
                        height: 110,
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Daily Soda',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );


  }
}
