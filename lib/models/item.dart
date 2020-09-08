import 'dart:ui';

class Item {
  String name, category, specificDescription, unit;
  int amount, urgency;
  Color urgencyColor;
  String sync;

  Item({this.name, this.category, this.amount, this.specificDescription, this.unit, this.urgency = 0, this.urgencyColor, this.sync = ''});

  Item clone() {
    return Item(
      name: name,
      category: category,
      specificDescription: specificDescription,
      amount: amount,
      unit: unit,
      urgency: urgency,
      urgencyColor: urgencyColor,
      sync: sync,
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
      'sync': sync,
    };
  }
}
