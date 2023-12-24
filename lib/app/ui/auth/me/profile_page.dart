import 'package:flutter/material.dart';
import 'package:umlcc_eval/app/services/auth_service.dart';
import 'package:umlcc_eval/configs/constants.dart';
import 'package:umlcc_eval/generated/assets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  static const String route = "/me";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: kBackgroundColor,
        title: Text(AuthService.to.user.value!.fullName()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              AuthService.to.logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 8.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      //color: Colors.blue,
                      padding: const EdgeInsets.all(1),
                      child: const ClipOval(
                        child: Hero(
                          tag: "profileButton",
                          child: Image(
                            image: AssetImage(Assets.imagesUser0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("First Name : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  )),
                              Text("Middle Name : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  )),
                              Text("Last Name : ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(AuthService.to.user.value!.firstName!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                              Text(AuthService.to.user.value?.middleName ?? '',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                              Text(AuthService.to.user.value!.lastName!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: ListTile(
                title: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text("Email : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle: Text(AuthService.to.user.value!.email!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                )),
                          ),
                          ListTile(
                            title: const Text("Phone : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle: Text(
                                AuthService.to.user.value!.fullPhone() ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                )),
                          ),
                          ListTile(
                            title: const Text("Birth Date : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle: Text(AuthService.to.user.value!.dob!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const Text("Type : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle: Text(AuthService.to.user.value!.type!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                )),
                          ),
                          ListTile(
                            title: const Text("Last Login : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle: Text(
                                AuthService.to.user.value!
                                        .lastLoginAtFormat() ??
                                    '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                )),
                          ),
                          ListTile(
                            title: const Text("Login Count : ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                )),
                            subtitle:
                                Text(AuthService.to.user.value!.loginCount!,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: ListTile(
                title: Text(
                  "Accounts",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: AuthService.to.user.value!.accounts!.map((account) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 4.0),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: const Text("Account : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      )),
                                  subtitle: Text(account.accountNr!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ),
                                ListTile(
                                  title: const Text("Name : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      )),
                                  subtitle: Text(account.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: const Text("Type : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      )),
                                  subtitle: Text(account.type!,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ),
                                ListTile(
                                  title: const Text("Status : ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      )),
                                  subtitle: Text(account.activeToString() ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
