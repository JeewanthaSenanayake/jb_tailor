import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'DatabaseManager/DatabaseManager.dart';
import 'OderDetails.dart';

class MenPage extends StatefulWidget {
  String uid;
  MenPage({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() => _State(uid);
}

class _State extends State<MenPage> {
  String uid;
  _State(this.uid);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    TrendingImgUrl();
  }

  dynamic img1, img2, img3, img4, img5, img6, img7, img8, menData;

  TrendingImgUrl() async {
    dynamic downloadUrl1 = await FirebaseStorage.instance
        .ref()
        .child("men/men_1.jpg")
        .getDownloadURL();
    dynamic downloadUrl2 = await FirebaseStorage.instance
        .ref()
        .child("men/men_2.jpg")
        .getDownloadURL();
    dynamic downloadUrl3 = await FirebaseStorage.instance
        .ref()
        .child("men/men_3.jpg")
        .getDownloadURL();
    dynamic downloadUrl4 = await FirebaseStorage.instance
        .ref()
        .child("men/men_4.jpg")
        .getDownloadURL();
    dynamic downloadUrl5 = await FirebaseStorage.instance
        .ref()
        .child("men/men_5.jpg")
        .getDownloadURL();
    dynamic downloadUrl6 = await FirebaseStorage.instance
        .ref()
        .child("men/men_6.jpg")
        .getDownloadURL();
    dynamic downloadUrl7 = await FirebaseStorage.instance
        .ref()
        .child("men/men_7.jpg")
        .getDownloadURL();
    dynamic downloadUrl8 = await FirebaseStorage.instance
        .ref()
        .child("men/men_8.jpg")
        .getDownloadURL();
    dynamic temp = await DatabaseManager().getDataFrom("men");
    setState(() {
      img1 = downloadUrl1;
      img2 = downloadUrl2;
      img3 = downloadUrl3;
      img4 = downloadUrl4;
      img5 = downloadUrl5;
      img6 = downloadUrl6;
      img7 = downloadUrl7;
      img8 = downloadUrl8;
      menData = temp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Men"),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //in first column img num as 1,3,5,7
                          //men 1
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img1,
                                      data: menData['men_1'],
                                      imgId: "men_1")));
                            },
                            child: Image.network(
                              "$img1",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_1']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_1']['price']}",
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
                              Text(" ${menData['men_1']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_1']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 3
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img3,
                                      data: menData['men_3'],
                                      imgId: "men_3")));
                            },
                            child: Image.network(
                              "$img3",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_3']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_3']['price']}",
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
                              Text(" ${menData['men_3']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_3']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 5
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img5,
                                      data: menData['men_5'],
                                      imgId: "men_5")));
                            },
                            child: Image.network(
                              "$img5",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_5']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_5']['price']}",
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
                              Text(" ${menData['men_5']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_5']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 7
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img7,
                                      data: menData['men_7'],
                                      imgId: "men_7")));
                            },
                            child: Image.network(
                              "$img7",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_7']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_7']['price']}",
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
                              Text(" ${menData['men_7']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_7']['disLike']}"),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        //in second column img num as 2,4,6,8
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //men 2
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img2,
                                      data: menData['men_2'],
                                      imgId: "men_2")));
                            },
                            child: Image.network(
                              "$img2",
                              height: scrnwidth * 0.45,
                            ),
                          ),

                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_2']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_2']['price']}",
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
                              Text(" ${menData['men_2']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_2']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 4
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img4,
                                      data: menData['men_4'],
                                      imgId: "men_4")));
                            },
                            child: Image.network(
                              "$img4",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_4']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_4']['price']}",
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
                              Text(" ${menData['men_4']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_4']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 6
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img6,
                                      data: menData['men_6'],
                                      imgId: "men_6")));
                            },
                            child: Image.network(
                              "$img6",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_6']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_6']['price']}",
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
                              Text(" ${menData['men_6']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_6']['disLike']}"),
                            ],
                          ),
                          SizedBox(height: scrnheight * 0.02),
                          //men 8
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => OderDetailsPage(
                                      uid: uid,
                                      link: img8,
                                      data: menData['men_8'],
                                      imgId: "men_8")));
                            },
                            child: Image.network(
                              "$img8",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${menData['men_8']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${menData['men_8']['price']}",
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
                              Text(" ${menData['men_8']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${menData['men_8']['disLike']}"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
    );
  }
}
