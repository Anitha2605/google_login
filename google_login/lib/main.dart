import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Google demo"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              signInWithGoogle();
            },
            child: Text("Login With Google")),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    // Initialize Firebase
    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String? name;
    String? imageUrl;

    // The `GoogleAuthProvider` can only be used while running on the web
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    User _user = User();
    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      _user = User(
          id: userCredential.user!.uid,
          displayname: userCredential.user!.displayName,
          email: userCredential.user!.email,
          imgUrl: userCredential.user!.photoURL);
    } catch (e) {
      print(e);
    }

    print(_user);

    return _user;
  }
}

class User {
  String? id;
  String? displayname;
  String? email;
  String? imgUrl;
  User({this.id, this.displayname, this.email, this.imgUrl});
}
