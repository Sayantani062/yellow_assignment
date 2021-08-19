import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  final title;
  final subtitle;
  final uri;
  final onPressed;

  MyList({
    this.title = 'Movie title',
    this.subtitle = 'subtitle',
    this.uri,
    this.onPressed,
  });

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Material(
        elevation: 10,
        color: Colors.white,
        shadowColor: Colors.black,
        child: ListTile(
          title: Text(widget.title),
          subtitle: Text(widget.subtitle),
          leading: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(4),
              shadowColor: Colors.black,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(File(widget.uri)),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

