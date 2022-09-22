import 'package:flutter/material.dart';
import 'package:notes_app2/constants.dart';
import 'package:notes_app2/models/database.dart';
import 'package:notes_app2/views/screens/new_note.dart';
import 'package:notes_app2/views/screens/note_deatails.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MyDatabase myDatabase = MyDatabase();
  int counter = 0 ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Center(child: Text("Notes",style: text1,)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(20),),
                child: FutureBuilder(
                  future:myDatabase.getAllNotes(),
                  builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {


                    if(snapshot.hasData){
                       counter = snapshot.data!.length;
                       print("counter = $counter");
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                              return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context)=>NoteDetails(snapshot.data![index]["id"])),
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text("${snapshot.data![index]["title"]}"),
                                      subtitle:Text("${snapshot.data![index]["description"]}",
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                      ) ,
                                      trailing: Column(
                                        children: [
                                          Text("${snapshot.data![index]["date"]}"),
                                          Text("${snapshot.data![index]["time"]}"),
                                        ],
                                      ),
                                    ),
                                  )
                              ) ;

                          });
                    }

                    else{
                      return Center(child: CircularProgressIndicator(),);
                    }

                  },


                ),
              ),

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
                      SizedBox(width: 25,),
                      Text("${counter} Notes",style: text1,),
                      InkWell(
                        onTap: (){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context)=>NewNote()));
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
        ),
      ),
    );
  }
}
