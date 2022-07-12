import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransPage extends StatefulWidget {
  const TransPage({Key? key}) : super(key: key);

  @override
  State<TransPage> createState() => _TransPageState();
}

class _TransPageState extends State<TransPage> {
  final Stream<QuerySnapshot> transStream=FirebaseFirestore.instance.collection('trans').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RECENT TRANSACTION'),
      ),
      body: StreamBuilder<QuerySnapshot>
        ( stream: transStream,

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
                                    'Payment',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                      storedocs[i]['payment'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

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
