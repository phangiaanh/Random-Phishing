import 'package:equatable/equatable.dart';

class PhishingUrlHistoryEntity extends Equatable {
  final String id;
  final String name;

  PhishingUrlHistoryEntity({this.id, this.name});

  @override
  List<Object> get props => [id ?? '', name ?? ''];
}
