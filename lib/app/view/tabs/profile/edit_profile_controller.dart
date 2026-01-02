import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../../exports.dart';

class EditProfileController extends GetxController with BaseClass {
  final ImagePicker _picker = ImagePicker();

  File? profileImage;

  /// Pick image from camera
  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  /// Get initials fallback
  String getInitials(String name) {
    final parts = name.split(" ");
    return parts.map((e) => e[0]).take(2).join();
  }
}
