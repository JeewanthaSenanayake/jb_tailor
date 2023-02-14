import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class KidsPage extends StatefulWidget {
  const KidsPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<KidsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kids"),
      ),
    );
  }
}
