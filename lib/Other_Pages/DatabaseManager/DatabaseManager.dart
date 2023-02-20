import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final profileList = FirebaseFirestore.instance.collection("accountInfo");

  Future<void> createUserAccount(
      String name, String address, String email, String uid) async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .set({"oderID": 0});
    return await profileList
        .doc(uid)
        .set({'name': name, 'address': address, 'email': email});
  }

  Future<dynamic> getUserDatails(String uid) async {
    final userInfo =
        FirebaseFirestore.instance.collection("accountInfo").doc(uid);
    dynamic UserDatils;
    try {
      await userInfo.get().then((QuerySnapshot) {
        UserDatils = QuerySnapshot.data();
      });
      return UserDatils;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //get men, women, kids data
  Future<dynamic> getDataFrom(String type) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection(type);

    QuerySnapshot snapshot = await collection.get();
    List<DocumentSnapshot> documents = snapshot.docs;

    Map<String, dynamic> data = Map<String, dynamic>();

    for (var document in documents) {
      data.addAll({document.reference.id: document.data()});
    }
    return data;
  }

  Future<dynamic> updateNameAddress(
      String value, String selector, String uid) async {
    return await profileList.doc(uid).update({selector: value});
  }

  //Update like dislike men , women, kids data
  Future<void> mensUpdateLikeDislike(String uid, bool allReadyreact, String doc,
      bool likeOrDis, dynamic data, int like, int disLike, String type) async {
    //true for like in likeOrDis
    // allReadyreact == true means newe react user

    final ref = FirebaseFirestore.instance.collection(type).doc(doc);
    data['customer'].addAll({uid: likeOrDis});

    if (allReadyreact) {
      if (likeOrDis) {
        await ref.update({"like": like, "customer": data['customer']});
      } else {
        await ref.update({"disLike": disLike, "customer": data['customer']});
      }
    } else {
      if (likeOrDis) {
        await ref.update(
            {"like": like, "disLike": disLike, "customer": data['customer']});
      } else {
        await ref.update(
            {"disLike": disLike, "like": like, "customer": data['customer']});
      }
    }

    // return await ref.update({"customer": data['customer']});
  }

  //Add cart
  Future<dynamic> addToCart(
      String uid,
      String oderID,
      String oderName,
      String colour,
      String size,
      int quantity,
      String price,
      String link,
      String type) async {
    final cartList = FirebaseFirestore.instance.collection("cart").doc(uid);
    dynamic itemId;
    try {
      await cartList.get().then((QuerySnapshot) {
        itemId = QuerySnapshot.data();
      });
    } catch (e) {
      print(e.toString());
    }

    dynamic newItemId = itemId["oderID"] + 1;
    dynamic data = {
      'oderId': "$type/$oderID.jpg",
      'oderName': oderName,
      'colour': colour,
      'size': size,
      'quantity': quantity,
      'isPending': 1,
      'price': price,
      'link': link,
    };

    dynamic oder = {
      "oderID": newItemId,
      newItemId.toString(): data,
    };
    return await cartList.update(oder);
  }

  //get data from cart
  Future<dynamic> getFromCart(String uid) async {
    final cartList = FirebaseFirestore.instance.collection("cart").doc(uid);
    dynamic item;
    try {
      await cartList.get().then((QuerySnapshot) {
        item = QuerySnapshot.data();
      });
      return item;
    } catch (e) {
      print(e.toString());
    }
  }

  //delete item from cart
  Future<dynamic> deleteItemFromCart(
      String uid, int oderId, dynamic data) async {
    final cartList = FirebaseFirestore.instance.collection("cart").doc(uid);
    data["isPending"] = 0;
    dynamic oder = {
      oderId.toString(): data,
    };
    return await cartList.update(oder);
  }

  //For Admin

  //Tel No
  Future<dynamic> adminTelNo() async {
    final adminInfo =
        FirebaseFirestore.instance.collection("adminData").doc("telNo");
    dynamic AdminDatils;
    try {
      await adminInfo.get().then((QuerySnapshot) {
        AdminDatils = QuerySnapshot.data();
      });

      return AdminDatils;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
