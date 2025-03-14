import 'package:flutter/material.dart';
import 'dart:html'; // 👈 Добавь это в начало файла

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String currentPath = "/"; // Текущий путь

  @override
  void initState() {
    super.initState();
    // Подписываемся на событие изменения истории браузера (нажатия кнопок "назад"/"вперёд")
    window.onPopState.listen((event) {
      _updatePath();
    });
    // При запуске обновляем путь
    _updatePath();
  }

  void _updatePath() {
    setState(() {
      currentPath = Uri.base.path; // Получаем текущий путь из URL
    });
  }

  void _navigateTo(String path) {
    setState(() {
      currentPath = path;
      // Меняем URL без перезагрузки страницы
      Uri newUri = Uri.base.replace(path: path);
      window.history.pushState(null, '', newUri.toString());
      //setState(() {
      //  currentPath = path;
      //});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (currentPath != "/") {
            setState(() {
              currentPath = "/";
              //window.history.pushState({}, '', "/");
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Пример SPA в Flutter Web")),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Текущий путь: $currentPath", style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _navigateTo("/button1"),
                child: Text("Кнопка 1"),
              ),
              ElevatedButton(
                onPressed: () => _navigateTo("/button2"),
                child: Text("Кнопка 2"),
              ),
              SizedBox(height: 30),
              if (currentPath == "/button1") Text("Ты нажал Кнопка 1!"),
              if (currentPath == "/button2") Text("Ты нажал Кнопка 2!"),
            ],
          ),
        ),
      ),
    );
  }
}