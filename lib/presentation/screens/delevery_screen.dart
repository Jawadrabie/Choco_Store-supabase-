import 'package:flutter/material.dart';

import 'delevery_info.dart';


class DeliveryInfoScreen extends StatefulWidget {
  @override
  _DeliveryInfoScreenState createState() => _DeliveryInfoScreenState();
}

class _DeliveryInfoScreenState extends State<DeliveryInfoScreen> {
  final String status = "لم يتم الطلب بعد";
  final String orderDate = "2025-08-29";
  String customerAddress = "حلب, حلب الجديدة";

  bool isEditingAddress = false; // للتحكم بظهور نافذة التعديل
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = customerAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFB8866E),
      appBar: AppBar(
        backgroundColor: Color(0xFFB8866E),
        elevation: 0,
        title: const Text("معلومات التوصيل",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DeliverySection(),
              SizedBox(height: 14),
          
              InfoTile(
                icon: Icons.local_shipping,
                label: "حالة الطلب",
                value: status,
              ),
              SizedBox(height: 14),
          
              InfoTile(
                icon: Icons.calendar_today,
                label: "تاريخ الطلب",
                value: orderDate,
              ),
              SizedBox(height: 14),
          
              // Customer Address
              Column(
                children: [
                  InfoTile(
                    icon: Icons.location_on,
                    label: "عنوان الزبون",
                    value: customerAddress,
                    editable: true,
                    onEdit: () {
                      setState(() {
                        isEditingAddress = !isEditingAddress;
                        _addressController.text = customerAddress;
                      });
                    },
                  ),
                  if (isEditingAddress) ...[
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFF6C4A33),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _addressController,
                            maxLines: 4,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "أدخل العنوان الجديد",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.brown), // لون وقت التركيز
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey), // لون وقت العادي
                              ),
                            ),
                            cursorColor: Colors.brown,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFD18656),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      customerAddress = _addressController.text;
                                      isEditingAddress = false;
                                    });
                                  },
                                  child: Text("حفظ", style: TextStyle(color: Colors.white),),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isEditingAddress = false;
                                    });
                                  },
                                  child: Text("إلغاء",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]
                ],
              ),
              SizedBox(height: 14),
          
              PromoCodeTile(),
              SizedBox(height: 20,),
              DeleveeryInfo(),
              SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              // الإجراء المطلوب عند الضغط
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD18656), // لون بني فاتح
              padding: const EdgeInsets.symmetric(vertical: 16), // سماكة متناسقة
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // الحواف دائرية
              ),
              elevation: 0,
            ),
            child: const Text(
              "تأكيد الطلب",
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

class DeliverySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(0xFF7A5336),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.delivery_dining, color: Colors.white),
          SizedBox(width: 14),
          Expanded(
            child: Text("الدفع عند الاستلام",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Icon(Icons.check_circle, color: Colors.white),
        ],
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool editable;
  final VoidCallback? onEdit;

  const InfoTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.editable = false,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(0xFF6C4A33),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 14),
          Expanded(
            child: Text("$label: $value",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
          if (editable)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: onEdit,
            ),
        ],
      ),
    );
  }
}

class PromoCodeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
      decoration: BoxDecoration(
        color: Color(0xFF6C4A33),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.card_giftcard, color: Colors.white),
          SizedBox(width: 14),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "أدخل رمز الحسم",
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD18656),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {}, //تأكيد الحسم على جميع المنتجات
            child: Text("تفعيل", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
