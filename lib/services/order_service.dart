import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/providers/cart_provider.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createOrder(CartProvider cart) async {
    try {
      final userId = _auth.currentUser!.uid;
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (!userDoc.exists) {
        throw Exception('Профиль пользователя не найден');
      }

      final userData = userDoc.data() as Map<String, dynamic>;
      final address = userData['address'] ?? 'Адрес не указан';
      final cityLabel = userData['cityLabel'] ?? '';
      final phone = userData['phone'] ?? '';

      final items = cart.itemsList
          .map(
            (item) => {
              'dishId': item.dishId,
              'name': item.name,
              'price': item.price,
              'quantity': item.quantity,
              'image': item.image,
            },
          )
          .toList();

      final orderData = {
        'userId': userId,
        'items': items,
        'totalAmount': cart.totalAmount,
        'address': address,
        'cityLabel': cityLabel,
        'phone': phone,
        'status': 'Делается',
        'createdAt': FieldValue.serverTimestamp(),
      };

      final docRef = await _firestore.collection('orders').add(orderData);

      cart.clear();

      return docRef.id;
    } catch (e) {
      throw Exception('Ошибка создания заказа: $e');
    }
  }

  Stream<QuerySnapshot> getUserOrders() {
    final userId = _auth.currentUser!.uid;

    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
