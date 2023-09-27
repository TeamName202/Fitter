import 'dart:io';

import 'package:fitter/models/user_profile.dart';
import 'package:fitter/services/api_service.dart';
import 'package:fitter/widgets/button_mold.dart';
import 'package:fitter/widgets/input_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPageAlertDialog extends StatefulWidget {
  const MyPageAlertDialog({super.key});

  @override
  State<MyPageAlertDialog> createState() => _MyPageAlertDialogState();
}

class _MyPageAlertDialogState extends State<MyPageAlertDialog> {
  late Future<UserProfile> userProfile;

  @override
  void initState() {
    super.initState();
    setState(() {
      userProfile = ApiService.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 340,
        width: 340,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: const Color(0xFF0080FF),
                        width: 5,
                      ),
                    ),
                    child: FutureBuilder(
                      future: userProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: snapshot.data!.image!,
                          );
                        }
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Icon(
                            Icons.person,
                            size: 90,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    await ApiService.deleteProfile();
                    setState(() {
                      userProfile = ApiService.getUserProfile();
                    });
                  },
                  child: const ButtonMold(
                      btnText: "사 진 삭 제",
                      horizontalLength: 20,
                      verticalLength: 15,
                      buttonColor: false),
                ),
                GestureDetector(
                  onTap: () async {
                    final pickedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    ApiService.changeProfileImg(pickedImage, userProfile);
                    setState(() {
                      userProfile = ApiService.getUserProfile();
                    });
                  },
                  child: const ButtonMold(
                      btnText: "사 진 수 정",
                      horizontalLength: 20,
                      verticalLength: 15,
                      buttonColor: true),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: InputText(hintText: "이 름"),
            ),
            const Expanded(
              child: InputText(hintText: "박 스"),
            ),
          ],
        ),
      ),
    );
  }
}
