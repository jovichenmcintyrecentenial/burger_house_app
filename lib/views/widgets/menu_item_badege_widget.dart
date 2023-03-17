import 'package:burger_house/data/models/response_model/menu_item.dart';
import 'package:burger_house/models/cart.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/theme/app_theme.dart';
import 'package:burger_house/views/widgets/auto_text_size_widget.dart';
import 'package:flutter/widgets.dart';

class MenuItemBadgeWidget extends StatelessWidget {
  const MenuItemBadgeWidget({
    required this.scale,
    required this.menu,
  });

  final double scale;
  final MenuItem menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35 * scale,
      height: 35 * scale,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1000),
          color:AppTheme.of(context).accentColor
      ),
      child: Center(
          child: AutoTextSizeWidget(ServiceLocator.locator<Cart>()
              .getAddedMenuItems(menu)
              .toString(),fontSize: 30 * scale,)),
    );
  }
}
