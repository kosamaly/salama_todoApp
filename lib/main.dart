import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Todo state',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> todos = [
    // 'did you play footbal today ?',
    // 'did you go to gym today?',
    // 'did pay today?',
    // 'what is you nam, i guess you are M.Salama fot sure, is not it?',
  ];
  void addTask(String task) {
    setState(() {
      todos.add(myController.text);
      todos.clear();
    });
  }

  final String varTitle = "";
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.all(18),
                  height: double.infinity,
                  color: Colors.white70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: myController,
                        maxLength: 27,
                        decoration: InputDecoration(labelText: " Add New Task"),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            addTask(myController.text);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "ADD",
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.cyan,
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 80,
          ),
          // ListView.builder(
          //   itemCount: todos.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Text("you Task: ${myController.text}");
          //   },
          // )
          // Text(
          //   "you Task: ${myController.text}",
          //   style: TextStyle(fontSize: 22),
          // )
        ]),
      ),
    );
  }
}
