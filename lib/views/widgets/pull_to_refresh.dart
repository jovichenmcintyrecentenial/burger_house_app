
import 'package:burger_house/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../theme/app_theme.dart';
import 'circle_loading_widget.dart';
import 'http_future_builder_widget.dart';

class PullToRefreshOptions{
  bool forceRefresh;

  PullToRefreshOptions({this.forceRefresh = false});

}

class PullToRefreshWidget<T> extends StatefulWidget {
  final Function? initialData;
  final Function? future;
  final Function(int)? onLoadMore;
  final PullToRefreshOptions? options;
  final Function? onPullToRefresh;
  final Function? onPullToRefreshCompleted;

  final ListView Function(BuildContext, T) builder;

  final dynamic emptyListWidget;
  final bool Function(T)? emptyCondition;
  const PullToRefreshWidget({
    this.initialData,
    this.future,
    required this.builder,
    this.onPullToRefresh,
    this.options,
    this.onLoadMore,
    this.emptyListWidget,
    this.emptyCondition,
    this.onPullToRefreshCompleted,
  }) : super(key: null);

  @override
  _PullToRefreshWidgetState<T> createState() => _PullToRefreshWidgetState<T>();
}

class _PullToRefreshWidgetState<T> extends State<PullToRefreshWidget<T>> {
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int page = 1;
  bool pullToRefresh = false;
  // ignore: prefer_typing_uninitialized_variables
  var loadMoreData;
  //when scrolling down to load more data after pull to refresh disable onPullToRefresh call back
  bool isLoadMore = false;

  //on load more
  void _onLoading() async{
    try {
      page++;
      var data = await widget.onLoadMore!(page);
      if(data is List){
        var list = data;
        loadMoreData = list;
        if(list.isEmpty){
          page--;
        }
        isLoadMore = true;
      }
    }
    catch (e) {
      Helper.logger.e('load more failed page: $page');
      page--;
    }
    if(mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();

  }

  bool _isPullToRefresh(){
    //if load more disable onRefresh callback
    if(isLoadMore ){
      if(widget.options != null && !widget.options!.forceRefresh) {
        return false;
      }
      else{
        //if is a force refresh reset load more
        _resetLoadMore();
      }
    }
    return widget.options == null || widget.options!.forceRefresh == false
        ? pullToRefresh
        : widget.options!.forceRefresh;
  }

  bool _isEmptyConditionMet(data){
    return (widget.emptyCondition != null && widget.emptyCondition!(data));
  }

  Widget showEmptyWidget(T data){
    if(data is List) {
      return (data).isEmpty || _isEmptyConditionMet(data)
          ? widget.emptyListWidget ?? const SizedBox()
          : const SizedBox();
    }

    if(widget.emptyCondition != null && widget.emptyCondition!(data)){
      return widget.emptyListWidget;
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return HttpBuilderWidget<T>(
        initialData: widget.initialData!=null?widget.initialData!():null,
        pullToRefresh: _isPullToRefresh(),
        future: () => widget.future!(),
        onError: (x){ _refreshController.refreshCompleted();},
        onSuccess: (x){ _refreshController.refreshCompleted();
        if(widget.onPullToRefreshCompleted != null && pullToRefresh){
          widget.onPullToRefreshCompleted!();
          pullToRefresh = false;
        }
        },
        builder:
            (context, T data) {


          if(data != null && widget.options != null){
            widget.options!.forceRefresh = false;
          }

          //if load more data have data app to data
          if(data is List && loadMoreData != null){
            data.addAll(loadMoreData);
          }

          return data != null
              ? Stack(
            children: [
              SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: true,
                  onLoading: _onLoading,
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus? mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text('');
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text('');
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text('');
                      } else {
                        body = const Text('No more data');
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  onRefresh: () {
                    //clear load more
                    _resetLoadMore();

                    if (widget.onPullToRefresh != null) {
                      widget.onPullToRefresh!();
                    }
                    setState(() {
                      pullToRefresh = true;
                    });
                  },
                  child: !_isEmptyConditionMet(data)
                      ? widget.builder(context, data)
                      : ListView()),
              showEmptyWidget(data),
            ],
          )
              : SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleLoadingWidget(
                  backgroundColor:
                  AppTheme.of(context).primaryColor,
                  width: 50,
                  height: 50,
                  strokeWidth: 4,
                ),
              ],
            ),
          );
        });
  }

  void _resetLoadMore() {
    page = 1;
    isLoadMore = false;
    if(loadMoreData != null) {
      loadMoreData.clear();
    }
  }
}