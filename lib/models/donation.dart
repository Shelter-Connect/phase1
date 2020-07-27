import 'item.dart';

class Donation {
  String volunteerId, organizationId, donationId;
  DateTime date;
  List<Item> items = [];

  Donation({
    this.volunteerId,
    this.organizationId,
    this.donationId,
    this.items,
  });

  Donation.clone(Donation donation) {
    this.volunteerId = donation.volunteerId;
    this.date = donation.date;
    this.date = this.date;
    this.donationId = donationId;
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
