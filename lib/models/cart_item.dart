class CartItem {
  final String id;
  final String dishId;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final int prepTime;

  CartItem({
    required this.id,
    required this.dishId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    this.prepTime = 20,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dishId': dishId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'prepTime': prepTime,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      dishId: map['dishId'],
      name: map['name'],
      price: map['price'].toDouble(),
      quantity: map['quantity'],
      image: map['image'],
      prepTime: map['prepTime'] ?? 20,
    );
  }
}
