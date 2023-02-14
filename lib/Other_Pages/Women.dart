import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WomenPage extends StatefulWidget {
  const WomenPage({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<WomenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Women"),
      ),
    );
  }
}
