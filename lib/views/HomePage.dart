import 'package:flutter/material.dart';

import 'chatrooms.dart';
import 'contacts.dart';
import 'discover.dart';
import 'owner.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:chat_app/authentication/Registration.dart';
// import 'Splash.dart';

// import 'chats.dart';
// import 'package:google_fonts/google_fonts.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  String ACCOUNT_ID = "";
  final List<Widget> pages = [
    ChatRoom(),
    contacts(),
    discover(),
    owner(),
  ];
  int selectedPageIndex = 0;
  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Future <String> acc_id = getdocId();
    // getdocId().whenComplete(() => setState((){

    // }));
    // //getId();getdocId().then((value) => {
    //       setState(() {
    //         doc_id = value;
    //         ACCOUNT_ID = value;
    //       })
    //     });
    //print(acc_id);
    // print("helloooooooooooooooooooooooooooooooooooooo");
    // print(doc_id);

    return Scaffold(
        body: pages[selectedPageIndex],
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.blueAccent),
            child: BottomNavigationBar(
              onTap: selectPage,
              unselectedItemColor: Colors.black87,
              backgroundColor: Colors.black87,
              currentIndex: selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    size: 30,
                  ),
                  title: Text('Chats'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.supervisor_account_rounded,
                    size: 30,
                  ),
                  title: Text('Contacts'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.public_sharp,
                    size: 30,
                  ),
                  title: Text('Discover'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_box,
                    size: 30,
                  ),
                  title: Text('Me'),
                )
              ],
            )
            // } else {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }

            ));

    // if (islandScape) return Scaffold(body: pieChart());
  }
}
