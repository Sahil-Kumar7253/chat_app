import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  // instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current User
  User? getCurrentUser(){
    return _auth.currentUser;
  }
  //sign in
  Future<UserCredential> signInEmailPassword(String email, String password) async{
      try{
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        _firestore.collection("Users").doc(userCredential.user!.uid).set(
            {
              "name" : email.split('@')[0],
              "email": email,
              "uid": userCredential.user!.uid,
            }
        );
        return userCredential;
      } on FirebaseAuthException catch (e){
        throw Exception(e.code);
      }
  }

  //sign up
  Future<UserCredential> signUpwithEmailPassword(String email,password) async {
     try{
       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

       //saving user information
       _firestore.collection("Users").doc(userCredential.user!.uid).set(
         {
           "email": email,
           "uid": userCredential.user!.uid,
         }
       );

       return userCredential;
     }
     on FirebaseAuthException catch (e){
       throw Exception(e.code);
     }
  }

  //sign out
  Future<void> signOut()  async{
    return await _auth.signOut();
  }

}