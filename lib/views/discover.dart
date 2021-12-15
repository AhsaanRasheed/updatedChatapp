import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class discover extends StatefulWidget {
  const discover({Key key}) : super(key: key);
  @override
  State<discover> createState() => _discoverState();
}

class _discoverState extends State<discover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('GRID VIEW REFERENCE'),
      ),
      body: new GridView.extent(
        maxCrossAxisExtent: 150.0,
        mainAxisSpacing: 5.0,
        padding: const EdgeInsets.all(5.0),
        // children: _buildGridtiles(50),
      ),
    );
  }
}

// List<Widget> _buildGridtiles(numberOfTiles) {
//   List<Container> containers =
//       new List<Container>.generate(numberOfTiles, (int index) {
//     final imageName = index < 9
//         ? '../images/image0${index + 1}.jpg'
//         : '../images/image${index + 1}.jpg';
//     return new Container(
//       child: new Image.asset(
//         imageName,
//         fit: BoxFit.cover,
//       ),
//     );
//   });
//   return containers;
// }
