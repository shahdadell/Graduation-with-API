// import 'package:flutter/material.dart';
// import 'package:graduation_project/data/homeScreen.dart';
// import 'api_manager.dart';
//
//
// class CategoryDetails extends StatelessWidget {
//   static const String routName = 'category_repository';
//   const CategoryDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<HomeScreen>(
//         future: ApiManager.getSources(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor,
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Column(
//               children: [
//                 Text("Something went wrong"),
//                 ElevatedButton(
//                     onPressed: () {
//                       ApiManager.getSources();
//                     },
//                     child: Text("Try again"))
//               ],
//             );
//           }
//           if (snapshot.data?.status != 'ok') {
//             return Column(
//               children: [
//                 Text("Something went wrong"),
//                 ElevatedButton(
//                     onPressed: () {
//                       ApiManager.getSources();
//                     },
//                     child: Text("Try again"))
//               ],
//             );
//           }
//           var categoryMap = snapshot.data?.categories as Map? ?? {};
//           var categories = categoryMap.values.toList();
//
//           return ListView.builder(
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               var category_repository = categories[index];
//               return ListTile(
//                 title: Text(category_repository['categories_name'] ?? 'No Name'),
//                 subtitle: Text(category_repository['categories_name_ar'] ?? 'No Arabic Name'),
//                 leading: Image.network(category_repository['categories_image'] ?? ''),
//               );
//             },
//           );
//         });
//   }
// }
//