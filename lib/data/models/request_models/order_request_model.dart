class OrderRequest {
  OrderRequest({
    this.menuItemsIds,
    this.estimate,
  });

  List<String>? menuItemsIds;
  bool? estimate;

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
    menuItemsIds: json["menu_items_ids"] == null ? [] : List<String>.from(json["menu_items_ids"]!.map((x) => x)),
    estimate: json["estimate"],
  );

  Map<String, dynamic> toJson() => {
    "menu_items_ids": menuItemsIds == null ? [] : List<dynamic>.from(menuItemsIds!.map((x) => x)),
    "estimate": estimate,
  };
}
