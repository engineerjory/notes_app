import 'package:flutter/material.dart';
import 'package:notes_app2/constants.dart';
import 'package:intl/intl.dart';
import 'package:notes_app2/views/screens/home.dart';
import '../../models/database.dart';
import 'home2.dart';

class NewNote extends StatefulWidget {
  NewNote({Key? key}) : super(key: key);

  //int? id ;
  // NewNote.update(this.id);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final focus = FocusNode();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  MyDatabase myDatabase = MyDatabase();

  @override
  void initState() {
    myDatabase.db;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.arrow_back_ios_sharp,
                            size: iconSize, color: iconColor),
                        onPressed: () async {
                          DateTime now = DateTime.now();
                          String time = now.hour.toString() +
                              ":" +
                              now.minute.toString() +
                              ":" +
                              now.second.toString();
                          String date = DateFormat(' EEE d MMM').format(now);

                          // TODO : add note to data base
                          int response = await myDatabase.addNoteToDatabase(
                              titleController.text,
                              descriptionController.text,
                              date,
                              time);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home2()));
                        },
                      ),
                      Text(
                        "Note",
                        style: text1,
                      ),
                    ],
                  ),
                  Text(
                    "Done",
                    style: text1,
                  ),
                ],
              ),
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(focus);
                },
                autofocus: true,
                showCursor: true,
                cursorColor: iconColor,
                cursorHeight: 40,
                style: formText1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                maxLines: null,
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                focusNode: focus,
                showCursor: true,
                cursorColor: iconColor,
                cursorHeight: 40,
                style: formText2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
