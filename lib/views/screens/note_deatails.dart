import 'package:flutter/material.dart';
import 'package:notes_app2/constants.dart';
import 'package:notes_app2/models/database.dart';
import 'package:notes_app2/views/screens/home2.dart';

class NoteDetails extends StatelessWidget {
  int id;

  NoteDetails(this.id);

  MyDatabase myDatabase = MyDatabase();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Note $id",
          style: text1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp),
          onPressed: () {
            myDatabase.updateNote(
                id, titleController.text, descriptionController.text);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home2()));
          },
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: myDatabase.getNote(id),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              titleController.text = snapshot.data![0]["title"];
              descriptionController.text = snapshot.data![0]["description"];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Card(
                  child: ListTile(
                    title: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    subtitle: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      showCursor: true,
                      controller: descriptionController,
                    ),
                    //Text("${snapshot.data![0]["description"]}"),
                    trailing: Column(
                      children: [
                        Text("${snapshot.data![0]["date"]}"),
                        Text("${snapshot.data![0]["time"]}"),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
