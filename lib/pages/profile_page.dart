import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:search_restaurant/servers/api_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  final ImagePicker picker = ImagePicker();
  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ApiProfile apiProfile = ApiProfile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: userNameController,
                      decoration: InputDecoration(hintText: 'username'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(hintText: 'fullName'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: bioController,
                      decoration: InputDecoration(hintText: 'Bio'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: 'email'),
                    ),
                    IconButton(
                        onPressed: () async {
                          final XFile? imageFromgallery = await picker
                              .pickImage(source: ImageSource.gallery);
                          if (imageFromgallery != null) {
                            setState(() {
                              image = File(imageFromgallery.path);
                            });
                          }
                        },
                        icon: Icon(Icons.camera)),
                    ElevatedButton(onPressed: () {}, child: Text('save'))
                  ],
                ),
              );
            },
          );
        }),
        body: FutureBuilder(
          future: apiProfile.getprofile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.active) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.network(
                            width: 150,
                            height: 150,
                            snapshot.data!.profileImage != ''
                                ? snapshot.data!.profileImage
                                : 'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(snapshot.data!.username),
                        SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data!.fullName),
                        SizedBox(
                          height: 10,
                        ),
                        Text(snapshot.data!.bio)
                      ],
                    ),
                  ),
                );
              }
            }
            return SizedBox.shrink();
          },
        )
        // child:
        );
  }
}
