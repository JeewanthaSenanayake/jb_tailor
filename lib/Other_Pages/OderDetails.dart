import 'package:flutter/material.dart';
import 'package:jb_tailor/Other_Pages/cart.dart';
import 'DatabaseManager/DatabaseManager.dart';

class OderDetailsPage extends StatefulWidget {
  String uid, link, imgId;
  dynamic data;
  OderDetailsPage(
      {super.key,
      required this.uid,
      required this.link,
      required this.data,
      required this.imgId});

  @override
  State<StatefulWidget> createState() => _State(uid, link, data, imgId);
}

class _State extends State<OderDetailsPage> {
  String uid, link, imgId;
  dynamic data;
  _State(this.uid, this.link, this.data, this.imgId);

  bool Likeval = false;
  bool DisLikeval = false;
  int quantity = 1;
  String? selectedColour = 'White';
  String? selectedSize = 'M';

  void incresequantity() {
    setState(() {
      quantity++;
    });
  }

  void decreasequanitity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void likeState() {
    setState(() {
      Likeval = true;
      DisLikeval = false;
    });
  }

  void disLikeState() {
    setState(() {
      Likeval = false;
      DisLikeval = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double scrnwidth = MediaQuery.of(context).size.width;
    double scrnheight = MediaQuery.of(context).size.height;
    int like = data['like'];
    int disLike = data['disLike'];

    if (data['customer'][uid] == true) {
      likeState();
    } else if (data['customer'][uid] == false) {
      disLikeState();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Image.network(link, height: scrnwidth * 0.75),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: scrnwidth * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      color: Likeval ? Colors.teal : Colors.black,
                      onPressed: () async {
                        likeState();
                        if (data['customer'][uid] == false) {
                          //thats mean dislike
                          like++;
                          disLike--;
                          if (disLike < 0) {
                            disLike = 0;
                          }
                          await DatabaseManager().mensUpdateLikeDislike(
                              uid, false, imgId, true, data, like, disLike);
                        }
                        if (data['customer'][uid] == null) {
                          //not like yet
                          //  newe react user
                          like++;
                          await DatabaseManager().mensUpdateLikeDislike(
                              uid, true, imgId, true, data, like, disLike);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.thumb_down),
                      color: DisLikeval ? Colors.teal : Colors.black,
                      onPressed: () async {
                        disLikeState();
                        if (data['customer'][uid] == true) {
                          //thats mean like
                          like--;
                          disLike++;
                          if (like < 0) {
                            like = 0;
                          }
                          await DatabaseManager().mensUpdateLikeDislike(
                              uid, false, imgId, false, data, like, disLike);
                        }
                        if (data['customer'][uid] == null) {
                          //not dislike yet
                          //newe react user
                          disLike++;
                          await DatabaseManager().mensUpdateLikeDislike(
                              uid, true, imgId, false, data, like, disLike);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${data['name']}\n",
                      style: TextStyle(
                          fontSize: scrnwidth * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Rs: ${data['price']}",
                      style: TextStyle(
                          fontSize: scrnheight * 0.025,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text(
                          "\nFabric material",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text("\n - ${data['fabric_material']}"),
                      ],
                    ),
                    const Text(
                      "\nColour family",
                      style: TextStyle(color: Colors.grey),
                    ),
                    DropdownButton<String>(
                      items: [
                        DropdownMenuItem<String>(
                            value: 'Red',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'Red',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        DropdownMenuItem<String>(
                            value: 'Green',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'Green',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        DropdownMenuItem<String>(
                            value: 'Blue',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'Blue',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        DropdownMenuItem<String>(
                            value: 'Yellow',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'Yellow',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        DropdownMenuItem<String>(
                            value: 'White',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'White',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                        DropdownMenuItem<String>(
                            value: 'Black',
                            child: Container(
                              color: const Color.fromARGB(255, 85, 85, 85),
                              padding: const EdgeInsets.all(5),
                              width: 75,
                              child: const Text(
                                'Black',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                      onChanged: (value) {
                        // handle the change
                        setState(() {
                          selectedColour = value;
                        });
                      },
                      value: selectedColour,
                    ),
                    Row(
                      children: [
                        const Text(
                          "\nSize   - ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: scrnwidth * 0.025,
                        ),
                        DropdownButton(
                          value: selectedSize,
                          items: const [
                            DropdownMenuItem(
                              value: 'XS',
                              child: Text('XS'),
                            ),
                            DropdownMenuItem(
                              value: 'S',
                              child: Text('S'),
                            ),
                            DropdownMenuItem(
                              value: 'M',
                              child: Text('M'),
                            ),
                            DropdownMenuItem(
                              value: 'L',
                              child: Text('L'),
                            ),
                            DropdownMenuItem(
                              value: 'XL',
                              child: Text('XL'),
                            ),
                            DropdownMenuItem(
                              value: 'XXL',
                              child: Text('XXL'),
                            ),
                            DropdownMenuItem(
                              value: 'XXXL',
                              child: Text('XXXL'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(color: Colors.grey),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.black,
                        onPressed: () {
                          incresequantity();
                        },
                      ),
                      Text(
                        "$quantity",
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        color: Colors.black,
                        onPressed: () {
                          decreasequanitity();
                        },
                      ),
                    ]),
                    SizedBox(
                      height: scrnheight * 0.04,
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await DatabaseManager().addToCart(
                            uid,
                            imgId,
                            data['name'],
                            selectedColour!,
                            selectedSize!,
                            quantity,
                            data['price'].toString(),
                            link);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => cart(uid: uid)));
                      },
                      label: Text(
                        'Add cart',
                        style: TextStyle(fontSize: scrnheight * 0.02),
                      ),
                      icon: Icon(
                        Icons.shopping_cart,
                        size: scrnheight * 0.05,
                      ),
                      // <-- Text
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
