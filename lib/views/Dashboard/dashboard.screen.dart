import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sigaa_student/views/ClassFocused/class_focused.dart';
import 'package:sigaa_student/views/Dashboard/dashboard.dto.dart';
import 'package:sigaa_student/repository/student_class.dart';

// ClassScreen the statefulwidget
class DashboardScreen extends StatefulWidget {
  static const id = "Screen_used_to_show_all_elements";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// _ClassScreenState is the stateless object
class _DashboardScreenState extends State<DashboardScreen> {
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
          title: Text(
            'Turmas',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          backwardsCompatibility: false,
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          foregroundColor: Theme.of(context).accentColor),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ClassFocused())
                );
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
    if (this._items.isEmpty) {
      return Center(
        child: Wrap(
          children: [
            Column(
              children: [
                Text("Não existem turmas para o período atual."),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.deepPurple,
                      size: 30.0,
                    ))
              ],
            )
          ],
        ),
      );
    } else
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          return Card(
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print({i, "tapped on this card"});
                  },
                  child: SizedBox(
                    width: 300,
                    height: 150,
                    child: Container(
                        margin: EdgeInsets.all(14.0),
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                            child: Wrap(
                                spacing: 20,
                                runSpacing: 20,
                                children: <Widget>[
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _items[i].acronym,
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      _items[i].place,
                                      textAlign: TextAlign.right,
                                    )
                                  ]),
                              Text(
                                _items[i].classname,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ]))),
                  )));
        },
        itemCount: _items.length,
      );
  }
}
