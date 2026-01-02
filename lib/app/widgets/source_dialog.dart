import '../../exports.dart';

class SourceDialog {
  static void commonButtonsPopUp(
    context, {
    VoidCallback? onClose,
    bool showSecondButton = true,
    required VoidCallback onButtonTap,
    required VoidCallback onButton2Tap,
    required String button1Image,
    required String button2Image,
  }) async {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.blackDark.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween(
                begin: Offset(0, 1),
                end: Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          },
      pageBuilder:
          (
            BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation,
          ) {
            return StatefulBuilder(
              builder: (context, StateSetter setStateDialog) {
                return Container(
                  alignment: Alignment.bottomCenter,
                  child: Wrap(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          margin: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).padding.bottom + 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "upload_image".tr,
                                          style: AppTextStyles.boldUrbanist
                                              .copyWith(
                                                color: AppColors.blackDark,
                                                fontSize: 24,
                                              ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              onButtonTap();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: AppColors.appColor,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    button1Image,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "camera".tr,
                                                    style: AppTextStyles
                                                        .semiBoldUrbanist
                                                        .copyWith(
                                                          color: AppColors
                                                              .appColor,
                                                          fontSize: 22,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 14),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.back();
                                              onButton2Tap();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 16,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 14,
                                                vertical: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors.appColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    button2Image,
                                                    height: 30,
                                                    width: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    "gallery".tr,
                                                    style: AppTextStyles
                                                        .semiBoldUrbanist
                                                        .copyWith(
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 22,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 10,
                                top: 8,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Image.asset(
                                    AppImages.close,
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
    ).then((value) {
      if (onClose != null) {
        onClose();
      }
    });
  }
}
