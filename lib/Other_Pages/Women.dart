import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:jb_tailor/Other_Pages/OderDetails.dart';

class WomenPage extends StatefulWidget {
  String uid;
  WomenPage({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() => _State(uid);
}

class _State extends State<WomenPage> {
  String uid;
  _State(this.uid);
  bool loading = true;

  @override
  void initState() {
    super.initState();
    TrendingImgUrl();
  }

  dynamic img1, img2, img3, img4, img5, img6, img7, img8, womenData;

  TrendingImgUrl() async {
    dynamic downloadUrl1 = await FirebaseStorage.instance
        .ref()
        .child("women/women_1.jpg")
        .getDownloadURL();
    dynamic downloadUrl2 = await FirebaseStorage.instance
        .ref()
        .child("women/women_2.jpg")
        .getDownloadURL();
    dynamic downloadUrl3 = await FirebaseStorage.instance
        .ref()
        .child("women/women_3.jpg")
        .getDownloadURL();
    dynamic downloadUrl4 = await FirebaseStorage.instance
        .ref()
        .child("women/women_4.jpg")
        .getDownloadURL();
    dynamic downloadUrl5 = await FirebaseStorage.instance
        .ref()
        .child("women/women_5.jpg")
        .getDownloadURL();
    dynamic downloadUrl6 = await FirebaseStorage.instance
        .ref()
        .child("women/women_6.jpg")
        .getDownloadURL();
    dynamic downloadUrl7 = await FirebaseStorage.instance
        .ref()
        .child("women/women_7.jpg")
        .getDownloadURL();
    dynamic downloadUrl8 = await FirebaseStorage.instance
        .ref()
        .child("women/women_8.jpg")
        .getDownloadURL();
    dynamic temp = await DatabaseManager().getDataFrom("women");
    setState(() {
      img1 = downloadUrl1;
      img2 = downloadUrl2;
      img3 = downloadUrl3;
      img4 = downloadUrl4;
      img5 = downloadUrl5;
      img6 = downloadUrl6;
      img7 = downloadUrl7;
      img8 = downloadUrl8;
      womenData = temp;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Women"),
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
                                      data: womenData['women_1'],
                                      imgId: "women_1",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img1",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_1']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_1']['price']}",
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
                              Text(" ${womenData['women_1']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_1']['disLike']}"),
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
                                      data: womenData['women_3'],
                                      imgId: "women_3",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img3",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_3']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_3']['price']}",
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
                              Text(" ${womenData['women_3']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_3']['disLike']}"),
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
                                      data: womenData['women_5'],
                                      imgId: "women_5",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img5",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_5']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_5']['price']}",
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
                              Text(" ${womenData['women_5']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_5']['disLike']}"),
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
                                      data: womenData['women_7'],
                                      imgId: "women_7",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img7",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_7']['name']}"),
                          ),

                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_7']['price']}",
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
                              Text(" ${womenData['women_7']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_7']['disLike']}"),
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
                                      data: womenData['women_2'],
                                      imgId: "women_2",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img2",
                              height: scrnwidth * 0.45,
                            ),
                          ),

                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_2']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_2']['price']}",
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
                              Text(" ${womenData['women_2']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_2']['disLike']}"),
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
                                      data: womenData['women_4'],
                                      imgId: "women_4",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img4",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_4']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_4']['price']}",
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
                              Text(" ${womenData['women_4']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_4']['disLike']}"),
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
                                      data: womenData['women_6'],
                                      imgId: "women_6",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img6",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_6']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_6']['price']}",
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
                              Text(" ${womenData['women_6']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_6']['disLike']}"),
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
                                      data: womenData['women_8'],
                                      imgId: "women_8",
                                      type: "women")));
                            },
                            child: Image.network(
                              "$img8",
                              height: scrnwidth * 0.45,
                            ),
                          ),
                          SizedBox(
                            width: scrnwidth * 0.45,
                            child: Text("\n${womenData['women_8']['name']}"),
                          ),
                          SizedBox(height: scrnheight * 0.0075),
                          Row(
                            children: [
                              Text(
                                "Rs: ${womenData['women_8']['price']}",
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
                              Text(" ${womenData['women_8']['like']}"),
                              SizedBox(width: scrnwidth * 0.02),
                              Icon(
                                Icons.thumb_down,
                                size: scrnheight * 0.015,
                              ),
                              Text(" ${womenData['women_8']['disLike']}"),
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
