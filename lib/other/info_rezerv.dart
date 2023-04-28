import 'package:flutter/material.dart';

class infoRez_class extends StatelessWidget {
  final String textList, article, quantity;
  const infoRez_class(
      {super.key,
      required this.textList,
      required this.article,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.red),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 250,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 211, 211),
              border: Border(
                  left: BorderSide(color: Colors.red, width: 5),
                  right: BorderSide(color: Colors.red, width: 5))),
          height: 60,
          child: ListTile(
              title: Text(
                textList,
                style: TextStyle(fontSize: 16),
              ),
              tileColor: Colors.white12,
              subtitle: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            article,
                            style: const TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Text(
                            "к-ть.  $quantity ",
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
