import 'item.dart';

class Donation {
  String volunteerId, organizationId;
  DateTime date;
  Map<String, List<Item>> items = Map();

  Donation({
    this.volunteerId,
    this.organizationId,
    this.items,
  });

  Donation.clone(Donation donation) {
    this.volunteerId = donation.volunteerId;
    this.date = donation.date;
    this.date = this.date;
    for (List<Item> itemList in donation.items.values) {
      List.copyRange(this.items[donation.items.keys.firstWhere((list) => donation.items[list] == itemList)], 0, itemList);
    }
  }
}
