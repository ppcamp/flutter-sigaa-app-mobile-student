import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:sigaa_student/components/scaffold/scaffold.dart';
import 'package:sigaa_student/models/subjects/subjects.dart';
import 'package:sigaa_student/services/sync.dart';

// ClassScreen the statefulwidget
class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

// _ClassScreenState is the stateless object
class _DashboardScreenState extends State<DashboardScreen> {
  final _items = <Subjects>[];
  late SyncService system;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    system = SyncService();
    init();
    super.initState();
  }

  /// A function executed when the object is created
  void init() async {
    await system.updateClasses();
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      _items.addAll([]);
    }
    return getScaffold(
        title: 'Turmas', context: context, body: _buildItemsList());
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
                      Icons.done_all,
                      color: Theme.of(context).accentColor,
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
          final String place = _items[i].place;
          final String title = _items[i].acronym ?? "";
          final String subtitle = _items[i].classname;

          return Card(
              child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print("tapped on $title");
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
                                      title,
                                      textScaleFactor: 1.5,
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      place,
                                      textAlign: TextAlign.right,
                                    )
                                  ]),
                              Text(
                                subtitle,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ]))),
                  )));
        },
        itemCount: _items.length,
      );
  }
}
