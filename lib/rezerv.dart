import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void push_zakaz() {
  zakazRezerv();
}

class zakazRezerv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dio = Dio();
    var data_Tab = [];

    Future zakaz() async {
      var url = 'http://127.0.0.1/InfoBase/hs/Servicekey/person/';
      var response = await dio.get(url);
      var result = json.decode(response.data);
      data_Tab.add(result);
    }

    return StatefulBuilder(
      builder: (context, setState) {
        setState(
          () {
            zakaz();
            data_Tab;
          },
        );
        return Column(
          children: [for (var i in data_Tab) Text("$i")],
        );
      },
    );
  }
}
