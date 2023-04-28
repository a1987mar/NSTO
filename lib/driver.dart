import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsto/info_klient.dart';
import 'package:newsto/laptopPage.dart';
import 'package:newsto/other/cardinfo.dart';

final numb_phone = TextEditingController();

menu_laptop(BuildContext context, nameLog) => <Widget>[
      Container(
        width: 225,
        child: Drawer(
            backgroundColor: Color.fromARGB(255, 211, 211, 211),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(children: [
                  infoCard_2(nameLog: nameLog),
                  SizedBox(
                    height: 100,
                  ),
                  //Icon(Icons.home, size: 50, color: Colors.white),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 245, 0, 0),
                    ),
                    iconSize: 50,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => info_klient(nameLog_1: nameLog),
                        ));
                      },
                      child: Text(
                        "Інформація по клієнту",
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      )),
                ]);
              },
            )),
      )
    ];
