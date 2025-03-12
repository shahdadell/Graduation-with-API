import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/home_screen/bloc/home_bloc.dart';
import 'package:graduation_project/home_screen/bloc/home_event.dart';
import 'package:graduation_project/home_screen/bloc/home_state.dart';

class ServiceItemsScreen extends StatelessWidget {
  static const String routeName = 'ServiceItemsScreen';
  final int serviceId;
  final int userId;

  const ServiceItemsScreen({
    super.key,
    required this.serviceId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
        ..add(FetchServiceItemsEvent(serviceId: serviceId, userId: userId)),
      child: Scaffold(
        appBar: AppBar(title: const Text("Service Items")),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchServiceItemsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchServiceItemsSuccessState) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading:
                          item.itemsImage != null && item.itemsImage!.isNotEmpty
                              ? Image.network(
                                  item.itemsImage!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                )
                              : const Icon(Icons.fastfood),
                      title: Text(item.itemsName ?? 'No Name'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.itemsDes ?? 'No Description'),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Price: ${item.itemsPrice} EGP',
                                style: const TextStyle(color: Colors.green),
                              ),
                              if (item.itemsDiscount != null &&
                                  item.itemsDiscount! > 0) ...[
                                const SizedBox(width: 8),
                                Text(
                                  'Discount: ${item.itemsDiscount}%',
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      trailing: Icon(
                        item.favorite == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: item.favorite == 1 ? Colors.red : null,
                      ),
                    ),
                  );
                },
              );
            } else if (state is FetchServiceItemsErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
