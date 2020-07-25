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
}
