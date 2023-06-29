import 'dart:io';

import 'package:dall_e_image_generator/colors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ArtCollectionPage extends StatefulWidget {
  const ArtCollectionPage({Key? key}) : super(key: key);

  @override
  State<ArtCollectionPage> createState() => _ArtCollectionPageState();
}

class _ArtCollectionPageState extends State<ArtCollectionPage> {
  List imgList = [];

  getImages() async {
    // final appDocDirectory = (await getApplicationDocumentsDirectory()).path;
    final directory = Directory(
        "/data/user/0/com.example.dall_e_image_generator/app_flutter/AI Images");
    imgList = directory.listSync();

    print(imgList);
  }

  popImage(filePath) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: 300,
                height: 300,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.file(
                  filePath,
                  fit: BoxFit.fill,
                ),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Arts",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: imgList.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 200,
                ),
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      popImage(imgList[index]);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.file(
                        imgList[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  "My Art is Empty",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
