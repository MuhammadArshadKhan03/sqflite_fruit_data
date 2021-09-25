import 'package:flutter/material.dart';
import 'package:sqflite_app/globals/global.dart';
import 'package:sqflite_app/helper/fruit_helper.dart';
import 'package:sqflite_app/model/fruit_model.dart';

class ShowDialogBox extends StatefulWidget {
  const ShowDialogBox({Key? key}) : super(key: key);

  @override
  _ShowDialogBoxState createState() => _ShowDialogBoxState();
}

class _ShowDialogBoxState extends State<ShowDialogBox> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.amber,
      title: const Text("Alert Dialog"),
      content: SingleChildScrollView(
        child: ListBody(
          children: const [Text("Are you sure to delete ?")],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                DatabaseHelper().remove(Globals.selectedFruitId);
                Navigator.pop(context, "Yes");
              });
            },
            child: const Text("Yes")),
        TextButton(
            onPressed: () {
              Navigator.pop(context, "No");
            },
            child: const Text("No")),
      ],
    );
  }
}
