import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxDialog extends StatelessWidget {
  final image;
  final onDelete;
  final onEdit;
  final onCancel;

  BoxDialog({this.image, this.onDelete, this.onEdit, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.blue,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 300,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.file(
              image,
              height: 250,
              width: 250,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: onCancel,
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: onEdit,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
