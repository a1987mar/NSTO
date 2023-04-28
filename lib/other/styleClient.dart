import 'package:flutter/material.dart';

class textStyleInfo extends StatelessWidget {
  final String textList, article;
  const textStyleInfo({
    super.key,
    required this.textList,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.red),
      ),
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 211, 211, 211),
            border: Border(
                left: BorderSide(color: Colors.red, width: 5),
                right: BorderSide(color: Colors.red, width: 5))),
        height: 60,
        child: ListTile(
          title: Text(textList),
          tileColor: Colors.white12,
          subtitle: Text(
            article,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
