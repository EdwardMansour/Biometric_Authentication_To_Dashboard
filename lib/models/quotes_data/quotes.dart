import 'package:equatable/equatable.dart';

class Quotes extends Equatable {
  final String q;
  final String a;
  final String h;
  Quotes({
    this.q,
    this.a,
    this.h,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) => Quotes(
        q: json["q"].toString(),
        a: json["a"].toString(),
        h: json["h"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "a": a,
        "h": h,
      };

  @override
  // TODO: implement props
  List<Object> get props => [q, a, h];
}
