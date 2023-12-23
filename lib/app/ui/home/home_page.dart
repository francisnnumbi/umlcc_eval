import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/controllers/data_controller.dart';
import 'package:umlcc_eval/app/ui/auth/me/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  static const String route = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {
              Get.toNamed(ProfilePage.route);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DataController.to.loadProducts();
        },
        child: const Icon(Icons.refresh),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Obx(
              () => ListView.builder(
                itemCount: DataController.to.products.value?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      DataController.to.selectProduct(
                          DataController.to.products.value![index]);
                    },
                    title: Text(DataController.to.products.value![index].name!),
                    subtitle: Text(
                      DataController.to.products.value![index]
                          .formatDescription()
                          .toString(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
