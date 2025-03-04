import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'หน้าแรก',
          style: theme.textTheme.headlineSmall, // ใช้ theme text
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor, // ใช้สีของ theme
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'ค้นหาด้วยวัตถุดิบ',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
                  suffixIcon: Icon(Icons.filter_list, color: theme.iconTheme.color),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            SizedBox(height: 20),

            // เมนูมาแรงวันนี้
            Text(
              'เมนูมาแรง วันนี้',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuCard(context, 'หมูชิ้น'),
                _buildMenuCard(context, 'ปลาซาบะ'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuCard(context, 'ไข่เป็ด'),
                _buildMenuCard(context, 'ผักโขม'),
              ],
            ),
            SizedBox(height: 20),

            // รายการค้นหาล่าสุด
            Text(
              'รายการค้นหาล่าสุด',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(height: 10),

            _buildRecentSearch(context, 'ปีกไก่', '3 วันที่แล้ว'),
            _buildRecentSearch(context, 'หมู, กระเทียม', '21 ม.ค. 2025'),
          ],
        ),
      ),
    );
  }

  // สำหรับการ์ดเมนู
  Widget _buildMenuCard(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: theme.cardColor, // ใช้ theme card color
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.primaryColorLight, // ใช้สีอ่อนของ primary color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.primaryColorDark, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // รายการค้นหาล่าสุด
  Widget _buildRecentSearch(BuildContext context, String title, String date) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor, // ใช้สีของ theme
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: theme.primaryColorLight, // ใช้สี primary
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
