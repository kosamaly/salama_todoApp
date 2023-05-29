import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'logic.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => ListX(),
    )
  ], child: const MyApp()));
}

final String varTitle = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo State',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  final String varTitle = "";
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: myController,
                        maxLength: 27,
                        decoration: InputDecoration(labelText: "Add new task"),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {
                            context.read<ListX>().addTask(myController.text);
                            Navigator.pop(context);
                            myController.clear();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 80,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...context.watch<ListX>().todos.map(
              (item) => FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ///  The `ListXWidget` should use the `item` variable inside the `Text` widget to display each task, instead of `context.watch<ListX>().todos`, which will display the entire list.
                        item,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
// class ListXWidget extends StatelessWidget {
// const ListXWidget({Key? key}) : super(key: key);
//
// @override
// Widget build(BuildContext context) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       ...context.watch<ListX>().todos.map(
//             (item) => FractionallySizedBox(
//           widthFactor: 0.9,
//           child: Container(
//             margin: EdgeInsets.only(top: 20),
//             padding: EdgeInsets.all(22),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   '${context.watch<ListX>().todos}',
//                   style:
//                   const TextStyle(fontSize: 18, color: Colors.yellow),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
// }
