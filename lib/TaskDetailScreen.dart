import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:http/http.dart' as http;

class Taskdetailscreen extends StatelessWidget {
  
  final String taskId = Get.parameters['id'] ?? '';

  Future<Map<String, dynamic>> fetchTask() async {
    final response = await http.get(Uri.parse('https://api.example.com/tasks/$taskId'),
      headers: {
        'Authorization': 'Bearer'}
        );

if (response.statusCode == 200) {
      return 
      jsonDecode(response.body);
    } else {
      Get.snackbar('Error', 'Fallo al obtener las tareas',
    
       );
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Task Details')),
      body: FutureBuilder(future: fetchTask(),
       builder:   (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No task found'));
        } else {
          final task = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${task?['title']}', style: TextStyle(fontSize: 24)),
                SizedBox(height: 8),
                Text('Description: ${task?['description']}', style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }
        }
      
      )
    );
  }
}