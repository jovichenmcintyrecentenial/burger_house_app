import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/local_storage.dart';

class Cart {
  var _localStorage = ServiceLocator.locator<LocalStorage>();
  List<MenuItem> get items {
    var json = _localStorage.retrieve(LSKey.CART);
    if(json == null) return [];
    return menuItemFromJson(json);
  }

  set items(List<MenuItem> its){
    _localStorage.save(LSKey.CART,menuItemToJson(its));
  }

  void removeItem(MenuItem menuItem){
        var index = 0;
        var findMatch = false;
        var tempItems = items;
        for(var item in tempItems){
          if(item.id == menuItem.id){
            findMatch = true;
            break;
          }
          index++;
        }
        if(findMatch ) {
          tempItems.removeAt(index);
        }
        items = tempItems;
  }

  int getAddedMenuItems(MenuItem menuItem){
      int counter = 0;
      for(var item in items){
        if(item.id == menuItem.id){
          counter++;
        }
      }
      return counter;
  }

  void clearCartOfMenuItem(MenuItem menuItem){
    var tempItems = items;
    tempItems.removeWhere((MenuItem menu) => menu.id == menuItem.id);
    items = tempItems;
  }


  void clearCart(){
    items = [];
  }

  void addItem(MenuItem menuItem){
    var tempItems = items;
    tempItems.add(menuItem);
    items = tempItems;
  }

  static createOrderRequest(){

  }
}