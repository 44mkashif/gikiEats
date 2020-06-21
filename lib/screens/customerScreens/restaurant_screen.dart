import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/restaurant.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';

class RestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;
  const RestaurantScreen({Key key, this.restaurant}) : super(key: key);
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(restaurantId: widget.restaurant.id);
    return Scaffold(
      backgroundColor: white,
      body: StreamBuilder(
        stream: _db.menu,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            menu = snapshot.data;
            List<MenuItem> desi = [];
            List<MenuItem> chinese = [];
            List<MenuItem> fastFood = [];
            for (var menuItem in menu) {
              if (menuItem.category == "Desi") {
                desi.add(menuItem);
              } else if (menuItem.category == "Chinese") {
                chinese.add(menuItem);
              } else if (menuItem.category == "Fast Food") {
                fastFood.add(menuItem);
              }
            }
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 250,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                        widget.restaurant.image,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        widget.restaurant.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: white,
                          shadows: [
                            Shadow(
                              color: Colors.black,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          //Todo Restaurant info page
                          print('Restaurant info tapped...');
                        },
                      ),
                    ],
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: Delegate(
                      TabBar(
                        controller: _tabController,
                        labelColor: teal,
                        indicatorWeight: 3,
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelColor: grey,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          for (var category in categories)
                            Tab(
                              child: Container(
                                child: Align(
                                  child: Text(category['name']),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Container(
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    ListView.builder(
                      itemCount: desi.length,
                      itemBuilder: (context, index) {
                        return menuItemContainer(desi[index]);
                      },
                    ),
                    ListView.builder(
                      itemCount: fastFood.length,
                      itemBuilder: (context, index) {
                        return menuItemContainer(fastFood[index]);
                      },
                    ),
                    ListView.builder(
                      itemCount: chinese.length,
                      itemBuilder: (context, index) {
                        return menuItemContainer(chinese[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  Widget menuItemContainer(MenuItem menuItem) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      elevation: 4,
      shadowColor: grey,
      color: offwhite,
      child: InkWell(
        splashColor: teal.withOpacity(0.3),
        onTap: () {
          print('${menuItem.name} is tapped');
          Navigator.of(context)
              .pushNamed('/menuItemScreen', arguments: menuItem);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Hero(
                  tag: menuItem.name,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: teal,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundColor: white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                          'images/fast_food.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      menuItem.name,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: teal,
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   menuItem.description,
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 1,
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 15,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Rs. ${menuItem.price.toString()}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: brown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  Delegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: this.tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
