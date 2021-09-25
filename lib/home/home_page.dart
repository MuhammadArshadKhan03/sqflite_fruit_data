import 'package:flutter/material.dart';
import 'package:sqflite_app/globals/global.dart';
import 'package:sqflite_app/helper/Dialog.dart';
import 'package:sqflite_app/helper/fruit_helper.dart';
import 'package:sqflite_app/model/fruit_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextEditingController _textEditingController = TextEditingController();

  Future<List<Fruit>>? _list;

  List<Fruit>? getlist() {
    _list = DatabaseHelper.instance.getFruit();
  }

  int? selectedId;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Sqflite"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
            ),
            RaisedButton(
              onPressed: () async {
                selectedId != null
                    ? await DatabaseHelper.instance.update(Fruit(
                        id: selectedId!, name: _textEditingController.text))
                    : DatabaseHelper.instance.add(
                        Fruit(name: _textEditingController.text),
                      );
                //   .then((value) {
                //   print("Data insert to data base $value");
                //   // DatabaseHelper.instance.getFruit().then((value) {
                //   //   print(value);
                //   // });
                // });
                setState(() {
                  _textEditingController.clear();
                  selectedId ?? null;
                });
              },
              child: Text("Add Fruit"),
            ),
            // FutureBuilder<List<Fruit>>(
            //     future: DatabaseHelper.instance.getFruit(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<List<Fruit>> snapshot) {
            //       if (!snapshot.hasData) {
            //         return const Center(
            //           child: Text("Loading"),
            //         );
            //       } else if (snapshot.connectionState ==
            //           ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       } else if (snapshot.connectionState == ConnectionState.done) {
            //         return Container(
            //           color: Colors.grey,
            //           height: 300,
            //           width: 200,
            //           child: ListView(
            //             children: snapshot.data!.map((fruit) {
            //               return Center(
            //                 child: ListTile(
            //                   onTap: () {
            //                     setState(() {
            //                       if (selectedId == null) {
            //                         _textEditingController.text = fruit.name;
            //                         selectedId = fruit.id;
            //                       } else {
            //                         _textEditingController.text = '';
            //                         selectedId = null;
            //                       }
            //                     });
            //                   },
            //                   onLongPress: () {
            //                     setState(() {
            //                       DatabaseHelper.instance.remove(fruit.id!);
            //                     });
            //                   },
            //                   title: Text(fruit.name),
            //                 ),
            //               );
            //             }).toList(),
            //           ),
            //         );
            //       } else {
            //         return const Center(
            //           child: CircularProgressIndicator(),
            //         );
            //       }
            //     })
            FutureBuilder<List<Fruit>>(
                future: DatabaseHelper.instance.getFruit(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Fruit>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: const Text('Loading...'));
                  }
                  return snapshot.data!.isEmpty
                      ? const Center(child: const Text('No Groceries in List.'))
                      : Container(
                          width: 200,
                          height: 300,
                          color: Colors.grey,
                          child: ListView(
                            children: snapshot.data!.map((fruit) {
                              return Center(
                                child: Card(
                                  color: selectedId == fruit.id
                                      ? Colors.white70
                                      : Colors.white,
                                  child: ListTile(
                                    title: Text(fruit.name),
                                    onTap: () {
                                      setState(() {
                                        if (selectedId == null) {
                                          _textEditingController.text =
                                              fruit.name;
                                          selectedId = fruit.id;
                                        } else {
                                          _textEditingController.text = '';
                                          selectedId = null;
                                        }
                                      });
                                    },
                                    onLongPress: () {
                                      print("Long press");
                                      Globals.selectedFruitId = fruit.id!;
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ShowDialogBox();
                                            // AlertDialog(
                                            //   backgroundColor: Colors.amber,
                                            //   title: const Text("Alert Dialog"),
                                            //   content: SingleChildScrollView(
                                            //     child: ListBody(
                                            //       children: const [
                                            //         Text(
                                            //             "Are you sure to delete ?")
                                            //       ],
                                            //     ),
                                            //   ),
                                            //   actions: [
                                            //     TextButton(
                                            //         onPressed: () {
                                            //           setState(() {
                                            //             DatabaseHelper.instance
                                            //                 .remove(fruit.id!);
                                            //             Navigator.pop(
                                            //                 context, "Yes");
                                            //           });
                                            //         },
                                            //         child: Text("Yes")),
                                            //     TextButton(
                                            //         onPressed: () {
                                            //           Navigator.pop(
                                            //               context, "No");
                                            //         },
                                            //         child: Text("No")),
                                            //   ],
                                            // );
                                          });
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
