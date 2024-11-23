import 'package:equatable/equatable.dart';

class ListPhishingHistoryEntity {
  final List<PhishingHistoryItem> list;

  ListPhishingHistoryEntity({required this.list});
}

class PhishingHistoryItem extends Equatable {
  final String username;
  final String url;
  final bool isPhishing;
  final DateTime time;

  PhishingHistoryItem(
      {required this.username,
      required this.url,
      required this.isPhishing,
      required this.time});

  @override
  List<Object> get props => [url, username, isPhishing, time];
}
