import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class infoCard_2 extends StatelessWidget {
  final String nameLog;
  const infoCard_2({
    super.key,
    required this.nameLog,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(CupertinoIcons.person),
        backgroundColor: Colors.white24,
      ),
      title: Text(
        nameLog,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
