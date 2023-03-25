import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager {
  final profileList = FirebaseFirestore.instance.collection("accountInfo");

  Future<void> createUserAccount(
      String name, String address, String email, String uid) async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(uid)
        .set({"oderID": 0});
    await FirebaseFirestore.instance
        .collection("Oder")
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
      "oderType": "normal",
      'oderId': "$type/$oderID.jpg",
      'oderName': oderName,
      'colour': colour,
      'size': size,
      'quantity': quantity,
      'isPending': 1,
      'price': price,
      'link': link,
      'status': "not yet pay"
    };

    dynamic oder = {
      "oderID": newItemId,
      newItemId.toString(): data,
    };
    return await cartList.update(oder);
  }

  //Add custom oders
  Future<dynamic> addCustomOderStep1(String uid, dynamic basicData) async {
    final customOderList =
        FirebaseFirestore.instance.collection("Oder").doc(uid);
    dynamic itemId;
    try {
      await customOderList.get().then((QuerySnapshot) {
        itemId = QuerySnapshot.data();
      });
    } catch (e) {
      print(e.toString());
    }

    dynamic newItemId = itemId["oderID"] + 1;
    dynamic data = {
      "oderType": "custom",
      "isPending": 1,
      'price': "Pending",
      'status': "not yet pay",
      "basicData": basicData,
    };

    dynamic oder = {
      "oderID": newItemId,
      newItemId.toString(): data,
    };
    return await customOderList.update(oder);
  }

  Future<dynamic> addCustomOderStep2(
      String uid, dynamic basicData, dynamic dataMeasurements) async {
    final customOderList =
        FirebaseFirestore.instance.collection("Oder").doc(uid);
    dynamic itemId;
    try {
      await customOderList.get().then((QuerySnapshot) {
        itemId = QuerySnapshot.data();
      });
    } catch (e) {
      print(e.toString());
    }

    dynamic newItemId = itemId["oderID"] + 1;
    dynamic data = {
      "oderType": "custom",
      "isPending": 1,
      'price': "Pending",
      'status': "not yet pay",
      "basicData": basicData,
      "dataMeasurements": dataMeasurements
    };

    dynamic oder = {
      "oderID": newItemId,
      newItemId.toString(): data,
    };
    return await customOderList.update(oder);
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

  //get data from oder
  Future<dynamic> getFromOder(String uid) async {
    final cartList = FirebaseFirestore.instance.collection("Oder").doc(uid);
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

  //cart payment sucsessful
  Future<dynamic> cartToOder(
      dynamic cartData, String oderID, String uid) async {
    await deleteItemFromCart(uid, int.parse(oderID), cartData);
    final customOderList =
        FirebaseFirestore.instance.collection("Oder").doc(uid);
    dynamic itemId;
    try {
      await customOderList.get().then((QuerySnapshot) {
        itemId = QuerySnapshot.data();
      });
    } catch (e) {
      print(e.toString());
    }
    dynamic newItemId = itemId["oderID"] + 1;

    cartData["isPending"] = 2;
    cartData["status"] = "Rapping your oder";
    dynamic oder = {
      "oderID": newItemId,
      newItemId.toString(): cartData,
    };
    return await customOderList.update(oder);
  }

  //custom oder payment sucsessful
  Future<dynamic> customOderPaymentSucsessful(
      dynamic cartData, dynamic meshData, String oderID, String uid) async {
    final customOderList =
        FirebaseFirestore.instance.collection("Oder").doc(uid);

    cartData["isPending"] = 2;
    cartData["status"] = "Working with your oder";
    cartData["dataMeasurements"] = meshData;
    dynamic oder = {
      oderID: cartData,
    };
    return await customOderList.update(oder);
  }

  //oder resived
  Future<dynamic> oderResived(
      dynamic cartData, String oderID, String uid) async {
    final customOderList =
        FirebaseFirestore.instance.collection("Oder").doc(uid);

    cartData["isPending"] = 4;
    cartData["status"] = "Oder Resived";
    dynamic oder = {
      oderID: cartData,
    };
    return await customOderList.update(oder);
  }

  //get all data
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getDocuments(
      String type) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection(type).get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docData = [];

    if (snapshot.docs.isNotEmpty) {
      for (final QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshot.docs) {
        docData.add(document);
      }
    } else {
      print('No documents found.');
    }
    return docData;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> trending() async {
    //men
    final QuerySnapshot<Map<String, dynamic>> snapshotMen =
        await FirebaseFirestore.instance.collection("men").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docDataMen = [];

    if (snapshotMen.docs.isNotEmpty) {
      for (final QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshotMen.docs) {
        docDataMen.add(document);
      }
    } else {
      print('No documents found.');
    }

    //women
    final QuerySnapshot<Map<String, dynamic>> snapshotWomen =
        await FirebaseFirestore.instance.collection("women").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docDataWomen = [];

    if (snapshotWomen.docs.isNotEmpty) {
      for (final QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshotWomen.docs) {
        docDataWomen.add(document);
      }
    } else {
      print('No documents found.');
    }

    //kids
    final QuerySnapshot<Map<String, dynamic>> snapshotKids =
        await FirebaseFirestore.instance.collection("kids").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docDataKids = [];

    if (snapshotKids.docs.isNotEmpty) {
      for (final QueryDocumentSnapshot<Map<String, dynamic>> document
          in snapshotKids.docs) {
        docDataKids.add(document);
      }
    } else {
      print('No documents found.');
    }

    //combine 3 list
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docDataAll = [];
    docDataAll.addAll(docDataMen);
    docDataAll.addAll(docDataWomen);
    docDataAll.addAll(docDataKids);

    //sort high to low
    docDataAll.sort((b, a) => a.data()['like'].compareTo(b.data()['like']));

    return docDataAll;
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
