import 'package:euro_collector/pages/home.dart';
import 'package:euro_collector/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(
    const EuroCollector(),
  );
}

class EuroCollector extends StatelessWidget {
  const EuroCollector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Euro Collector',
      themeMode: ThemeMode.dark,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 4,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 2,
      ),
      home: HomePage(),
      // home: LoadingPage(),
    );
  }
}
