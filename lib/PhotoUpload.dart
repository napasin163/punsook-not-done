// ignore_for_file: deprecated_member_use, unused_import, unused_field, non_ant_identifier_names, unused_local_variable, unnecessary_null_comparison, avoid_unnecessary_containers, file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';


class UploadPhotoPage extends StatefulWidget
{
   UploadPhotoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()
  {
    return _UploadPhotoPageState();
  }
}



class _UploadPhotoPageState extends  State<UploadPhotoPage>
{
  var sampleImage;
  String _myValue = "";
  final formkey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();


  Future getImage() async
  {
    var tempImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() 
    {
        sampleImage = XFile;
    });
  }

  bool validateAndSave()
  {
    final form = formkey.currentState;

    if(form!.validate())
    {
      form.save();
      return true;
    }
    else
      {
        return false;
      }
  }





  @override
  Widget build(BuildContext context)
   {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("Upload Image"),
        centerTitle: true,
        ),


        body: Center
        (
          child: sampleImage == null?  Text("Select an Image"): enableUpload(),
        ),


        floatingActionButton: FloatingActionButton
        (
          onPressed: getImage,
          tooltip: 'Add image',
          child:  Icon(Icons.add_a_photo),
        ),
    );  
  }



  Widget enableUpload()
  {
      return Container
      (
              child: Form
              (
                key: formkey,

              child: Column
              (
                children: <Widget>
                [
                  Image.file(sampleImage, height: 330.0, width: 630.0,),

                   SizedBox(height: 15.0,),

                  TextFormField
                  (
                    decoration:  InputDecoration(labelText: 'Description'),

                    validator: (value)
                    {
                      return value!.isEmpty ? 'Description is required': null;
                    },

                    onSaved: (value)
                    {
                      _myValue = value!;

                    },
                  ),

                   SizedBox(height: 15.0,),

                  RaisedButton
                  (
                    elevation: 10.0,
                    child:  Text("Add n New Post"),
                    textColor: Colors.white,
                    color: Colors.yellow[800],
                    onPressed: validateAndSave,
                  ),
                ],
              ),
          ),
      );
  }
}