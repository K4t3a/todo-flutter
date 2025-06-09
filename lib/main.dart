import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

// Модель Туду
class Todo {
  final String id;
  final String title;
  final String text;

  Todo({
    required this.id,
    required this.title,
    required this.text,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App for Windows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _todos = [];

  void _addTodo(String title, String text) {
    final newTodo = Todo(
      id: const Uuid().v4(), // Генерация уникального ID
      title: title,
      text: text,
    );

    setState(() {
      _todos.add(newTodo);
    });
  }

  void _openAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String text = '';
        return AlertDialog(
          title: const Text('Добавить задачу'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Заголовок'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onChanged: (value) => text = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && text.isNotEmpty) {
                  _addTodo(title, text);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo список'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          final todo = _todos[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.text),
            leading: Text('${index + 1}'),
            trailing: Text(todo.id.substring(0, 4)), // короткий ID
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
