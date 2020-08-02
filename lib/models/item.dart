class Item {
  String name, category, specificDescription;
  int amount;

  Item({this.name, this.category, this.amount, this.specificDescription});

  Item.clone(Item item) {
    this.name = item.name;
    this.category = item.category;
    this.specificDescription = item.specificDescription;
    this.amount = item.amount;
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'category': category,
      'specificDescription': specificDescription,
      'amount': amount,
    };
  }
}
