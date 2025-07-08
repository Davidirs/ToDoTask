import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class Dashboardscreen extends StatelessWidget {
  const Dashboardscreen({super.key});

Future<List<dynamic>> fetchTasks() async {
    final response = await http.get(Uri.parse('https://api.example.com/tasks'),
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
    return Scaffold(
      appBar: AppBar(title: Text('Tablero')),
        body: FutureBuilder<dynamic>(
        future: fetchTasks(), 
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay tarea disponible'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                return ListTile(
                  title: Text(task['title']),
                  onTap: () {
                    Get.toNamed(
                      '/task/${task['id']}',
                      arguments: task,
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the button
        },
        child: Icon(Icons.add),
      ),
    );
  }
}