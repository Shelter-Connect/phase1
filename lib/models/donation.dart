import 'item.dart';

class Donation {
  String volunteerId, organizationId;
  DateTime date;
  List<Item> items = [];

  Donation({
    this.volunteerId,
    this.organizationId,
    this.items,
  });

  Donation.clone(Donation donation) {
    this.volunteerId = donation.volunteerId;
    this.date = donation.date;
    this.date = this.date;
    for (Item item in donation.items) {
      this.items.add(Item.clone(item: item));
    }
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'volunteerId': volunteerId,
      'organizationId': organizationId,
      'date': date,
      'items': items.map((item) => item.toFirestoreMap()).toList(),
    };
  }
}
