class Item {
  String name, category, specificDescription, unit;
  int amount, urgency;

  Item({this.name, this.category, this.amount, this.specificDescription, this.unit, this.urgency = 0});

  Item clone() {
    return Item(
      name: name,
      category: category,
      specificDescription: specificDescription,
      amount: amount,
      unit: unit,
      urgency: urgency,
    );
  }

  Map<String, dynamic> toFirestoreMap() {
    return {
      'name': name,
      'category': category,
      'specificDescription': specificDescription,
      'amount': amount,
      'unit': unit,
      'urgency': urgency,
    };
  }
}
