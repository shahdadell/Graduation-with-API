import 'package:graduation_project/home_screen/data/model/item_model_response/items_model.dart';

class ItemModelResponse {
  String? status;
  List<ItemModel>? data;

  ItemModelResponse({this.status, this.data});

  factory ItemModelResponse.fromJson(Map<String, dynamic> json) {
    return ItemModelResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
