import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanatlija_app/data/services/firestore_service.dart';
import 'package:zanatlija_app/entities/login/models/user.dart';
import 'package:zanatlija_app/navigation/routes.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirestoreService service;

  UserBloc(this.service) : super(UserInitial()) {
    on<CreateUserEvent>(_createUser);
    on<LoginUserEvent>(_loginUser);
  }

  Future<void> _createUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    try {
      await service.createUser(event.user);
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  Future<void> _loginUser(LoginUserEvent event, Emitter<UserState> emit) async {
    try {
      final loginError = await service.login(event.phoneNumber, event.password);
      if (loginError != null) {
        // ignore: use_build_context_synchronously
        if (loginError == LoginError.userNotFound) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text('Uneli ste pogresan broj telefona')));
          return;
        } else if (loginError == LoginError.passwordIsWrong) {
          ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(content: Text('Uneli ste pogresnu sifru')));
          return;
        } else if (loginError == LoginError.unknownError) {
          ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
              content: Text('Nepoznata greska prilikom loginovanja')));
          return;
        }
      }
      AutoRouter.of(event.context).replaceNamed(kHomeRoute);
    } catch (e) {
      debugPrint('Error $e');
    }
  }
}
