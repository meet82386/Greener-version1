import 'package:flutter/material.dart';
import 'image_data.dart';

class About_Tree extends StatefulWidget {
  About_Tree({Key? key}) : super(key: key);

  @override
  _About_TreeState createState() => _About_TreeState();
}

class _About_TreeState extends State<About_Tree> {
  int _crossAxisCount = 2;

  double _aspectRatio = 1.5;

  ViewType _viewType = ViewType.grid;

  List<ImageData> itemList = getImageDataList();

  static List<ImageData> getImageDataList() {
    return [
      ImageData(
          'https://2.imimg.com/data2/VA/FA/MY-2114665/neem-tree-500x500.jpg',
          'Neem Tree',
          'O2-260 PPYP   CO2-48 PPYA'),
      ImageData(
          'https://smedia2.intoday.in/indiatoday/images/stories/2017November/peepal-mos_110917010639.jpg',
          'Peeple Tree',
          'O2-260 PPYP   CO2-48 PPYA')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          // centerTitle: true,
          title: const Text("About Tree"),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(
                  _viewType == ViewType.list ? Icons.grid_on : Icons.view_list),
              onPressed: () {
                if (_viewType == ViewType.list) {
                  _crossAxisCount = 2;
                  _aspectRatio = 1.5;
                  _viewType = ViewType.grid;
                } else {
                  _crossAxisCount = 1;
                  _aspectRatio = 5;
                  _viewType = ViewType.list;
                }
                setState(() {});
              },
            )
          ],
        ),
        body: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.green[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 0),
                  // color: Colors.black12.withOpacity(0.5),
                  // offset: Offset(0.0, 0.0), //(x,y)
                  // blurRadius: 6.0,
                ),
              ],
            ),
            child: Container(
                margin: const EdgeInsets.all(10),
                child: GridView.count(
                  crossAxisCount: _crossAxisCount,
                  childAspectRatio: _aspectRatio,
                  children: itemList.map((ImageData imageData) {
                    return getGridItem(imageData);
                  }).toList(),
                ))));
  }

  GridTile getGridItem(ImageData imageData) {
    return GridTile(
      child: (_viewType == ViewType.list)
          ? Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageData.path,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        imageData.title,
                        style: TextStyle(fontSize: 24, color: Colors.white),
                        // style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        imageData.information,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        // style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageData.path,
                        ))),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  imageData.title,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
    );
  }
}

enum ViewType { grid, list }

// import 'package:flutter/material.dart';
//
// class About_Tree extends StatelessWidget {
//   const About_Tree({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.greenAccent.shade200,
//       appBar: AppBar(
//         title: Text('Greener'),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//         child: Text(
//           'Information of Tree',
//           style: TextStyle(fontSize: 40),
//         ),
//       ),
//     );
//   }
// }
