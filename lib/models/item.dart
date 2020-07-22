class Item {
  String name, category;
  String specificDescription;
  int amount;

  Item({this.name, this.category, this.amount});

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'category': category,
      'specificDescription': specificDescription,
      'amount': amount,
    };
  }
}
