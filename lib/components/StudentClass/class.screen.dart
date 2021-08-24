import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sigaa_student/components/StudentClass/class.dto.dart';
import 'package:sigaa_student/repository/student_class.dart';

// ClassScreen the statefulwidget
class ClassScreen extends StatefulWidget {
  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

// _ClassScreenState is the stateless object
class _ClassScreenState extends State<ClassScreen> {
  final _items = <StudentClassDTO>[];
  final StudentClassStore store = StudentClassStore();

  @override
  void initState() {
    super.initState();

    init();
  }

  // init function
  Future init() async {
    await store.init();
    final items = await store.getAll();
    setState(() {
      this._items.addAll(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      _items.addAll([]);
    }
    return Scaffold(
      body: _buildItemsList(),
      appBar: AppBar(
          title: const Text(
            'Turmas',
            style: TextStyle(color: Colors.deepPurple),
          ),
          backwardsCompatibility: false,
          elevation: 0,
          backgroundColor: Colors.white10,
          foregroundColor: Colors.deepPurple),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('User'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // _buildItemList does a mapping for each row
  Widget _buildItemsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return Card(
            elevation: 2,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                print({i, "message"});
              },
              child: SizedBox(
                  width: 300,
                  height: 150,
                  child: Container(
                      margin: EdgeInsets.all(14.0),
                      padding: EdgeInsets.all(16.0),
                      child:
                          Wrap(spacing: 20, runSpacing: 20, children: <Widget>[
                        Row(children: [
                          Text(
                            _items[i].acronym,
                            textScaleFactor: 1.5,
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Text(
                                _items[i].place,
                                textAlign: TextAlign.right,
                              ))
                        ]),
                        Text(
                          _items[i].classname,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ]))),
            ));
      },
      itemCount: _items.length,
    );
  }
}
