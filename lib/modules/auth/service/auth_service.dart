import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


mixin AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // 1. Email & Password Sign In
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Email login failed");
    }
  }

  // 1b. Email & Password Sign Up
  Future<UserCredential?> signUpWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Email signup failed");
    }
  }


  // 2a. Phone Auth: Send OTP
  Future<void> sendPhoneOtp(
    String phoneNumber,
    Function(String) onCodeSent,
  ) async {
    final completer = Completer<void>();
    await _auth.verifyPhoneNumber(
      phoneNumber:
          phoneNumber, // Make sure this includes the country code (e.g., +92)
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolution on Android
        await _auth.signInWithCredential(credential);
        if (!completer.isCompleted) completer.complete();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (!completer.isCompleted) completer.completeError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
        if (!completer.isCompleted) completer.complete();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (!completer.isCompleted) completer.complete();
      },
    );
    return completer.future;
  }


  // 2b. Phone Auth: Verify OTP
  Future<UserCredential?> verifyPhoneOtp(
    String verificationId,
    String smsCode,
  ) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Invalid OTP code");
    }
  }

  // 3. Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // 1. Initialize with your Web Client ID
      // Replace the string below with your Web client ID from the Firebase Console!
      // This is REQUIRED on Android to prevent the clientConfigurationError.
      await _googleSignIn.initialize(
        serverClientId: '229914101126-q63ai49is426jrke810m38vceanagdc5.apps.googleusercontent.com',
      );

      // 2. Authenticate the user (v7 uses 'authenticate' instead of 'signIn')
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        return null; // The user closed the Google sign-in dialog
      }

      // 3. Obtain the auth details (This gets the idToken needed for Firebase)
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // 4. Create a new credential for Firebase
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken:
            googleAuth.idToken, // Use idToken for server-side verification
        idToken: googleAuth.idToken,
      );

      // 5. Sign in to Firebase
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Google Sign-In failed: $e");
    }
  }

  // 4. Anonymous (Guest)
  Future<UserCredential?> signInAsGuest() async {
    try {
      return await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Guest login failed");
    }
  }
}
