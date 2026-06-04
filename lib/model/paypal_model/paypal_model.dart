class PaypalModel {
  final Amount amount;
  final String description;
  final ItemList itemList;

  PaypalModel({
    required this.amount,
    required this.description,
    required this.itemList,
  });

  factory PaypalModel.fromJson(Map<String, dynamic> json) {
    return PaypalModel(
      amount: Amount.fromJson(json['amount']),
      description: json['description'] ?? '',
      itemList: ItemList.fromJson(json['item_list']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount.toJson(),
      'description': description,
      'item_list': itemList.toJson(),
    };
  }
}

class Amount {
  final String total;
  final String currency;
  final AmountDetails details;

  Amount({required this.total, required this.currency, required this.details});

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      total: json['total'].toString(),
      currency: json['currency'] ?? '',
      details: AmountDetails.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'total': total, 'currency': currency, 'details': details.toJson()};
  }
}

class AmountDetails {
  final String subtotal;
  final String shipping;
  final int shippingDiscount;

  AmountDetails({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  factory AmountDetails.fromJson(Map<String, dynamic> json) {
    return AmountDetails(
      subtotal: json['subtotal'].toString(),
      shipping: json['shipping'].toString(),
      shippingDiscount: json['shipping_discount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount,
    };
  }
}

class ItemList {
  final List<Item> items;

  ItemList({required this.items});

  factory ItemList.fromJson(Map<String, dynamic> json) {
    return ItemList(
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items.map((e) => e.toJson()).toList()};
  }
}

class Item {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'].toString(),
      currency: json['currency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'currency': currency,
    };
  }
}
