import 'package:burger_house/data/models/response_model/order_response_model.dart';
import 'package:burger_house/data/repositories/order_repo.dart';
import 'package:burger_house/models/segue_model/segue_model.dart';
import 'package:burger_house/route/app_routes.dart';
import 'package:burger_house/services/service_locator.dart';
import 'package:burger_house/utils/cache_helper.dart';
import 'package:burger_house/utils/helper.dart';
import 'package:burger_house/views/pages/main_view/cart_view.dart';
import 'package:burger_house/views/widgets/app_bars/title_app_bar_widget.dart';
import 'package:burger_house/views/widgets/empty_list_widget/empty_orders_widget.dart';
import 'package:burger_house/views/widgets/order_card_widget.dart';
import 'package:burger_house/views/widgets/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/title_header_widget.dart';

class OrdersView extends StatelessWidget {
  OrdersView({
    super.key,
  });
  final _orderRepo = ServiceLocator.locator<OrderRepo>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderViewProvider>(
      create: (_) => OrderViewProvider(),
      builder: (context, snapshot) {
        return Column(
          children: [
            AppTitleBar('My Orders'),
            Expanded(
              child: Consumer<OrderViewProvider>(
                builder: (context, provider, snapshot) {
                  return  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        const TitleHeaderWidget(
                          'Orders',
                          fontSize: 24,
                          fontHeight: 1.3,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(height:10),

                        Expanded(
                          child: PullToRefreshWidget<List<Order>?>(
                            // onLoadMore: (page) async => await loadMore(page, provider),
                              options: provider.pullToRefreshOptions,
                              emptyListWidget: EmptyOrderWidget(),
                              initialData: () => _orderRepo.getOrders(pullFromDisk()),
                              future: () => _orderRepo.getOrders(pullFromNet()),
                              builder: (context, List<Order>? data) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data!.length,
                                    itemBuilder: (context, i) {
                                      var reversed = data.reversed.toList();
                                      return Column(
                                        children: [
                                          OrderCardWidget(reversed[i]),
                                          SizedBox(height: 15,)
                                        ],
                                      );
                                    });

                              }),
                        ),
                        const SizedBox(height:100),




                      ],
                    ),
                  );
                }
              ),
            ),
          ],
        );
      }
    );
  }
}

class OrderViewProvider extends SegueNotifierViewProvider {
  var pullToRefreshOptions = PullToRefreshOptions(forceRefresh: false);




  @override
  bool isOk(BuildContext context, {GenericArgs? args}) {
    return true;
  }

  @override
  void updateSegueObject({GenericArgs? args}) {
  }
}



