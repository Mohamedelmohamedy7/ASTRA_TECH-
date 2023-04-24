import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';


class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isCheckedEng = true;
  bool isCheckedArabic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "language".tr(),
          style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: "headline1",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "selectLanguage".tr(),
                  style: TextStyle(
                       fontSize: 15,
                      fontFamily: "headline1",
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              MSHCheckbox(
                size: 20,
                value: isCheckedArabic,
                checkedColor: Colors.red,
                style: MSHCheckboxStyle.fillScaleColor,
                onChanged: (selected) {

                    setState(() {
                      isCheckedArabic = true;
                      isCheckedEng = false;
                      context.locale = const Locale('ar', 'EG');
                    });

                },
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Arabic".tr(),
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              MSHCheckbox(
                  size: 20,
                  value: isCheckedEng,
                  checkedColor: Colors.red,
                  style: MSHCheckboxStyle.fillScaleColor,
                  onChanged: (selected) {
                    setState(() {
                      isCheckedEng = true;
                      isCheckedArabic = false;
                      context.locale = const Locale('en', 'US');

                    });
                  }),
              const SizedBox(
                width: 10,
              ),
              Text(
                "English".tr(),
                style: Theme.of(context).textTheme.headline1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
