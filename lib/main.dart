import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zanatlija_app/data/services/firestore_service.dart';
import 'package:zanatlija_app/entities/login/bloc/bloc/user_bloc.dart';
import 'package:zanatlija_app/zanatlija.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyClEwWIs01DXcSywtFRM-Zk4WePTbFD6ws",
      appId: "1:737907302079:android:97a20ad7ab1e4fda0e700a",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "zanatlija-6431f",
    ),
  );
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final FirestoreService firestoreService = FirestoreService(firestoreInstance);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<UserBloc>(create: (_) => UserBloc(firestoreService)),
    ],
    child: const ZanatlijaApp(),
  ));
}
