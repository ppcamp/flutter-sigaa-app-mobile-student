import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';

// ClassScreen the statefulwidget
class DashboardScreen extends StatefulWidget {
  static const id = "Screen_used_to_show_all_elements";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// _ClassScreenState is the stateless object
class _DashboardScreenState extends State<DashboardScreen> {
  final _items = <Subjects>[];
  late Box<Subjects> _box;

  @override
  void dispose() {
    this._box.close();

    super.dispose();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    if (!Hive.isBoxOpen(Subjects.boxName)) {
      await Hive.openBox<Subjects>(Subjects.boxName);
    }

    this._box = Hive.box<Subjects>(Subjects.boxName);

    setState(() {
      this._items.addAll(this._box.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      _items.addAll([]);
    }
    return getScaffold(context: context, body: _buildItemsList());
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
