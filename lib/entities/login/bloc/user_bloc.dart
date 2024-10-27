import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zanatlija_app/data/services/firestore_service.dart';
import 'package:zanatlija_app/data/models/user.dart';
import 'package:zanatlija_app/navigation/routes.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirestoreService service;

  UserBloc(this.service) : super(const UserState()) {
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
      final user = await service.login(event.phoneNumber, event.password);
      if (user != null) {
        final newState = state.copyWith(user: user);
        emit(newState);
        AutoRouter.of(event.context).replaceNamed(kHomeRoute);
      } else {}
      AutoRouter.of(event.context).replaceNamed(kHomeRoute);
    } catch (loginError) {
      if (loginError == LoginError.userNotFound) {
        ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text('Uneli ste pogresan broj telefona')));
      } else if (loginError == LoginError.passwordIsWrong) {
        ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text('Uneli ste pogresnu sifru')));
      } else if (loginError == LoginError.unknownError) {
        ScaffoldMessenger.of(event.context).showSnackBar(const SnackBar(
            content: Text('Nepoznata greska prilikom loginovanja')));
      }
    }
  }
}
