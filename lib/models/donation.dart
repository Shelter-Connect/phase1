import 'item.dart';

class Donation {
  String shelterId, volunteerId;
  String shelterName, shelterLocation;
  DateTime expectedDate;
  Map<String, List<Item>> items;

  Donation({this.shelterId, this.volunteerId, this.shelterName, this.shelterLocation, this.expectedDate, this.items});

  void addItem(Item item) {
    if (!items.containsKey(item.type)) {
      items[item.type] = List<Item>();
    }
    items[item.type].add(item);
  }
}