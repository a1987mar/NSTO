import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsto/driver.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:newsto/other/cardinfo.dart';
import 'package:newsto/other/info_rezerv.dart';
import 'package:newsto/other/styleClient.dart';
import 'package:newsto/rezerv.dart';
import 'package:badges/badges.dart' as badges;

final phoneNumber = TextEditingController();
final paramPush = TextEditingController();

var Data1C = [];
var data_Tab = <rezerv>[];
String tov = '';
String klient_S = "";
String tupTovar_S = "";

class rezerv {
  final klient;
  final sklad;
  final tovar;
  final tupTovar;
  final quantity;
  final meneger;
  rezerv(
      {required this.klient,
      required this.sklad,
      required this.tovar,
      required this.tupTovar,
      required this.quantity,
      required this.meneger});
}

int sumQuantity = 0;

sumq(int sQuantity) {
  int quantity = ++sQuantity;
  sumQuantity = quantity;
  return quantity;
}

class info_klient extends StatelessWidget {
  final String nameLog_1;

  const info_klient({super.key, required this.nameLog_1});

  @override
  Widget build(BuildContext context) {
    paramPush.text = "0";
    return Scaffold(body: StatefulBuilder(builder: (context, setState) {
      var dio = Dio();
      var dec_response;
      Future<void> infoClient() async {
        var url = "http://rds2.s-line.ua:8080/1cwebservice/hs/1CAPI/orderdata/";
        var response = await dio.get(
          url,
          queryParameters: {
            'param': 'info',
            'numberPhone': phoneNumber.text,
          },
        );
        if (response.statusCode == 200)
          dec_response = json.decode(response.data);
          if(dec_response['error']== false){
            Data1C.add(dec_response);
            setState(
              () {
                Data1C;
              },
            );
          }else if(dec_response['error'] = true){
            var message_error = dec_response['message'];
            showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text("Даних не знайдено! ",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            );
                          },
                        );
          }
      }

      Future zakaz() async {
        sumQuantity = 0;
        data_Tab.clear();
        var url = 'http://rds2.s-line.ua:8080/1cwebservice/hs/1CAPI/orderdata/';
        var response = await dio.get(url, queryParameters: {
          'param': 'rezerv',
          'numberPhone': phoneNumber.text,
        });
        var result = json.decode(response.data) as List<dynamic>;

        result.forEach((element) {
          klient_S = element['klient'];
          tupTovar_S = element['tupTovar'];
          int sum = int.parse(element['quantity']);
          sumQuantity = sumQuantity + sum;
          data_Tab.add(rezerv(
              klient: klient_S, //.replaceAll(' ', ''),
              sklad: element['sklad'],
              tovar: element['tovar'],
              tupTovar: tupTovar_S, //.replaceAll(' ', ''),
              quantity: element['quantity'],
              meneger: element['meneger']));
        });
        setState(
          () {
            data_Tab;
          },
        );
      }

      return Row(
        children: [
          Container(
            width: 225,
            color: const Color.fromARGB(215, 165, 165, 165),
            child: Column(children: [
              infoCard_2(nameLog: nameLog_1),
              const SizedBox(
                height: 50,
              ),
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                iconSize: 50,
              ),
              const SizedBox(
                height: 70,
              ),
              const Divider(
                height: 10,
                color: Colors.white24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white70,
                  ),
                  child: TextField(
                    onSubmitted: (value) {
                      
                      setState(() {
                        infoClient();
                        Data1C;
                      },);
                    },
                    controller: phoneNumber,
                    maxLength: 17,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: "Search",
                      labelStyle: TextStyle(fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 10,
                color: Colors.white24,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      Data1C.clear();
                      paramPush.text = '1';
                        infoClient();
                    },
                    child: const Text(
                      "Інформація по клієнту",
                      style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      data_Tab.clear();
                      paramPush.text = '2';
                      if (phoneNumber.text.length > 9) {
                        zakaz();
                      } else
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              title: Text(
                                "Невірно вказано номер!!!",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            );
                          },
                        );
                    },
                    child: const Text(
                      "Резерви по клієнту",
                      style: TextStyle(
                          color: Colors.white70,
                          fontStyle: FontStyle.italic,
                          fontSize: 16),
                    )),
              ),
              const Divider(
                height: 10,
                color: Colors.white24,
              ),
              SizedBox(
                height: 160,
              ),
              badges.Badge(
                badgeContent: Text(
                  sumQuantity.toString(),
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.white24),
                child: Icon(
                  Icons.local_grocery_store_outlined,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ]),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (paramPush.text == '1')
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                        height: 600,
                        width: 400,
                        child: ListView.builder(
                          itemCount: Data1C.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    textStyleInfo(
                                        textList: Data1C[index]["OrderManager"],
                                        article: "Менеджер"),
                                    textStyleInfo(
                                        textList: Data1C[index]["CustomerName"],
                                        article: "Клієнт"),
                                    textStyleInfo(
                                        textList: Data1C[index]["Phone"],
                                        article: "Номер телефону"),
                                    textStyleInfo(
                                        textList: Data1C[index]["Marka"],
                                        article: "Марка"),
                                    textStyleInfo(
                                        textList: Data1C[index]["Model"],
                                        article: "Модель"),
                                    SelectionArea(
                                      child: textStyleInfo(
                                          textList: Data1C[index]["VIN"],
                                          article: "VIN - номер"),
                                    ),
                                    textStyleInfo(
                                        textList: Data1C[index]["DateOrder"],
                                        article: "Останнє замовлення"),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                else if (paramPush.text == '2')
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          // height: 600,
                          width: 500,
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (var i_data in data_Tab)
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: infoRez_class(
                                          textList: i_data.tupTovar,
                                          article: i_data.tovar,
                                          quantity: i_data.quantity,
                                        ))
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }));
  }
}
