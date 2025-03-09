// /// status : "success"
// /// data : [{"categories_id":"4","categories_name":"Restaurants","categories_name_ar":"مطاعم","categories_image":"https://abdulrahmanantar.com/outbye/upload/categories/rest3.jpg","categories_datetime":"2025-02-01 18:49:26"},{"categories_id":"5","categories_name":"Cafes","categories_name_ar":"كافيهات","categories_image":"https://abdulrahmanantar.com/outbye/upload/categories/cafes.jpg","categories_datetime":"2025-02-01 18:49:00"},{"categories_id":"6","categories_name":"Hotels","categories_name_ar":"فنادق","categories_image":"https://abdulrahmanantar.com/outbye/upload/categories/hotel.jpg","categories_datetime":"2025-01-25 23:14:06"},{"categories_id":"7","categories_name":"Tourist Places","categories_name_ar":"أماكن سياحية","categories_image":"https://abdulrahmanantar.com/outbye/upload/categories/tourists.jpeg","categories_datetime":"2025-02-01 18:49:41"}]
//
// class CategoryResponseEntity {
//   CategoryResponseEntity({
//     this.status,
//     this.data,
//   });
//
//   String? status;
//   List<DataEntity>? data;
// }
//
// /// categories_id : "4"
// /// categories_name : "Restaurants"
// /// categories_name_ar : "مطاعم"
// /// categories_image : "https://abdulrahmanantar.com/outbye/upload/categories/rest3.jpg"
// /// categories_datetime : "2025-02-01 18:49:26"
//
// class DataEntity {
//   DataEntity({
//     this.categoriesId,
//     this.categoriesName,
//     this.categoriesNameAr,
//     this.categoriesImage,
//     this.categoriesDatetime,
//   });
//
//   DataEntity.fromJson(dynamic json) {
//     categoriesId = json['categories_id'];
//     categoriesName = json['categories_name'];
//     categoriesNameAr = json['categories_name_ar'];
//     categoriesImage = json['categories_image'];
//     categoriesDatetime = json['categories_datetime'];
//   }
//   String? categoriesId;
//   String? categoriesName;
//   String? categoriesNameAr;
//   String? categoriesImage;
//   String? categoriesDatetime;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['categories_id'] = categoriesId;
//     map['categories_name'] = categoriesName;
//     map['categories_name_ar'] = categoriesNameAr;
//     map['categories_image'] = categoriesImage;
//     map['categories_datetime'] = categoriesDatetime;
//     return map;
//   }
// }
