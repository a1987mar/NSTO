import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:newsto/other/otherClass.dart';

final logName = TextEditingController();
final logPass = TextEditingController();

class login_s extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future logPas() async {
      var url = "http://rds2.s-line.ua:8080/1cwebservice/hs/1CAPI/orderdata/";
      var dio = Dio();
      var resul = await dio.get(url, queryParameters: {
        'param': 'login',
        'login_name': logName.text,
        'password': logPass.text,
      });
      if (resul.statusCode == 200) ;
      var result_ = resul.data;
      if (result_ == "true")
        Navigator.of(context)
            .pushNamed("/laptopPage", arguments: ArgumentLogin(logName.text));
      else
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Не вірно вказано заповнено облікові дані!!!",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            );
          },
        );
    }

    return Scaffold(
        body: Center(
      child: Container(
        height: 150,
        width: 200,
        child: Expanded(
          child: Column(children: [
            TextField(
              controller: logName,
              decoration: InputDecoration(
                label: Text("Login"),
              ),
            ),
            TextField(
              controller: logPass,
              obscureText: true,
              decoration: InputDecoration(
                label: Text(
                  "Password",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    logPas();
                  },
                  child: Text("Login"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red)),
            )
          ]),
        ),
      ),
    ));
  }
}
