class Item {
  String name, category, specificDescription;
  int amount;

  Item({this.name, this.category, this.amount});

  Item.clone({Item item, int newAmount}) {
    this.name = item.name;
    this.category = item.category;
    this.specificDescription = item.specificDescription;
    this.amount = newAmount;
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
