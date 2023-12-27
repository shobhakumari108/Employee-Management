import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child:const Center(
                                child: Text(
                                  "ADD LOGO",
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                           const SizedBox(
                              width: 20,
                            ),
                           const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rad",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text("1 branches added")
                              ],
                            ),
                          ],
                        ),
                      const  Row(
                          children: [
                            // Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               const SizedBox(
                  height: 20,
                ),
              const  Text(
                  "Suggested features",
                  style: TextStyle(fontSize: 20),
                ),
              const  SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Material(
                      elevation: 5,
                      child: Container(
                        height: 120,
                        width: 100,
                        child:const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 20, child: Icon(Icons.account_box)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Staff App")
                          ],
                        ),
                      ),
                    ),
                   const SizedBox(
                      width: 20,
                    ),
                    Material(
                      elevation: 5,
                      child: Container(
                        height: 120,
                        width: 100,
                        child:const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 20, child: Icon(Icons.account_box)),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Leave"),
                            Text("Requests")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
               const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child:const Center(
                                child: Text(
                                  "ADD LOGO",
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                           const SizedBox(
                              width: 20,
                            ),
                           const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Users & Permissions",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("1 branches added")
                              ],
                            ),
                          ],
                        ),
                       const SizedBox(
                          height: 20,
                        ),
                       const Row(
                          children: [
                            // Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child:const Center(
                                child: Text(
                                  "ADD LOGO",
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                           const SizedBox(
                              width: 20,
                            ),
                           const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Attendance & Leaves",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("1 branches added")
                              ],
                            ),
                          ],
                        ),
                       const Row(
                          children: [
                            // Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child:const Center(
                                child: Text(
                                  "ADD LOGO",
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          const  SizedBox(
                              width: 20,
                            ),
                           const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Reports",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("1 branches added")
                              ],
                            ),
                          ],
                        ),
                      const  Row(
                          children: [
                            // Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const  SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(25)),
                              child:const Center(
                                child: Text(
                                  "ADD LOGO",
                                  style: TextStyle(
                                      fontSize: 5, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          const  SizedBox(
                              width: 20,
                            ),
                          const  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Business Contacts",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text("1 branches added")
                              ],
                            ),
                          ],
                        ),
                      const  Row(
                          children: [
                            // Icon(Icons.edit),
                            Text(
                              "Edit",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
