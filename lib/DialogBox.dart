// ignore_for_file: deprecated_member_use, file_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DialogBox 
{
  information(BuildContext context, String title, String description)
  {
    return showDialog
    (
      context: context, 
      barrierDismissible: true,

      builder: (BuildContext context)
      {
        return AlertDialog
        (
          title: Text(title),
          content: SingleChildScrollView
          (
            child: ListBody
            (
              children: <Widget>
              [
                Text(description)
              ],

            ),

          ),


          actions: <Widget>
          [
            FlatButton
            (
              child: const Text("Ok"),
              onPressed: ()
              {
                return Navigator.pop(context);
              } 
              
            )
          ],
        );
      }
    );
  }
}