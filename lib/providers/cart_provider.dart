import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.total;
    });
    return total;
  }

  List<CartItem> get itemsList {
    return _items.values.toList();
  }

  int get totalPrepTime {
    if (_items.isEmpty) return 0;

    return _items.values.fold(0, (sum, item) => sum + item.prepTime);
  }

  void addItem(String dishId, String name, double price, String image, {int prepTime = 20}) {
    if (_items.containsKey(dishId)) {
      _items.update(
        dishId,
        (existingItem) => CartItem(
          id: existingItem.id,
          dishId: existingItem.dishId,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          image: existingItem.image,
          prepTime: existingItem.prepTime,
        ),
      );
    } else {
      _items.putIfAbsent(
        dishId,
        () => CartItem(
          id: DateTime.now().toString(),
          dishId: dishId,
          name: name,
          price: price,
          quantity: 1,
          image: image,
          prepTime: prepTime,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String dishId) {
    _items.remove(dishId);
    notifyListeners();
  }

  void decreaseQuantity(String dishId) {
    if (_items.containsKey(dishId)) {
      final item = _items[dishId]!;
      if (item.quantity > 1) {
        _items.update(
          dishId,
          (existingItem) => CartItem(
            id: existingItem.id,
            dishId: existingItem.dishId,
            name: existingItem.name,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            image: existingItem.image,
            prepTime: existingItem.prepTime,
          ),
        );
      } else {
        _items.remove(dishId);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
