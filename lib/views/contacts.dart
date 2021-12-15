// import 'package:chat_app/authentication/Registration.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/services/auth.dart';
import 'package:flutter/material.dart';
class Profile_data {
  String LastName;
  String firstName;
  String phoneNumber;
  Profile_data(this.LastName, this.firstName, this.phoneNumber);
}

class contacts extends StatefulWidget {
  const contacts({Key key}) : super(key: key);
  @override
  _contactsState createState() => _contactsState();

// class owner extends StatelessWidget {
//   const owner({Key key}) : super(key: key);
//   @override
//   _ownerState createState() => _ownerState();
}

class _contactsState extends State<contacts> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Profile'),
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              color: Colors.blue[50],
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w600/library/wp-content/uploads/2015/03/adjust-tie.jpeg"),
                        radius: 50,
                      ),
                      Positioned(
                          bottom: 15,
                          left: 35,
                          child: RawMaterialButton(
                            onPressed: () {},

                            // elevation: 2.0,
                            fillColor: Colors.blueAccent,

                            child: Icon(
                              Icons.edit,
                              size: 25,
                            ),
                            padding: EdgeInsets.all(5),
                            shape: CircleBorder(),
                          ))
                      // FloatingActionButton(

                      //   mini: true,
                      //   onPressed: (){},
                      //   child: Icon(Icons.edit), )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Ahsan Rasheed',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.005,
                  ),
                  Text('+92 303 6545291')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      FlatButton(
                        onPressed: () {},
                        child: ListTile(
                            leading: Icon(
                              Icons.chat,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Chats')),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Account')),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: ListTile(
                            leading: Icon(
                              Icons.notifications,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Notifications')),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: ListTile(
                            leading: Icon(
                              Icons.chat,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Invite a friend')),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: ListTile(
                            leading: Icon(
                              Icons.help_outline_outlined,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Help')),
                      ),
                      FlatButton(
                        onPressed: () {
                          AuthService().signOut();
                          Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Authenticate()));
                          
                        },
                        child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.blueAccent,
                            ),
                            title: Text('Log out')),
                      ),
                    ],
                  )),
            )
          ],
        ),
      );
}
