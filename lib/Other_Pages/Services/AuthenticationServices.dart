import 'package:firebase_auth/firebase_auth.dart';
import 'package:jb_tailor/Other_Pages/DatabaseManager/DatabaseManager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get current user

  String getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user?.uid;
    return uid.toString();
  }

  //google

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    var _user = authResult.user;

    print("User Name: ${_user!.displayName}");
    print("User Email ${_user.email}");

    //is in data base
    dynamic isInDataBase = await DatabaseManager().getUserDatails(_user.uid);

    if (isInDataBase == null) {
      //Add data to data base
      await DatabaseManager().createUserAccount(_user.displayName.toString(),
          "address", _user.email.toString(), _user.uid);
    }

    return _user;
  }

  //registration

  Future createNewUser(String email, String password, String fname,
      String lname, String address) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Add data to data base
      await DatabaseManager()
          .createUserAccount("$fname $lname", address, email, result.user!.uid);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

  //singin

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user!.uid;
    } catch (e) {
      print(e.toString());
    }
  }

  //sinout
  
  Future singOut() async {
    try {
      await _googleSignIn.signOut();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
