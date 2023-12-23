import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
                height: 200,
                color: Colors.red,
                child: const Center(
                  child: Text("Home Page"),
                )),
          ),
        ],
      ),
    );
  }
}
