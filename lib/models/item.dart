class Item {
  String name, category, specificDescription, itemUnit;
  int amount;

  Item({this.name, this.category, this.amount, this.specificDescription, this.itemUnit});

  Item clone() {
    return Item(
      name: name,
      category: category,
      specificDescription: specificDescription,
      amount: amount,
      itemUnit: itemUnit,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'category': category,
      'specificDescription': specificDescription,
      'amount': amount,
      'itemUnit': itemUnit,
    };
  }
}
