import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:jb_tailor/Other_Pages/OderDetails.dart';

class KidsPage extends StatefulWidget {
  String uid;
  KidsPage({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() => _State(uid);
}

class _State extends State<KidsPage> {
  String uid;
  _State(this.uid);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    TrendingImgUrl();
  }

  dynamic img1, img2, img3, img4, img5, img6, img7, img8, kidsData;

  TrendingImgUrl() async {
    dynamic downloadUrl1 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_1.jpg")
        .getDownloadURL();
    dynamic downloadUrl2 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_2.jpg")
        .getDownloadURL();
    dynamic downloadUrl3 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_3.jpg")
        .getDownloadURL();
    dynamic downloadUrl4 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_4.jpg")
        .getDownloadURL();
    dynamic downloadUrl5 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_5.jpg")
        .getDownloadURL();
    dynamic downloadUrl6 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_6.jpg")
        .getDownloadURL();
    dynamic downloadUrl7 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_7.jpg")
        .getDownloadURL();
    dynamic downloadUrl8 = await FirebaseStorage.instance
        .ref()
        .child("kids/kids_8.jpg")
        .getDownloadURL();
    dynamic temp = await DatabaseManager().getDataFrom("kids");
    setState(() {
      img1 = downloadUrl1;
      img2 = downloadUrl2;
      img3 = downloadUrl3;
      img4 = downloadUrl4;
      img5 = downloadUrl5;
      img6 = downloadUrl6;
      img7 = downloadUrl7;
      img8 = downloadUrl8;
      kidsData = temp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kids"),
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
                                      data: kidsData['kids_1'],
                                      imgId: "kids_1",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img1",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_1']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_1']['price']}",
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
                              Text(" ${kidsData['kids_1']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_1']['disLike']}"),
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
                                      data: kidsData['kids_3'],
                                      imgId: "kids_3",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img3",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_3']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_3']['price']}",
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
                              Text(" ${kidsData['kids_3']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_3']['disLike']}"),
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
                                      data: kidsData['kids_5'],
                                      imgId: "kids_5",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img5",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_5']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_5']['price']}",
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
                              Text(" ${kidsData['kids_5']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_5']['disLike']}"),
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
                                      data: kidsData['kids_7'],
                                      imgId: "kids_7",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img7",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_7']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_7']['price']}",
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
                              Text(" ${kidsData['kids_7']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_7']['disLike']}"),
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
                                      data: kidsData['kids_2'],
                                      imgId: "kids_2",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img2",
                              height: scrnwidth * 0.45,
                            ),
                          ),

                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_2']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_2']['price']}",
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
                              Text(" ${kidsData['kids_2']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_2']['disLike']}"),
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
                                      data: kidsData['kids_4'],
                                      imgId: "kids_4",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img4",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_4']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_4']['price']}",
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
                              Text(" ${kidsData['kids_4']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_4']['disLike']}"),
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
                                      data: kidsData['kids_6'],
                                      imgId: "kids_6",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img6",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_6']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_6']['price']}",
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
                              Text(" ${kidsData['kids_6']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_6']['disLike']}"),
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
                                      data: kidsData['kids_8'],
                                      imgId: "kids_8",
                                      type: "kids")));
                            },
                            child: Image.network(
                              "$img8",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${kidsData['kids_8']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${kidsData['kids_8']['price']}",
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
                              Text(" ${kidsData['kids_8']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${kidsData['kids_8']['disLike']}"),
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
