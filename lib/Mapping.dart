// ignore_for_file: unnecessary_new, no_duplicate_case_values, file_names, use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';
import 'Authentication.dart';
import 'package:punsook/LoginRegisterPage.dart';

class MappingPage extends StatefulWidget
{
  final AuthImplementation auth;
  
  const MappingPage
  ({
    required this.auth,
  });


  @override
  State<StatefulWidget> createState()
  {
    return _MappingPageState();
  }
}


enum AuthStatus
{
  notSignedIn,
  signedIn,
}


class _MappingPageState extends State<MappingPage>
{
  AuthStatus _authStatus = AuthStatus.notSignedIn;


  @override
  void initState() 
  {
    super.initState();

    widget.auth.getCurrentUser().then((firebaseUserId)
    {
        setState(() {
            _authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
    });
  }


  void _signedIn()
  {
    setState(() {
          _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut()
  {
    setState(() {
          _authStatus = AuthStatus.notSignedIn;
    });
  }



  @override
  Widget build(BuildContext context)
   {
     switch(_authStatus)
     {
       case AuthStatus.notSignedIn:
       return new LoginRegisterPage
       (
         auth: widget.auth, 
         onSignedIn: _signedIn, onSignedOut: () {  },
       );



       case AuthStatus.signedIn:
       return new HomePage  
       (
         auth: widget.auth, 
         onSignedOut: _signedOut, 
       );
     }

      
  }
}