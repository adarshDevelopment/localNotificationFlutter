import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key, required this.payload});
  final String payload;

  @override
  Widget build(BuildContext context) {
    print('inside another page');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another page appbar'),
      ),
      body: Center(
        child: Column(
          children: [const Text('This is your payload'), Text(payload)],
        ),
      ),
    );
  }
}
