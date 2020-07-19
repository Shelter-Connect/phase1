class Item {
  String name, type;
  String specificDescription;
  int amount;

  Item({this.name, this.type, this.amount});

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'type': type,
      'specificDescription': specificDescription,
      'amount': amount,
    };
  }
}