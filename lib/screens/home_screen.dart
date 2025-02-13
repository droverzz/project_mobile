import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'หน้าแรก',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔎 Search Bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2F2F4F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'ค้นหาด้วยวัตถุดิบ',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: Icon(Icons.filter_list, color: Colors.white),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 20),

            // 🍽 เมนูมาแรงวันนี้
            Text(
              'เมนูมาแรง วันนี้',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuCard('หมูชิ้น'),
                _buildMenuCard('ปลาซาบะ'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuCard('ไข่เป็ด'),
                _buildMenuCard('ผักโขม'),
              ],
            ),
            SizedBox(height: 20),

            // รายการค้นหาล่าสุด
            Text(
              'รายการค้นหาล่าสุด',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10),

            _buildRecentSearch('ปีกไก่', '3 วันที่แล้ว'),
            _buildRecentSearch('หมู, กระเทียม', '21 ม.ค. 2025'),
          ],
        ),
      ),
    );
  }

  // สำหรับการ์ดเมนู
  Widget _buildMenuCard(String title) {
    return Expanded(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey[400], // สี placeholder
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.red[800], fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // รายการค้นหาล่าสุด
  Widget _buildRecentSearch(String title, String date) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF2F2F4F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[400], // สี placeholder
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                date,
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
