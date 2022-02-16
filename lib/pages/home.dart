import 'package:euro_collector/collection/ui/handle_view.dart';
import 'package:euro_collector/collection/ui/line_slots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C o l l e c t i o n"),
        backgroundColor: NeumorphicTheme.baseColor(context),
        actions: const [],
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        child: const Icon(Icons.add, size: 30),
        onPressed: () {},
      ),
      backgroundColor: NeumorphicTheme.baseColor(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            HandleView(),
          ],
        ),
      ),
    );
  }
}
