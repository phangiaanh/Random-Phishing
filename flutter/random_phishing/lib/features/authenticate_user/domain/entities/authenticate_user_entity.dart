import 'package:equatable/equatable.dart';

class AuthenticateUserEntity extends Equatable {
  final String id;
  final String name;

  AuthenticateUserEntity({this.id, this.name});

  @override
  List<Object> get props => [id ?? '', name ?? ''];
}
