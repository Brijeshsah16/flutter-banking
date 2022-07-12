import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePersonsPage extends StatefulWidget {
  final String id;
  const UpdatePersonsPage({Key? key,required this.id}) : super(key: key);

  @override
  State<UpdatePersonsPage> createState() => _UpdatePersonsPageState();
}

class _UpdatePersonsPageState extends State<UpdatePersonsPage> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference persons =
  FirebaseFirestore.instance.collection('persons');

  CollectionReference trans =
  FirebaseFirestore.instance.collection('trans');



  Future<void>updateUser(id,current_bal,payment,name)
  async {
    var new_bal=int.parse(current_bal)+int.parse(payment);
    var new_bal_s=new_bal.toString();
    updatetrans(name, payment);
    return persons
        .doc(id)
        .update({'balance':new_bal_s })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void>updatetrans(name,payment)
  async {

    return trans
        .add({'name':name ,'payment': payment })
        .then((value) => print("tans Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("pay balance"),
      ),
        body: Form(
          key: _formKey,
          child: FutureBuilder<DocumentSnapshot < Map<String,dynamic>>>(
            future: FirebaseFirestore.instance.collection('persons').doc(widget.id).get(),
            builder: ( _ ,snapshot){
               if(snapshot.hasError)
                 {
                   print('something went wrong');
                 }
               if(!snapshot.hasData)
                 { print(widget.id);
                   return Center(child: CircularProgressIndicator(),);
                 }

              var data=snapshot.data!.data();
               String name =data!['name'];
               String email= data['email'];
               String current_balance  = data['balance'];
               String payment="";

               return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                            child: TextFormField(
                              initialValue: '0',
                              autofocus: false,
                              onChanged: (value)=> payment=value,
                              decoration: InputDecoration(
                                labelText: 'amount',
                                labelStyle: TextStyle(fontSize: 20.0),
                                border: OutlineInputBorder(),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter amount';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                updateUser(widget.id,current_balance,payment,name);
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'pay',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'Reset',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                      ]
                  )
              );



            }
          )

    )
    );
  }
}
