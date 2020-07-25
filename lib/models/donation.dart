import 'item.dart';

class Donation {
  String volunteerId, organizationId;
  DateTime date;
  List<Item> items;

  Donation({
    this.volunteerId,
    this.organizationId,
    this.items,
  });
}
