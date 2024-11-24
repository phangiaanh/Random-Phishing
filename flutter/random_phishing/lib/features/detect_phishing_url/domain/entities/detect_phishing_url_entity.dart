import 'package:equatable/equatable.dart';

class DetectPhishingUrlEntity extends Equatable {
  final String url;
  final bool isPhishing;
  final int detectTurn;
  final List<String> reasons;

  DetectPhishingUrlEntity(
      {required this.url,
      required this.isPhishing,
      required this.detectTurn,
      required this.reasons});

  @override
  List<Object> get props => [url ?? ""];
}
