import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'OderDetails.dart';

class NormalOder extends StatefulWidget {
  String uid, type;
  NormalOder({super.key, required this.uid, required this.type});

  @override
  State<NormalOder> createState() => _NormalOderState(uid, type);
}

class _NormalOderState extends State<NormalOder> {
  String uid, type;
  _NormalOderState(this.uid, this.type);
  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeatails();
  }

  double scrnwidth = 0;
  double scrnheight = 0;
  List<Container> items = [];
  List<Container> leftCol = [];
  List<Container> rigthCol = [];
  List<Column> towColumns = [];
  //data
  getDeatails() async {
    dynamic Deatails = await DatabaseManager().getDocuments(type);
    setState(() {
      for (dynamic data in Deatails) {
        dynamic itemData = data.data();
        items.add(Container(
            child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OderDetailsPage(
                        uid: uid,
                        link: itemData['url'],
                        data: itemData,
                        imgId: itemData['imgId'],
                        type: type)));
              },
              // child: Image.network(
              //   "${itemData['url']}",
              //   height: scrnwidth * 0.45,
              // ),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading/loading.jpg'),
                image: NetworkImage("${itemData['url']}"),
                height: scrnwidth * 0.45,
              ),
            ),
            SizedBox(
              width: scrnwidth * 0.45,
              child: Text("\n${itemData['name']}"),
            ),
            SizedBox(height: scrnheight * 0.0075),
            Row(
              children: [
                Text(
                  "Rs: ${itemData['price']}",
                  style: TextStyle(
                      fontSize: scrnheight * 0.02,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: scrnwidth * 0.05),
                Icon(
                  Icons.thumb_up,
                  size: scrnheight * 0.015,
                ),
                Text(" ${itemData['like']}"),
                SizedBox(width: scrnwidth * 0.02),
                Icon(
                  Icons.thumb_down,
                  size: scrnheight * 0.015,
                ),
                Text(" ${itemData['disLike']}"),
              ],
            ),
            SizedBox(height: scrnheight * 0.02),
          ],
        )));
      }
      int len = items.length;
      for (int i = 0; i < len; i++) {
        if (i <= (len / 2).toInt() - 1) {
          rigthCol.add(items[i]);
        } else {
          leftCol.add(items[i]);
        }
      }
      towColumns.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: leftCol));
      towColumns.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: rigthCol));
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      scrnwidth = MediaQuery.of(context).size.width;
      scrnheight = MediaQuery.of(context).size.height;
    });

    // to convert type sting first letter to capital
    String capitalize(String input) {
      if (input.isEmpty) {
        return input;
      }
      return input[0].toUpperCase() + input.substring(1);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(capitalize(type)),
        ),
        body: SingleChildScrollView(
          child: loading
              ? Container(
                  alignment: Alignment.center,
                  height: scrnheight,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ))
              : Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: towColumns)),
        ));
  }
}
