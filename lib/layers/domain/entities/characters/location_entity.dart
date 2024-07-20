import 'package:equatable/equatable.dart';

class LocationEntity with EquatableMixin {
  LocationEntity({
    this.name,
    this.url,
  });

  final String? name;
  final String? url;

  @override
  List<Object?> get props => [
        name,
        url,
      ];
}
