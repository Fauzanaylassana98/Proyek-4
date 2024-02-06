// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = '';

  Future<void> fetchMessage() async {
    try {
      final http.Response response =
      //For Web Browser
      await http.get(Uri.parse('http://localhost:8000/api/hello'));

      //For VM
      //await http.get(Uri.parse('http://10.0.2.2:8000/api/hello'));

      //For Android
      //await http.get(Uri.parse('http://(IP):8000/api/hello'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          message = data['message'];
        });
      } else {
        // This part is for handling non-200 HTTP responses.
        setState(() {
          message = 'Failed to fetch message';
        });
      }
    } catch (e) {
      // This catch block handles exceptions thrown due to network issues,
      // such as when the address is not found or the server is unreachable.
      setState(() {
        message = 'Failed to fetch message';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Laravel Hello World'),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}