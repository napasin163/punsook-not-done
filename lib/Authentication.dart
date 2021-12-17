// ignore_for_file: unused_import, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthImplementation
{
  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
}


class Auth implements AuthImplementation
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> SignIn(String email, String password) async
  {
    User user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)) as User;
    return user.uid;
  }

  @override
  Future<String> SignUp(String email, String password) async
  {
    User user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)) as User;
    return user.uid;
  }

  @override
  Future<String> getCurrentUser() async
  { 
    User ?user   = _firebaseAuth.currentUser;
    return user!.uid;
  }


  @override
  Future<void> signOut() async
  {
    _firebaseAuth.signOut();  
  }
}