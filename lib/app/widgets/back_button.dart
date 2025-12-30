import '../../exports.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.onTapBack, this.margin, this.color});

  final Function()? onTapBack;
  final EdgeInsets? margin;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapBack ?? () => Get.back(),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: margin ?? EdgeInsets.only(left: 15),
        child: Image.asset(
          AppImages.arrowBack,
          width: 25,
          height: 25,
          color: color ?? AppColors.white,
        ),
      ),
    );
  }
}
