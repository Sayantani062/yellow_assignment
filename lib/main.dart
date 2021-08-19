import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yellow_movies/AddOrEditPage.dart';
import 'package:yellow_movies/component/BoxDialog.dart';
import 'DataBaseFunctions/AllFunctions.dart';
import 'component/MyList.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> showAbleList = [];
  var top;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Movies'),
        actions: [
          IconButton(
            onPressed: () async {
              final moviesTable = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddOrEditPage(
                    adding: true,
                  ),
                ),
              );
              if (moviesTable != null) {
                setState(() {
                  showAbleList = getList(moviesTable);
                });
              }
              setState(() {
                top = null;
              });
            },
            icon: Icon(Icons.person_add),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: showAbleList,
          ),
          Center(
            child: top,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initAll();
  }

  Future<void> initAll() async {
    AllFunctions allFunctions = AllFunctions();
    final moviesList = await allFunctions.getDb();
    showAbleList = getList(moviesList);
    setState(() {});
  }

  List<Widget> getList(moviesList) {
    List<Widget> list = [];
    for (int i = 0; i < moviesList.length; i++) {
      print(moviesList[i]['movie_name']);
      list.add(
        MyList(
          onPressed: () {
            top = BoxDialog(
              onCancel: () {
                setState(() {
                  top = null;
                });
              },
              onEdit: () async {
                final moviesTable = await Navigator.push(
                  this.context,
                  MaterialPageRoute(
                    builder: (context) => AddOrEditPage(
                      adding: false,
                      map: moviesList[i],
                      uri: moviesList[i]['link'],
                      director: moviesList[i]['director_name'],
                      movieName: moviesList[i]['movie_name'],
                    ),
                  ),
                );
                if (moviesTable != null) {
                  setState(() {
                    showAbleList = getList(moviesTable);
                  });
                }
                setState(() {
                  top = null;
                });
              },
              onDelete: () async {
                AllFunctions allFunctions = AllFunctions();
                final moviesListAfterDelete =
                    await allFunctions.deleteItem(id: moviesList[i]['id']);
                showAbleList = getList(moviesListAfterDelete);
                setState(() {
                  top = null;
                });
              },
              image: File(moviesList[i]['link']),
            );
            setState(() {
              print('SetState');
            });
          },
          title: moviesList[i]['movie_name'],
          subtitle: moviesList[i]['director_name'],
          uri: moviesList[i]['link'],
        ),
      );
    }
    return list;
  }
}
