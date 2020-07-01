import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giki_eats/models/menu_item.dart';
import 'package:giki_eats/services/database.dart';
import 'package:giki_eats/utils/colors.dart';
import 'package:giki_eats/utils/variables.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CreateMenuItem extends StatefulWidget {
  @override
  _CreateMenuItemState createState() => _CreateMenuItemState();
}

class _CreateMenuItemState extends State<CreateMenuItem> {

  DatabaseService _db = new DatabaseService(restaurantId: restaurant.id);
  MenuItem menuItem = new MenuItem('', 0, '', 0, '', '', '');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _category, _description;
  int _price;

  final picker = ImagePicker();
  File _image;

  List<String> _locations = ['Desi', 'Fast Food', 'Chinese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Create New Menu Item',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: teal,
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 105, 92, 1),
                    Color.fromRGBO(0, 135, 121, 1),
                    Color.fromRGBO(81, 184, 160, 1),
                    Color.fromRGBO(178, 224, 187, 1),
                    Color.fromRGBO(253, 244, 179, 1),
                  ],
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,4,0,0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Food Name',
                                  prefixIcon: Icon(Icons.fastfood),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                                onSaved: (input) => _name = input,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,4,0,0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Price',
                                  prefixIcon: Icon(Icons.attach_money),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (input) => _price = int.parse(input),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,4,0,0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                  prefixIcon: Icon(Icons.text_fields),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                                onSaved: (input) => _description = input,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                hint: Text('Choose Category'),
                                underline: SizedBox(), // remove underline border
                                isExpanded: true, // put arrow icons to right most
                                value: _category,
                                onChanged: (newInput) {
                                  setState(() {
                                    _category = newInput;
                                    print('loc: $_category');
                                  });
                                },
                                items: _locations.map( (loc) {
                                  return DropdownMenuItem(
                                    child: Text(loc),
                                    value: loc,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,8,0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.camera),
                                    iconSize: 25,
                                    onPressed: () {
                                      getImage();
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      (_image!=null) ? '${basename(_image.path)}' : 'Upload Image',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 60,
                              child: RaisedButton(
                                elevation: 7.0,
                                color: teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  createMenuItem();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: offwhite,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }

  Future getImage() async {

    // get image from gallery and assign it to img
    final img = await picker.getImage(source: ImageSource.gallery);

    // updating state
    setState(() {
      _image = File(img.path);
    });
  }
  void createMenuItem () async {

    _formKey.currentState.save();
    if(_formKey.currentState.validate())
    {
      menuItem.name = _name;
      menuItem.active = 0;
      menuItem.price = _price;
      menuItem.category = _category;
      menuItem.description = _description;
      menuItem.image = await _db.uploadImage(basename(_image.path), _image);
      _db.createMenu(menuItem);
    }

  }


}