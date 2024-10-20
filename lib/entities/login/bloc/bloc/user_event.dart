part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}
