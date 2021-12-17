// ignore_for_file: use_key_in_widget_constructors, avoid_print, file_names, import_of_legacy_library_into_null_safe, unused_field

import 'package:flutter/material.dart';
import 'package:punsook/DialogBox.dart';
import 'Authentication.dart';
import 'package:nextflow_thai_personal_id/nextflow_thai_personal_id.dart';


class LoginRegisterPage extends StatefulWidget
{

  const LoginRegisterPage
  ({
    required this.auth,
    required this.onSignedIn, required void Function() onSignedOut,

  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;


  @override
  State<StatefulWidget> createState()
    {
      return _LoginRegisterState();
    }
}



enum FormType
{
    login,
    register
}


class _LoginRegisterState extends State<LoginRegisterPage>
{

  DialogBox dialogBox = DialogBox();
  final formKey = GlobalKey<FormState>();
  ThaiIdValidator thaiIdValidator  = ThaiIdValidator(errorMessage: 'Personal ID is Incorrect, Please try agian');
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  String _personalID = "";

  
  
  //Methods
  bool validateAndSave()
  {
      final form = formKey.currentState;

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


  void validateAndSubmit() async
  {
    if(validateAndSave())
    {
      try
      {
        if(_formType == FormType.login)
        {
          String userId = await widget.auth.SignIn(_email, _password);
          //dialogBox.information(context, "Congratulations", "you are logged in suceesfully !");
          print("login userId = " + userId);
        }
        else
        {
          String userId = await widget.auth.SignUp(_email, _password);
          //dialogBox.information(context, "Congratulations", "your account has been created successfully !");
          print("Register userId = " + userId);
        }


        widget.onSignedIn();
      }
      catch(e)
      {
        dialogBox.information(context, "Error", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister()
  {
      formKey.currentState!.reset();

      setState(() {
          _formType = FormType.register;
      });
  }

  void moveToLogin()
  {
      formKey.currentState!.reset();

      setState(() {
          _formType = FormType.login;
      });
  }







  //Design
    @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("ปันสุข"),
        ),

        body: SingleChildScrollView(
          child: Container
          (
            margin: const EdgeInsets.all(15.0),
        
            child: Form
            (
              key: formKey,
        
        
        
              child: Column
              (
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInputs() + createButtons(),
              ),
            ),
          ),
        ),

      );
  }



  List<Widget> createInputs() 
  {
      return
      [
          const SizedBox(height: 10.0,),
          logo(),
          const SizedBox(height: 20.0,),


          TextFormField
          (
            decoration: const InputDecoration(labelText: 'Email'),


            validator: (value)
            {
              return value!.isEmpty ? 'Email is required' : null;
            },

            onSaved: (value)
            {
                _email = value!;
            },
          ),

          
          const SizedBox(height: 10.0,),

          TextFormField
          (
            decoration:  const InputDecoration(labelText: 'Password'),
            obscureText: true,

            validator: (value)
            {
              return value!.isEmpty ? 'Password is required' : null;
            },

            onSaved: (value)
            {
               _password = value!;
              
            },
          ),


          const SizedBox(height: 20.0,),

          TextFormField
          (
            decoration: const InputDecoration(labelText: 'Personal ID'),
            maxLength: 13,
            
            validator: (value)
            {
              return value!.isEmpty ? 'Personal ID is required' : null;
            },

            onSaved: (value)
            {
                _personalID = value!;
            },
          ),

          
          const SizedBox(height: 10.0,),

      ];
  }


  Widget logo()
  {
      return Hero
      (
        tag: 'hero',

          child: CircleAvatar
          (
              backgroundColor: Colors.transparent,
              radius: 100.0,
              child: Image.asset('images/Logo.png'),
          ),
      );
  }

  List<Widget> createButtons() 
  {
      if(_formType == FormType.login)
      {
          return
          [
              // ignore: deprecated_member_use
              RaisedButton
              (
                child: const Text("Login", style: TextStyle(fontSize: 20.0)),
                textColor: Colors.black,
                color: Colors.yellow[600],

                onPressed: validateAndSubmit,
              ),


              // ignore: deprecated_member_use
              FlatButton  
              (
                child: const Text("Not have an Account ? Create Account ?", style: TextStyle(fontSize: 14.0)),
                textColor: Colors.red,

                onPressed: moveToRegister,
              ),
          ];
      }

      else
      {
          return
          [
              // ignore: deprecated_member_use
              RaisedButton
              (
                child: const Text("Create Account", style: TextStyle(fontSize: 20.0)),
                textColor: Colors.black,
                color: Colors.yellow[600],

                onPressed: validateAndSubmit,
              ),


              // ignore: deprecated_member_use
              FlatButton  
              (
                child: const Text("Alredy have an Account ? Login", style: TextStyle(fontSize: 14.0)),
                textColor: Colors.red,

                onPressed: moveToLogin,
              ),
          ];
      }
  }
}