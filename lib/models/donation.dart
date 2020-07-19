import 'item.dart';

class Donation {
  String shelterId, volunteerId;
  String shelterName, shelterLocation;
  DateTime expectedDate;
  Map<String, List<Item>> items;
  bool delivered;

  Donation({this.shelterId, this.volunteerId, this.shelterName, this.shelterLocation, this.expectedDate, this.items, this.delivered});

  void addItem(Item item) {
    if (!items.containsKey(item.type)) {
      items[item.type] = List<Item>();
    }
    items[item.type].add(item);
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'shelterId': shelterId,
      'volunteerId': volunteerId,
      'shelterName': shelterName,
      'shelterLocation': expectedDate,
      'items': items.map((type, itemList) => MapEntry(
        type,
        itemList.map((item) => item.toFirestoreMap()),
      )),
    };
  }
}