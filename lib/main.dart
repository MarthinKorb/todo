import 'package:flutter/material.dart';
import 'package:todo/models/item.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'First Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  var items = new List<Item>();

  HomePage(){
    items = [];
    items.add(Item(title: 'Item 1', done: false));
    items.add(Item(title: 'Item 2', done: false));
    items.add(Item(title: 'Item 3', done: false));
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var newTaskCtrl = TextEditingController();

  void add(){
    if(newTaskCtrl.text.isEmpty) return;

    setState(() {
      widget.items.add(
        Item(title: newTaskCtrl.text, done: false)
      );
      newTaskCtrl.clear();
    });
  }

  void remove(int index) {
    print(widget.items[index]);
    setState(() {
      widget.items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: "Nova tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext context, int index){
          final item = widget.items[index];
          return Dismissible(
            key: Key(item.title),
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value){
                setState(() {
                  item.done = value;
                });
              },
            ),
            background: Container(
              color: Colors.red.withOpacity(0.2),
            ),
            onDismissed: (direction){
              // if(direction == DismissDirection.endToStart) {
              // }
                remove(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
