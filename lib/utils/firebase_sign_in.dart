import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser _user;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    _user = authResult.user;

    // Checking if email and name is null
    assert(_user.email != null);
    assert(_user.displayName != null);
    assert(_user.photoUrl != null);

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $_user';
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    await _auth.signOut();

    print("User Sign Out");
  }

  Future<bool> isLoggedIn() async {
    this._user = await _auth.currentUser();
    if (this._user == null) {
      return false;
    }
    return true;
  }
}
