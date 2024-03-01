import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Map<String, dynamic>> _items = [];

  Future<void> _fetchItems() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/items'));
    if (response.statusCode == 200) {
      setState(() {
        _items = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchItems();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index){
          final user = _items[index];
          return ListTile(
            title: Text(user['name'], style: TextStyle(color: Colors.black),),
            subtitle: Text(user['description']),
          );
        }
      ),
    );
  }
}