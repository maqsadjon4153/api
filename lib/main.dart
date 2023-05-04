import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  home: Scaffold(
    appBar: AppBar(
      title: Text('API'),
    ),
    body: DataFromAPi(),
  ),
  )
  );
}

class DataFromAPi extends StatefulWidget{
  @override
  _DataFromAPiState  createState()=> _DataFromAPiState();
}


class _DataFromAPiState extends State<DataFromAPi> {
  get http => null;
  Future getUserData() async{
    var response = await http.get(Uri.http('https://jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];
    for(var u in jsonData){
      User user = User(u["name"], u["email"], u["userName"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }
  @override
  Widget build(BuildContext context) {
   return Container(
     child: Card(
         child: FutureBuilder(
           future: getUserData(),
           builder: (context, snapshot) {
             if (snapshot.data == null) {
               return Container(
                 child: Center(
                     child: Text('Loading....')
                 ),
               );
             } else
               return ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (context, i) {
                     return ListTile(
                       title: Text(snapshot.data[i].name),
                     );
                   });
           },
         )
     ),
   );
  }
}

class User {
  final String name, email, userName;
  User(this.name, this.email, this.userName);
}
