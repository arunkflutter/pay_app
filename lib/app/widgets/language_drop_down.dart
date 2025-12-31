import '../../exports.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border2Color),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          value: selectedLanguage,
          style: AppTextStyles.regularUrbanist,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: AppColors.textColor,
          ),
          borderRadius: BorderRadius.circular(12),
          items: [
            DropdownMenuItem(
              value: 'English',
              child: Text('English', style: AppTextStyles.regularUrbanist),
            ),
            DropdownMenuItem(
              value: 'German',
              child: Text('German', style: AppTextStyles.regularUrbanist),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedLanguage = value!;
            });

            /// Change app language
            if (value == 'English') {
              Get.updateLocale(const Locale('en'));
            } else {
              Get.updateLocale(const Locale('de'));
            }
          },
        ),
      ),
    );
  }
}
