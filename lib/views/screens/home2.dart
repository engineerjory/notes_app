import 'package:flutter/material.dart';
import 'package:notes_app2/constants.dart';
import 'package:notes_app2/models/database.dart';
import 'package:notes_app2/views/screens/new_note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app2/views/screens/note_deatails.dart';

class Home2 extends StatefulWidget {
  Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  MyDatabase myDatabase = MyDatabase();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        title: Center(
            child: Text(
          "Notes",
          style: text1,
        )),
        //  leading:null,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: myDatabase.getAllNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData) {
              counter = snapshot.data!.length;
              return Column(
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NoteDetails(
                                              snapshot.data![index]["id"])),
                                    );
                                  },
                                  child: Card(
                                    child: Slidable(
                                      // Specify a key if the Slidable is dismissible.
                                      key: const ValueKey(0),
                                      // The start action pane is the one at the left or the top side.
                                      startActionPane: ActionPane(
                                        // A motion is a widget used to control how the pane animates.
                                        motion: const ScrollMotion(),

                                        // A pane can dismiss the Slidable.
                                        dismissible:
                                            DismissiblePane(onDismissed: () {
                                          myDatabase.deleteNote(
                                              snapshot.data![index]["id"]);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Home2()));
                                        }),

                                        // All actions are defined in the children parameter.
                                        children: [
                                          // A SlidableAction can have an icon and/or a label.
                                          SlidableAction(
                                            onPressed: (BuildContext context) {
                                              // myDatabase.deleteNote(snapshot.data![index]["id"]);
                                            },
                                            backgroundColor: Color(0xFFFE4A49),
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        title: Text(
                                            "${snapshot.data![index]["title"]}"),
                                        subtitle: Text(
                                          "${snapshot.data![index]["description"]}",
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Column(
                                          children: [
                                            Text(
                                                "${snapshot.data![index]["date"]}"),
                                            Text(
                                                "${snapshot.data![index]["time"]}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                            })),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              "${counter} Notes",
                              style: text1,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewNote()));
                              },
                              child: Icon(
                                Icons.add_circle_outline_sharp,
                                size: iconSize,
                                color: iconColor,
                              ),
                            )
                          ],
                        )),
                  ),
                ],
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
