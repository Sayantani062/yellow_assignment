import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yellow_movies/DataBaseFunctions/AllFunctions.dart';

import 'main.dart';

class AddOrEditPage extends StatefulWidget {
  final adding;
  final uri;
  final movieName;
  final director;
  final map;

  AddOrEditPage({
    @required this.adding,
    this.uri,
    this.movieName,
    this.director,
    this.map,
  });

  @override
  _AddOrEditPageState createState() => _AddOrEditPageState();
}

class _AddOrEditPageState extends State<AddOrEditPage> {
  final picker = ImagePicker();
  TextEditingController movieNameCon = TextEditingController();
  TextEditingController directorCon = TextEditingController();
  bool movieError = false;
  bool directorError = false;
  var link;

  @override
  void initState() {
    super.initState();
    movieNameCon.text = widget.movieName == null ? '' : widget.movieName;
    directorCon.text = widget.director == null ? '' : widget.director;
    link = widget.uri;
  }

  var top;

  final fadingCircle = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index.isEven ? Colors.blue : Colors.blue,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.adding ? 'Add' : 'Edit Info'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: link == null
                          ? Icon(
                              Icons.add_a_photo,
                              size: 30,
                            )
                          : Image.file(
                              File(link),
                              height: 200,
                              width: 200,
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: movieNameCon,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            errorText: movieError ? 'Field required' : null,
                            filled: true,
                            prefixIcon: Icon(
                              Icons.movie,
                              color: Colors.teal,
                            ),
                            hintText: 'Title Of Movie',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: directorCon,
                          decoration: InputDecoration(
                            errorText: directorError ? 'Field required' : null,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.teal,
                            ),
                            filled: true,
                            hintText: 'Directed by',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          print('pressed');
                          if (movieNameCon.text.isEmpty) {
                            setState(() {
                              movieError = true;
                            });
                            return;
                          } else {
                            movieError = false;
                          }
                          if (directorCon.text.isEmpty) {
                            directorError = true;
                            setState(() {
                              directorError = true;
                            });
                            return;
                          } else {
                            directorError = false;
                          }
                          AllFunctions allFunctions = AllFunctions();
                          if (widget.adding) {
                            if (link == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {},
                                  ),
                                  content: Text('Pick an image'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              return;
                            }
                            print('Adding');
                            await allFunctions.addItem(
                              director: directorCon.text,
                              link: link,
                              name: movieNameCon.text,
                            );
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                                (route) => false);
                            return;
                          } else {
                            print('Edit');
                            final moviesTable = await allFunctions.updateItem(
                              id: widget.map['id'],
                              name: movieNameCon.text,
                              director: directorCon.text,
                              link: link,
                            );
                            Navigator.pop(context, moviesTable);
                            return;
                          }
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              widget.adding ? 'ADD' : 'EDIT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: top,
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        link = pickedFile.path;
        setState(() {});
      } else {
        print('No image selected.');
      }
    });
  }
}
