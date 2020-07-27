import 'item.dart';

class Organization {
  String address, website, number, email, id, description, name;
  double distance;
  Map<String, List<Item>> requestedItems = Map();
  List<String> itemCategories = List();

  Organization(
      {this.address,
      this.website,
      this.email,
      this.id,
      this.description,
      this.name,
      this.distance,
      this.requestedItems,
      this.itemCategories,
      this.number});
}
