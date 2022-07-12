import 'package:flutter/material.dart';
import 'add_person_page.dart';
import 'List_person_page.dart';
import 'transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('BRIJESH SAH-BANKING'),
            ElevatedButton(
                onPressed: ()=>{
                  Navigator.push(
                      context,
                    MaterialPageRoute(
                        builder: (context)=>AddPersonsPage(),
                    )
                  )
                  },

                child: Text('ADD')
            ),
          ],
        ),
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Image.asset('assets/images/bank_photo.jpg'),
        ElevatedButton(
            onPressed: ()=>{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>ListPersonsPage(),
                  )
              )
            },

            child: Text('PERFORM TRANSACTION')
        ),
        ElevatedButton(
            onPressed: ()=>{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>AddPersonsPage(),
                  )
              )
            },

            child: Text('ADD PERSON')
        ),
        ElevatedButton(
            onPressed: ()=>{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>TransPage(),
                  )
              )
            },

            child: Text('SHOW RECENT TRANSACTION')
        ),
      ],

    )

    // ListPersonsPage(),
    );
  }
}
