import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/home_event.dart';
import 'package:graduation_project/home_screen/bloc/home_state.dart';

class ServicesScreen extends StatelessWidget {
  static const String routeName = 'ServicesScreen';
  final String categoryId;
  final String categoryName;

  const ServicesScreen(
      {super.key, required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final int parsedCategoryId = int.tryParse(categoryId) ?? 0;

    return BlocProvider(
      create: (context) =>
      HomeBloc()
        ..add(FetchServicesEvent(parsedCategoryId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            categoryName,
            style: Theme
                .of(context)
                .textTheme
                .titleLarge,
          ),
          centerTitle: true,
          backgroundColor: MyTheme.orangeColor,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchServicesLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primary,
                ),
              );
            } else if (state is FetchServicesSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: state.services.length,
                  itemBuilder: (context, index) {
                    final service = state.services[index];
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: service.serviceImage != null &&
                                        service.serviceImage!.isNotEmpty
                                        ? Image.network(service.serviceImage!,
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover)
                                        : Icon(Icons.image_not_supported,
                                        size: 90, color: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          service.serviceName ?? 'No Name',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.star, color: Colors.amber,
                                                size: 18),
                                            const SizedBox(width: 5),
                                            Text(
                                              service.serviceRating ?? 'N/A',
                                              style: Theme
                                                  .of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on,
                                                color: Colors.red, size: 18),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                service.serviceLocation ??
                                                    'Unknown location',
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .bodySmall,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Divider(color: Colors.grey[300]),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                runSpacing: 5,
                                children: [
                                  service.servicePhone != null
                                      ? GestureDetector(
                                    onTap: () =>
                                        showServiceDialog(
                                            context, "Phone Number",
                                            service.servicePhone ??
                                                "No Phone Number"),
                                    child: Chip(
                                      label: Text("Call"),
                                      avatar: Icon(
                                          Icons.phone, color: Colors.white),
                                      backgroundColor: Colors.green[700],
                                      labelStyle: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  )
                                      : const SizedBox(),
                                  service.serviceWebsite != null
                                      ? GestureDetector(
                                    onTap: () =>
                                        showServiceDialog(
                                            context, "Website",
                                            service.serviceWebsite ??
                                                "No Website Available"),
                                    child: Chip(
                                      label: Text("Visit Website"),
                                      avatar: Icon(
                                          Icons.web, color: Colors.white),
                                      backgroundColor: Colors.blue[700],
                                      labelStyle: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  )
                                      : const SizedBox(),
                                  GestureDetector(
                                    onTap: () =>
                                        showServiceDialog(
                                          context,
                                          "More Details",
                                          "Name: ${service.serviceName}\n"
                                              "Description: ${service
                                              .serviceDescription}\n"
                                              "Location: ${service
                                              .serviceLocation}\n"
                                              "Rating: ${service
                                              .serviceRating}",
                                        ),
                                    child: Chip(
                                      label: Text("More Details"),
                                      avatar: Icon(
                                          Icons.info, color: Colors.white),
                                      backgroundColor: Colors.orange[800],
                                      labelStyle: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
              ;
            } else if (state is FetchServicesErrorState) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.red),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void showServiceDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            title: Text(title, style: Theme
                .of(context)
                .textTheme
                .titleMedium),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7, // عرض أقل من الشاشة
                maxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.4, // تقليل الارتفاع
              ),
              child: SingleChildScrollView(
                child: Text(content, style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close", style: TextStyle(color: Theme
                    .of(context)
                    .colorScheme
                    .primary)),
              ),
            ],
          ),
    );
  }
}
