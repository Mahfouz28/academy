import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SelectTypeSerch extends StatefulWidget {
  const SelectTypeSerch({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatusDropdownState createState() => _StatusDropdownState();
}

class _StatusDropdownState extends State<SelectTypeSerch> {
  final List<String> items = [
    'All Statuses',
    'Active',
    'Expiring Soon',
    'Expired',
  ];

  String? selectedValue = 'All Statuses';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text('Select Status', style: TextStyle(color: Colors.white)),
        value: selectedValue,
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF1A1D2E), // لون الخلفية زي الصورة
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF0E1320), // لون القائمة
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 24,
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 40,
          overlayColor: MaterialStateProperty.all(
            Colors.amber.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
