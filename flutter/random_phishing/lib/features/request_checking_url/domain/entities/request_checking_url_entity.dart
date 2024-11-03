import 'package:equatable/equatable.dart';

class RequestCheckingUrlEntity extends Equatable {
  final String id;
  final String name;

  RequestCheckingUrlEntity({this.id, this.name});

  @override
  List<Object> get props => [id ?? '', name ?? ''];
}
