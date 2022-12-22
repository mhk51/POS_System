import 'package:scanner_app/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Settings {
  @Id()
  int? id;
  bool showPrice;

  Settings({this.showPrice = false});
}
