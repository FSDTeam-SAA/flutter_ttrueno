import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String selectedLanguage = 'English';

  final List<String> languages = ['English', 'Spanish', 'French'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language',style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: AppColors.white, // ✅ Set your background color here
      body: Column(
        children: [
          ...languages.map(
            (language) => ListTile(
              title: Text(
                language,
                style: TextStyle(
                  color: selectedLanguage == language
                      ? AppColors.primarybutton
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: selectedLanguage == language
                  ? Icon(Icons.check, color: AppColors.primarybutton)
                  : null,
              onTap: () {
                setState(() {
                  selectedLanguage = language;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(
                context,
                selectedLanguage,
              ); // return the language to previous screen

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Language has been set to $selectedLanguage',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },

            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarybutton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
