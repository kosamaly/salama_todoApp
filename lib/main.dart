import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salama_todoapp/logic/todos_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => TodosListProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  ToDoListScreenState createState() => ToDoListScreenState();
}

class ToDoListScreenState extends State<ToDoListScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
              onPressed: () {
                context.read<TodosListProvider>().clearAll();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(18),
                  height: double.infinity,
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: myController,
                        maxLength: 27,
                        decoration:
                            const InputDecoration(labelText: "Add new task"),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            context
                                .read<TodosListProvider>()
                                .addTask(myController.text);
                            myController.clear();

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                );
              });
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: Colors.cyan,
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8,
            ),
            Expanded(child: ListXWidget()),
          ],
        ),
      ),
    );
  }
}

class ListXWidget extends StatelessWidget {
  const ListXWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodosListProvider>().todos;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Number of TODOs ${todos.length}",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          Expanded(
            child: ListView(
              children: [
                ...todos
                    .map((todo) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<TodosListProvider>()
                                      .updateTodoState(todo.task);
                                },
                                icon: Icon(
                                  todo.isDone
                                      ? Icons.check_box
                                      : Icons.check_box_outline_blank,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                todo.task,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : null),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<TodosListProvider>()
                                      .removeSingleTask(todo.task);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList()
              ],
            ),
          )
        ],
      ),
    );
  }
}
