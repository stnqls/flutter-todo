import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();
  bool isEdit = false;

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
                    onPressed: () {
                      setState(() {
                        _todoController.text;
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
