import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giki_eats/utils/config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: offwhite,
      child: Center(
        child: SpinKitCircle(
          color: teal,
          size: 50.0,
        ),
      ),
    );
  }
}