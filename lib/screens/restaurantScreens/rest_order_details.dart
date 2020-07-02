import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/models/order.dart';
import 'package:giki_eats/models/user.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/loader.dart';
import 'package:giki_eats/utils/variables.dart';
import 'package:intl/intl.dart';

class RestaurantOrderDetails extends StatefulWidget {
  final Order order;

  const RestaurantOrderDetails({Key key, this.order}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<RestaurantOrderDetails> {
  String titleText = 'Order Details';
  List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    DatabaseService _db = DatabaseService(
        userId: widget.order.userID,
        restaurantId: restaurant.id,
        menuItems: widget.order.menuIDs);
    User orderedBy;
    bool _isOrdered = widget.order.status == 'ORDERED' ? true : false;

    return Scaffold(
        appBar: AppBar(
          title: Text(titleText),
          centerTitle: true,
          backgroundColor: Colors.teal[300],
        ),
        body: StreamBuilder(
          stream: _db.menuItemDataForOrderDetails,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              menuItems = snapshot.data;
              return StreamBuilder(
                  stream: _db.userData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      orderedBy = snapshot.data;
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Customer Details',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontSize: 20,
                                    color: Colors.teal[400]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: new TextSpan(
                                      style: TextStyle(
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: teal)),
                                    new TextSpan(
                                        text: orderedBy.name,
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: new TextSpan(
                                      style: TextStyle(
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Email: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: teal)),
                                    new TextSpan(
                                        text: orderedBy.email,
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              RichText(
                                  text: new TextSpan(
                                      style: TextStyle(
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Phone: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: teal)),
                                    new TextSpan(
                                        text: orderedBy.phoneNumber,
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ])),
                              SizedBox(height: 10),
                              checkStatusAndDisplayDate(),
                              SizedBox(height: 10),
                              RichText(
                                  text: new TextSpan(
                                      style: TextStyle(
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        fontSize: 16,
                                      ),
                                      children: <TextSpan>[
                                    new TextSpan(
                                        text: 'Status: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: teal)),
                                    new TextSpan(
                                        text: widget.order.status,
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ])),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Container(
                                  height: 1.0,
                                  width: 110.0,
                                  color: Colors.blueGrey[300],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Items Detail',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decorationStyle: TextDecorationStyle.solid,
                                    fontSize: 20,
                                    color: Colors.teal[400]),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: menuItems.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return menuItemContainer(menuItems[index]);
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.0),
                                child: Container(
                                  height: 1.0,
                                  width: 110.0,
                                  color: Colors.blueGrey[300],
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RichText(
                                    text: new TextSpan(
                                        style: TextStyle(
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          fontSize: 16,
                                        ),
                                        children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Total: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: teal)),
                                      new TextSpan(
                                          text: 'Rs.' +
                                              widget.order.total.toString(),
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400)),
                                    ])),
                              )
                            ],
                          ));
                    } else {
                      return Loading();
                    }
                  });
            } else {
              return Loading();
            }
          },
        ),
        floatingActionButton: Visibility(
            visible: _isOrdered,
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  child: Icon(Icons.check),
                  onPressed: () {
                    _db.changeOrderStatus(widget.order.id, "ACCEPTED");
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 5),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      child: Icon(Icons.cancel),
                      onPressed: () {
                        _db.changeOrderStatus(widget.order.id, "REJECTED");
                        Navigator.pop(context);
                      },
                      heroTag: "Rejected",
                      backgroundColor: Colors.redAccent[200],
                    ),
                  ))
            ])));
  }

  Widget menuItemContainer(MenuItem menuItem) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      elevation: 4,
      shadowColor: grey,
      color: offwhite,
      child: InkWell(
        splashColor: teal.withOpacity(0.3),
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
                        backgroundImage: NetworkImage(menuItem.image),
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
                    SizedBox(
                      height: 5,
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
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Qty: ' +
                          widget.order.menuQty[menuItems.indexOf(menuItem)]
                              .toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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

  Widget checkStatusAndDisplayDate() {
    if (widget.order.status == 'ACCEPTED') {
      return RichText(
          text: new TextSpan(
              style: TextStyle(
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 16,
              ),
              children: <TextSpan>[
            new TextSpan(
                text: 'Accepted On: ',
                style: TextStyle(fontWeight: FontWeight.w400, color: teal)),
            new TextSpan(
                text: DateFormat.yMd().add_jm().format(widget.order.acceptedOn.toDate()),
                style: TextStyle(color: Colors.black54)),
          ]));
    } else {
      return RichText(
          text: new TextSpan(
              style: TextStyle(
                decorationStyle: TextDecorationStyle.solid,
                fontSize: 16,
              ),
              children: <TextSpan>[
            new TextSpan(
                text: 'Ordered On: ',
                style: TextStyle(fontWeight: FontWeight.w400, color: teal)),
            new TextSpan(
                text: DateFormat.yMd().add_jm().format(widget.order.orderedOn.toDate()),
                style: TextStyle(color: Colors.black54)),
          ]));
    }
  }
}
