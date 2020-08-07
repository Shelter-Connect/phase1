class Item {
  String name, category, specificDescription;
  int amount;

  Item({this.name, this.category, this.amount, this.specificDescription});

  Item clone() {
    return Item(
      name: name,
      category: category,
      specificDescription: specificDescription,
      amount: amount
    );
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
