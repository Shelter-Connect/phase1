class Item {
  String name, category, specificDescription, unit;
  int amount;

  Item({this.name, this.category, this.amount, this.specificDescription, this.unit});

  Item clone() {
    return Item(
      name: name,
      category: category,
      specificDescription: specificDescription,
      amount: amount,
      unit: unit,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'category': category,
      'specificDescription': specificDescription,
      'amount': amount,
      'unit': unit,
    };
  }
}
