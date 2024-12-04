import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:todos/%20models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();
  bool isEdit = false;
  Future<List<TodoModel>> todoList = getTodoList();

  static String baseUrl = 'https://iskkiri.com/api/todos';
  static final dio = Dio();

  static postTodo(String text) async {
    final response = await dio.post('$baseUrl', data: {'title': text});
    return response.data;
  }

  static Future<List<TodoModel>> getTodoList() async {
    List<TodoModel> todoInstances = [];
    final response = await dio.get('$baseUrl');
    if (response.statusCode == 200) {
      for (var item in response.data!) {
        todoInstances.add(TodoModel.fromJson(item));
      }
      return todoInstances;
    }
    throw Error();
  }

  @override
  void initState() {
    super.initState();
    todoList = getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'TODO LIST',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          elevation: 3,
          shadowColor: Colors.black54,
          foregroundColor: Colors.blueGrey[800],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Enter your task',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2, color: Colors.blueGrey),
                        ),
                      ),
                      controller: _todoController,
                    ),
                  ),
                  const SizedBox(width: 18),
                  ElevatedButton(
                    onPressed: () async {
                      await postTodo(_todoController.text);
                      setState(() {
                        todoList = getTodoList();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                    ),
                    child: const Text(
                      'ADD',
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text('TODO LIST'),
              const SizedBox(height: 16),
              FutureBuilder<List<TodoModel>>(
                  future: todoList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    }
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Text(snapshot.data![index].title);
                        });
                  }),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          readOnly: !isEdit,
                          decoration: InputDecoration(
                            hintText: _todoController.text,
                            border: isEdit ? const OutlineInputBorder() : InputBorder.none,
                            focusedBorder: isEdit ? const OutlineInputBorder() : InputBorder.none,
                          )),
                    ),
                    const SizedBox(width: 8),
                    buttons(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Row buttons() {
    if (!isEdit) {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = !isEdit;
              });
            },
            icon: Icon(
              Icons.edit,
              color: isEdit ? Colors.blueGrey.shade700 : Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {
              print('delete');
            },
            icon: const Icon(Icons.delete, color: Colors.redAccent),
          ),
        ],
      );
    }
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              // 저장하기
              isEdit = !isEdit;
            });
          },
          icon: const Icon(
            Icons.save,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: () {
            setState(() {
              isEdit = !isEdit;
            });
          },
          icon: const Icon(Icons.close, color: Colors.redAccent),
        ),
      ],
    );
  }
}
