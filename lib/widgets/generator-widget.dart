import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_mobile/connections/database-connection.dart';
import 'package:test_mobile/models/numberDto.dart';

import 'list-widget.dart';

class GeneratorWidget extends StatefulWidget {
  const GeneratorWidget({Key? key}) : super(key: key);

  @override
  State<GeneratorWidget> createState() => _GeneratorWidgetState();
}

class _GeneratorWidgetState extends State<GeneratorWidget> {
  String num = "";

  void fetchNumber() async {
    final response = await http
        .get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));
    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.body);
      setState(() {
        num = responseMap[0]["random"].toString();
        DatabaseHelper.add(NumberDto(number: num));
      });
    } else {
      throw Exception('Failed to load number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () {
              fetchNumber();
              setState(() {

              });
            },
            child: const Text("Get New Random Number",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20),)
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: 
            Text(num)
          ,
        ),
        ListWidget()
      ],
    );
  }
}