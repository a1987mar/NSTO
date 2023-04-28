import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:newsto/driver.dart';
import 'package:newsto/other/cardinfo.dart';
import 'package:newsto/other/otherClass.dart';

List first_ = [1, 2, 3, 4, 5, 6, 7];

class laptopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nameLogo =
        ModalRoute.of(context)!.settings.arguments as ArgumentLogin;

    return Scaffold(
        body: Row(children: [
      Row(children: menu_laptop(context, nameLogo.log_name)),
    ]));
  }
}
