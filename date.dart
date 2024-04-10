import 'package:hive/hive.dart';
part 'date_g.dart';

@HiveType(typeId: 1)
class Add_date extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String explain;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String IN;
  @HiveField(4)
  DateTime datetime;
  Add_date(this.IN, this.amount, this.datetime, this.explain, this.name);
}
