import 'package:flutter/material.dart';

import '../widget/main_btn.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: const SafeArea(child: MainButtonWidget()),
    );
  }
}
