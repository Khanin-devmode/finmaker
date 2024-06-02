import 'package:flutter/material.dart';

Future<bool?> confirmDeleteDialog(BuildContext context,
    {String? title, String? content}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Return true
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
