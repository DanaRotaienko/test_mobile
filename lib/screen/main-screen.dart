import 'package:flutter/material.dart';
import 'package:test_mobile/widgets/generator-widget.dart';
import 'package:test_mobile/widgets/list-widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          children: const [
            GeneratorWidget(),
          ],
        ),
      ),
    );
  }
}
