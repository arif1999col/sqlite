import 'package:flutter/material.dart';
import 'dart:async';

import '../models/kontak.dart';
import '../models/crud.dart';
import './form_screen.dart';
import '../aboutme.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<Kontak>> future;
  @override
  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getContactList();
    });
  }

  Future<Kontak> navigateToEntryForm(
      BuildContext context, Kontak contact) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(contact);
    }));
    return result;
  }

  Card cardo(Kontak contact) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.people),
        ),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(contact.phone.toString()),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Peringatan"),
                    content: Text("Ingin Menghapus ${contact.name}?"),
                    actions: [
                      FlatButton(
                        onPressed: () async {
                          int result = await dbHelper.delete(contact);
                          if (result > 0) {
                            updateListView();
                          }
                          Navigator.pop(context);
                        },
                        child: Text("Iya"),
                      ),
                      FlatButton(
                        child: Text("Tidak"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                });
          },
        ),
        onTap: () async {
          var contact2 = await navigateToEntryForm(context, contact);
          if (contact2 != null) {
            int result = await dbHelper.update(contact2);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SqlLite Tes'),
        centerTitle: true,
         actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.contacts),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Aboutme()));
            },
          ),
             Container(
                    child:
                   Image.network('https://cloud.netlifyusercontent.com/assets/344dbf88-fdf9-42bb-adb4-46f01eedd629/113d1046-6bdc-4475-a781-99f6cf7d1acd/001-understand-yourself-large-opt.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
        ], 
          
      ),


      body: FutureBuilder<List<Kontak>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
                children: snapshot.data.map((todo) => cardo(todo)).toList());
          } else {
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) {
            int result = await dbHelper.insert(contact);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}
