import 'package:flutter/material.dart';
import '../../shared_widget/custom_main_container.dart';

class CustomChocolateOrderPage extends StatefulWidget {
  @override
  _CustomChocolateOrderPageState createState() =>
      _CustomChocolateOrderPageState();
}

class _CustomChocolateOrderPageState extends State<CustomChocolateOrderPage> {
  String? selectedChocolate;
  List<String> selectedIngredients = [];
  String? selectedPresentation;
  final TextEditingController weightController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final List<String> chocolates = ["حليب", "دارك", "وايت", "بندق"];
  final List<String> ingredients = ["فستق", "بندق", "جوز الهند", "كراميل", "زبيب"];
  final List<String> presentations = ["بطاقة", "صندوق", "تغليف فاخر"];

  bool get isFormValid {
    return selectedChocolate != null &&
        selectedIngredients.isNotEmpty &&
        selectedPresentation != null &&
        weightController.text.isNotEmpty &&
        notesController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    const brownFieldColor = Color(0xFF6C4A33); // بني للحقول
    const buttonColor = Color(0xFFD18656); // زر
    const whiteText = TextStyle(color: Colors.white);

    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: brownFieldColor, width: 2),
    );

    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFB8866E),
      appBar: AppBar(
        backgroundColor: Color(0xFFB8866E),
        elevation: 0,
        title: const Text("تواصي الشوكولا",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🟤 نوع الشوكولا
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "اختر نوع الشوكولا",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                style: whiteText,
                dropdownColor: brownFieldColor,
                iconEnabledColor: Colors.white,
                value: selectedChocolate,
                items: chocolates.map((choco) {
                  return DropdownMenuItem(
                    value: choco,
                    child: Text(choco, style: whiteText),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedChocolate = value),
              ),
              const SizedBox(height: 16),

              // 🟤 المكونات (حتى 3)
              InputDecorator(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "اختر المكونات (حتى 3)",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                child: Wrap(
                  spacing: 8,
                  children: ingredients.map((ingredient) {
                    final isSelected = selectedIngredients.contains(ingredient);
                    return FilterChip(
                      label: Text(ingredient, style: whiteText),
                      selected: isSelected,
                      selectedColor: buttonColor,
                      checkmarkColor: Colors.white,
                      backgroundColor: brownFieldColor,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            if (selectedIngredients.length < 3) {
                              selectedIngredients.add(ingredient);
                            }
                          } else {
                            selectedIngredients.remove(ingredient);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // 🟤 طريقة التقديم
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "طريقة التقديم",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                style: whiteText,
                dropdownColor: brownFieldColor,
                iconEnabledColor: Colors.white,
                value: selectedPresentation,
                items: presentations.map((present) {
                  return DropdownMenuItem(
                    value: present,
                    child: Text(present, style: whiteText),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => selectedPresentation = value),
              ),
              const SizedBox(height: 16),

              // 🟤 الوزن
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                style: whiteText,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "الوزن (غرام)",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              // 🟤 الملاحظات
              TextField(
                controller: notesController,
                maxLines: 3,
                style: whiteText,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: brownFieldColor,
                  labelText: "ملاحظات إضافية",
                  labelStyle: whiteText,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 100),

              // 🟤 زر الطلب
        ElevatedButton(
          onPressed: isFormValid
              ? () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: Colors.brown,
                title: const Text("تم إرسال الطلب", style: TextStyle(color: Colors.white)),
                content: const Text("شكراً لاختيارك!", style: TextStyle(color: Colors.white)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("موافق", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD18656), // لون بني فاتح
            padding: const EdgeInsets.symmetric(vertical: 16), // سماكة متناسقة
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // الحواف دائرية
            ),
            elevation: 0,
          ),
          child: const Text(
            "طلب المنتج",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        ],
          ),
        ),
      ),
    );
  }
}
