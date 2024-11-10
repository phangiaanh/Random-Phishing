import 'package:equatable/equatable.dart';

class AuthenticateUserEntity extends Equatable {
  final String username;
  final String password;
  final String role;

  AuthenticateUserEntity({required this.username,required this.password, required this.role});

  @override
  List<Object> get props => [username ?? "", role ?? ""];
}
