import '../../exports.dart';

void showProfileDialog(String url) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          /// Profile Image
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: NetworkImageWidget(
              imageUrl: url,
              height: 300,
              width: 300,
              borderRadius: 16,
            ),
          ),

          /// Close Button
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                child: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}
