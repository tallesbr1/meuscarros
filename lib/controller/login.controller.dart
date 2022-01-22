import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user.dart';

class LoginController {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login() async {
    
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final FirebaseUser firebaseUser =
        (await _auth.signInWithCredential(credential)).user;

    var token = await firebaseUser.getIdToken();

  
    user.name = firebaseUser.displayName;
    user.email = firebaseUser.email;
    user.picture = firebaseUser.photoUrl;
    user.token = token.token;
    user.authHeaders = await googleUser.authHeaders;

    await gravarDadosUsuario();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
    user = new IUser();

    gravarDadosUsuario();
  }

  gravarDadosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', user.name);
    prefs.setString('user_email', user.email);
    prefs.setString('user_picture', user.picture);
    prefs.setString('authHeaders', user.authHeaders.toString());
  }

  static retornarDadosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    user.name = prefs.getString('user_name') == null
        ? ''
        : prefs.getString('user_name').toString();

    user.email = prefs.getString('user_email') == null
        ? ''
        : prefs.getString('user_email').toString();

    user.picture = prefs.getString('user_picture') == null
        ? ''
        : prefs.getString('user_picture').toString();


  }
 }
