import 'package:flutter/material.dart';

import 'delevery_screen.dart';


class DeleveeryInfo extends StatelessWidget {
  DeleveeryInfo({super.key});

  String deliveryName = "شات جي بي تي"; // اسم عامل التوصيل
  String deliveryStatus = "بالانتظار"; // حالة عامل التوصيل
  String deliveryPhone = "0999999999"; // رقم الهاتف

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [

          // صف اسم العامل وحالته
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  icon: Icons.person,
                  label: "اسم عامل التوصيل",
                  value: deliveryName,
                  editable: false,
                  onEdit: () {},
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: InfoTile(
                  icon: Icons.assignment_ind,
                  label: "حالة العامل",
                  value: deliveryStatus,
                  editable: false,
                  onEdit: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 14),

          // رقم الهاتف
          InfoTile(
            icon: Icons.phone,
            label: "رقم الهاتف",
            value: deliveryPhone,
            editable: false,
            onEdit: () {},
          ),
          SizedBox(height: 20),
        ]));
  }
}
