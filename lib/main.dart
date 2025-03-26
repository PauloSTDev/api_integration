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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'API Integration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getAPI() async {
    final client = http.Client();
    try {
      // API call
      var response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      var decodedResponse = jsonDecode(response.body);
      print(decodedResponse);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  void postAPI(String title, String body) async {
    final client = http.Client();
    final request = {
      'title': title,
      'body': body,
      'userId': '111',
    };
    try {
      var response = await client.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: request);
      if (response.statusCode == 200) {
        print('Post created successfully');
        // return model.fromJson(json.decode(response.body));
      } else {
        print('Failed to create post');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  void updateAPI(String title, String body) async {
    final client = http.Client();
    final request = {
      'title': title,
      'body': body,
      'userId': '111',
    };
    try {
      var response = await client.put(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: request);
      if (response.statusCode == 200) {
        print('Post created successfully');
        // return model.fromJson(json.decode(response.body));
      } else {
        print('Failed to create post');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  void deleteAPI(int id) async {
    final client = http.Client();
    try {
      var response = await client.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
      if (response.statusCode == 200) {
        print('Post deleted successfully');
      } else {
        print('Failed to delete post');
      }
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'API Integration',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getAPI(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
