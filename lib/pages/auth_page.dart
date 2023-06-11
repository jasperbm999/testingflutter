// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'home_page.dart';
// import 'login_page.dart';

// class AuthPage extends StatelessWidget {
//   const AuthPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Display a loading indicator if the authentication state is still loading
//           return CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           // User is authenticated, navigate to the HomePage
//           return HomePage();
//         } else {
//           // User is not authenticated, navigate to the LoginPage
//           return LoginPage();
//         }
//       },
//     );
//   }
// }
