import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanatlija_app/data/services/firestore_service.dart';
import 'package:zanatlija_app/entities/login/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirestoreService service;

  UserBloc(this.service) : super(UserInitial()) {
    on<CreateUserEvent>(_createUser);
  }

  Future<void> _createUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    try {
      await service.createUser(event.user);
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
