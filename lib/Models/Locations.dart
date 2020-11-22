import 'dart:ffi';

import 'package:playground/Models/violation.dart';

class Location {
  String id, name, city, area;
  int activeViolation;
  Float long, lat;
  List<Violation> violations;
  Location(this.id, this.activeViolation, this.area, this.city, this.lat,
      this.long, this.name, this.violations);
}
