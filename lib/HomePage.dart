
// ignore_for_file: file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, unnecessary_new

import 'package:flutter/material.dart';
import 'package:punsook/Authentication.dart';
import 'package:punsook/PhotoUpload.dart';
import 'Authentication.dart';
import 'PhotoUpload.dart';


class HomePage extends StatefulWidget
{
  HomePage
  ({
    required this.auth,
    required this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;    
  

  @override
  State<StatefulWidget> createState() 
  {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage>
{

  void _logoutUser() async
  {
      try
      {
        await widget.auth.signOut();
        widget.onSignedOut();
      }
      catch(e)
      {
        print(e.toString());
      }
  }

  
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
        appBar: AppBar
        (
            title:  const Text("Home"),
        ),

      body: Container
      (

      ),

      bottomNavigationBar: BottomAppBar
      (
          color: Colors.green[800],

          child: Container
          (

            margin: const EdgeInsets.only(left: 70.0 , right: 70.0),
              child: Row
              (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,

                  children: <Widget>
                  [
                      IconButton
                      (
                          icon: const Icon(Icons.logout),
                          iconSize: 50,
                          color: Colors.white,

                          onPressed: _logoutUser,
                      ),

                      new IconButton
                      (
                          icon: const Icon(Icons.add_a_photo),
                          iconSize: 40,
                          color: Colors.white,
                          onPressed: ()
                          {
                            Navigator.push
                            (
                              context,
                              MaterialPageRoute(builder: (context)
                              {
                                return UploadPhotoPage();
                              })
                              );
                          },
                      ),
                  ],
              ),
          ),
      ),


    );
  }
}