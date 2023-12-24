import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umlcc_eval/app/controllers/data_controller.dart';
import 'package:umlcc_eval/app/ui/auth/me/profile_page.dart';
import 'package:umlcc_eval/generated/assets.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static const String route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              DataController.to.loadProducts();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            icon: const ClipOval(
              child: Hero(
                tag: "profileButton",
                child: Image(
                  image: AssetImage(Assets.imagesUser0),
                  width: 36,
                ),
              ),
            ),
            onPressed: () {
              Get.toNamed(ProfilePage.route);
            },
          ),
        ],
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
