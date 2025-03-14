import 'package:flutter/material.dart';
import 'dart:async';

class Alarm extends StatelessWidget {
  const Alarm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Производится запуск! Процесс не обратим! Отданы команды ракетным комплексам!',
          style: TextStyle(fontSize: 24,
              color: Colors.green),
        ),
      ),
    );
  }
}
