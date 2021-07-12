import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_indicator/loading_indicator.dart';

var fb = FirebaseFirestore.instance;

class TeachersPage extends StatefulWidget {
  const TeachersPage({Key key}) : super(key: key);

  @override
  _TeachersPageState createState() => _TeachersPageState();
}

//   class ExpenseList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new StreamBuilder<QuerySnapshot>(
//         stream: fb.collection("teachers").snapshots,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) return ;
//           return new ListView(children: getExpenseItems(snapshot));
//         });
//   }

//   getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
//     return snapshot.data.documents
//         .map((doc) => new ListTile(title: new Text(doc["name"]), subtitle: new Text(doc["amount"].toString())))
//         .toList();
//   }
// }
class _TeachersPageState extends State<TeachersPage> {
  final fb = FirebaseDatabase.instance;
  List<String> names = <String>[
    'Sandra Clarkson',
  ];
  List<String> emails = <String>["sclarkson678@gmail.com"];
  List<String> subjects = <String>["Math"];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  void addItemToList() {
    setState(() {
      final ref = fb.reference();
      CollectionReference teachers =
          FirebaseFirestore.instance.collection('teachers');
      teachers.add({
        'address': emailController.text, // John Doe
        'class': subjectController.text, // Stokes and Sons
        'name': nameController.text // 42
      });

      ref.child("teacher").child("tname").set(nameController.text);
      ref.child("teacher").child("class").set(subjectController.text);
      ref.child("teacher").child("email").set(emailController.text);
      names.insert(0, nameController.text);
      emails.insert(0, emailController.text);
      subjects.insert(0, subjectController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Teachers'),
      ),
      body: UserInformation(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          splashColor: Colors.teal,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add Teacher'),
                    content: Container(
                        height: 300.0, // Change as per your requirement
                        width: 300.0, // Change as per your requirement
                        child: ListView(children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contact Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'E-mail',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20, bottom: 10, right: 20),
                            child: TextField(
                              controller: subjectController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Subject',
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: Text('Add'),
                            onPressed: () {
                              Navigator.pop(context);
                              addItemToList();
                            },
                          ),
                          UserInformation(),
                        ])),
                  );
                });
          }),
    );
  }
}

// StreamBuilder(
//               stream:
//                   FirebaseFirestore.instance.collection('teachers').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return null;
//                 } else {
//                   // List<DocumentSnapshot> items = snapshot.data.documents;
//                   return Expanded(
//                       child: ListView(
//                     padding: const EdgeInsets.all(8),
//                     children:
//                         snapshot.data.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data() as Map<String, dynamic>;
//                       return new Card(
//                         child: ListTile(
//                           title: Text('${data["name"]}'),
//                           subtitle: Text(
//                             '${data["address"]}',
//                             style:
//                                 TextStyle(color: Colors.black.withOpacity(0.6)),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ));
//                 }
//               }),

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('teachers').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          LoadingIndicator(
            indicatorType: Indicator.orbit,
            color: Theme.of(context).primaryColor,
          );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['address']),
            );
          }).toList(),
        );
      },
    );
  }
}
