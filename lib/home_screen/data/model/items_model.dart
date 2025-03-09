class ItemModel {
  String? itemId;
  String? itemName;
  String? itemDescription;
  String? itemImage;
  String? itemPrice;
  String? itemDiscount;
  String? itemLocation;
  String? itemRating;
  String? itemPhone;

  ItemModel({
    this.itemId,
    this.itemName,
    this.itemDescription,
    this.itemImage,
    this.itemPrice,
    this.itemDiscount,
    this.itemLocation,
    this.itemRating,
    this.itemPhone,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['items_id']?.toString(),
      itemName: json['items_name'] as String?,
      itemDescription: json['items_des'] as String?,
      itemImage: json['items_image'] as String?,
      itemPrice: json['items_price']?.toString(),
      itemDiscount: json['items_discount']?.toString(),
      itemLocation: json['service_location'] as String?,
      itemRating: json['service_rating']?.toString(),
      itemPhone: json['service_phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items_id': itemId,
      'items_name': itemName,
      'items_des': itemDescription,
      'items_image': itemImage,
      'items_price': itemPrice,
      'items_discount': itemDiscount,
      'service_location': itemLocation,
      'service_rating': itemRating,
      'service_phone': itemPhone,
    };
  }
}
