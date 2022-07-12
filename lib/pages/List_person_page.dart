import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'update_person_page.dart';
class ListPersonsPage extends StatefulWidget {
  const ListPersonsPage({Key? key}) : super(key: key);

  @override
  State<ListPersonsPage> createState() => _ListPersonsPageState();
}

class _ListPersonsPageState extends State<ListPersonsPage> {
   final Stream<QuerySnapshot> personStream=FirebaseFirestore.instance.collection('persons').snapshots();

  deleteuser(id)
    {
      print('user deleted $id');
    }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text('PAYMENT PAGE'),

           ],
         ),

       ),
       body:   StreamBuilder<QuerySnapshot>
        ( stream: personStream,

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>
          snapshot){
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final List storedocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(a);
              a['id'] = document.id;
            }).toList();

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Table(
                  border: TableBorder.all(),
                  columnWidths: const <int,TableColumnWidth>{
                    1: FixedColumnWidth(140)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                            child: Container(
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ),
                        TableCell(
                            child: Container(
                              color: Colors.green,
                              child: Center(
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                'Balance',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]
                    ),
                   for(var i=0; i<storedocs.length;i++) ...[
                    TableRow(
                        children: [
                          TableCell(
                            child: Container(

                              child: Center(
                                child: Text(
                                  storedocs[i]['name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(

                              child: Center(
                                child: Text(
                                  storedocs[i]['email'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(

                              child: Center(
                                child: Text(
                                  storedocs[i]['balance'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // IconButton(
                                //     onPressed: ()=>{
                                //       print(storedocs),
                                //
                                //     },
                                //     icon: const Icon(
                                //       Icons.abc,
                                //       color: Colors.green,
                                //     )
                                // ),

                                IconButton(
                                    onPressed: ()=>{
                                      // print(storedocs),
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context)=>
                                                  UpdatePersonsPage(
                                                      id: storedocs[i]['id']
                                                  ),
                                          ),
                                      ),
                                    },
                                    icon: const Icon(
                                      Icons.monetization_on,
                                      color: Colors.green,
                                    )
                                ),



                              ],
                            ),
                          )
                        ]
                    ),
                      ]
                  ]
                    ),


                ),


            );
          }
       ),
     );


  }
}
