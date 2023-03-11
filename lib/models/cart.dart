import 'package:burger_house/data/models/response_model/menu_item.dart';

class Cart {

  List<MenuItem> items = [];

  void removeItem(MenuItem menuItem){
        var index = 0;
        var findMatch = false;
        for(var item in items){
          if(item.id == menuItem.id){
            findMatch = true;
            break;
          }
          index++;
        }
        if(findMatch ) {
          items.removeAt(index);
        }
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

  void addItem(MenuItem menuItem){
    items.add(menuItem);
  }

  static createOrderRequest(){

  }
}