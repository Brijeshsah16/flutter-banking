import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
class AddPersonsPage extends StatefulWidget {
  const AddPersonsPage({Key? key}) : super(key: key);

  @override
  State<AddPersonsPage> createState() => _AddPersonsPageState();
}

class _AddPersonsPageState extends State<AddPersonsPage> {
  final _formKey = GlobalKey<FormState>();
  var name= "";
  var email= "";
  var balance ="";

  final nameController =TextEditingController();
  final emailController =TextEditingController();
  final balanceController =TextEditingController();

  @override
  void dispose()
  {
    nameController.dispose();
    emailController.dispose();
    balanceController.dispose();
    super.dispose();
  }
  clearText()
  {
    nameController.clear();
    emailController.clear();
    balanceController.clear();

  }

  CollectionReference students = FirebaseFirestore.instance.collection('persons');

  Future<void> addUser()
  async {
    return students
        .add({'name': name, 'email': email, 'balance': balance})
        .then((value) => print('user added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new user'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: 'Email: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Email';
                    } else if (!value.contains('@')) {
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },

                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Balance: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: balanceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter balance';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              name = nameController.text;
                              email = emailController.text;
                              balance = balanceController.text;
                              addUser();
                              clearText();
                            });
                          }
                        },
                        child: Text(
                          'RegisterUser',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {clearText()},
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      ),
                    ]
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
