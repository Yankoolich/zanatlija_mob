part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginUserEvent extends UserEvent {
  final BuildContext context;
  final String phoneNumber;
  final String password;
  LoginUserEvent(
    this.context, {
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [context, phoneNumber, password];
}
