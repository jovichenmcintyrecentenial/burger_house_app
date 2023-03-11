import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {

  group('Test functionality of cart', () {

    test('Add 1 item to cart', () {
      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger1'));
      expect(cart.items.length,1 );
    });

    test('Add 2 item to cart', () {
      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger2'));
      cart.addItem(MenuItem(id: 'A burger2'));

      expect(cart.items.length,2 );
    });

    test('Try to remove item that isn\'t in cart', () {

      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger2'));

      cart.removeItem(MenuItem(id: 'A burger'));
      expect(cart.items.length,1 );

    });

    test('Remove second item to cart', () {
      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger1'));
      cart.addItem(MenuItem(id: 'A burger2'));

      cart.removeItem(MenuItem(id: 'A burger2'));

      expect(cart.items[0].id, 'A burger1');
      expect(cart.items.length,1 );
    });

    test('Remove all item from cart', () {
      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger1'));
      cart.addItem(MenuItem(id: 'A burger2'));
      cart.addItem(MenuItem(id: 'A burger3'));

      cart.removeItem(MenuItem(id: 'A burger1'));
      cart.removeItem(MenuItem(id: 'A burger2'));
      cart.removeItem(MenuItem(id: 'A burger3'));

      expect(cart.items.length,0 );
    });

    test('get count of number of item added for a specific menu item', () {
      var cart = Cart();
      cart.addItem(MenuItem(id: 'A burger1'));
      cart.addItem(MenuItem(id: 'A burger2'));
      cart.addItem(MenuItem(id: 'A burger1'));

      expect(cart.getAddedMenuItems(MenuItem(id: 'A burger1')),2 );
    });

  });
}
