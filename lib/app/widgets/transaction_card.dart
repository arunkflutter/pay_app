import '../../exports.dart';

class TransactionCardWidget extends StatelessWidget {
  const TransactionCardWidget({
    super.key,
    this.isCredit = false,
    this.amount = 0,
    this.name = "Anna Smith",
    this.description = "--//-----//---",
    this.onTap,
    this.isDisableBorder = false,
    this.margin = EdgeInsets.zero,
  });

  final bool isCredit;
  final int amount;
  final String name;
  final String description;
  final GestureTapCallback? onTap;
  final bool isDisableBorder;
  final EdgeInsets margin;

  String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty) return "";

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color getAvatarColor(String name) {
    final colors = [
      AppColors.appColor,
      Colors.pinkAccent.shade200,
      Colors.yellow,
      Color(0xFFC78CFF),
      Colors.greenAccent.shade200,
      AppColors.green,
    ];
    return colors[name.hashCode % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: isDisableBorder ? EdgeInsets.zero : const EdgeInsets.all(12),
        margin: margin,
        decoration: BoxDecoration(
          border: isDisableBorder
              ? null
              : Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(19),
        ),
        child: Row(
          children: [
            /// -------- Avatar --------
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: getAvatarColor(name),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  getInitials(name),
                  style: AppTextStyles.boldUrbanist.copyWith(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// -------- Name & Description --------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.semiBoldUrbanist.copyWith(
                    fontSize: 18,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.regularUrbanist.copyWith(fontSize: 13),
                ),
              ],
            ),

            const Spacer(),

            /// -------- Amount --------
            if (amount.toString().isNotEmpty && amount != 0)
              Text(
                "${isCredit ? "+" : "-"} € $amount",
                style: AppTextStyles.semiBoldUrbanist.copyWith(
                  fontSize: 17,
                  color: isCredit ? AppColors.green : AppColors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
