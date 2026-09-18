import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// MODEL DATA
// -----------------------------------------------------------------------------
class CatalogItem {
  final String title;
  final String price;
  final String description;

  CatalogItem({
    required this.title,
    required this.price,
    required this.description,
  });
}

// -----------------------------------------------------------------------------
// SCREEN 1: BERANDA (StatelessWidget)
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  final List<CatalogItem> items = [
    CatalogItem(
      title: 'Laptop Gaming',
      price: 'Rp 15.000.000',
      description:
          'Laptop spesifikasi tinggi untuk gaming dan desain grafis berat.',
    ),
    CatalogItem(
      title: 'Smartphone',
      price: 'Rp 5.000.000',
      description:
          'Kamera jernih 108MP, baterai awet tahan seharian, dan layar AMOLED.',
    ),
    CatalogItem(
      title: 'Wireless Headphone',
      price: 'Rp 1.200.000',
      description: 'Kualitas suara audio bass mantap dengan fitur Active Noise Cancelling.',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Produk')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.price),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Stack Navigation menggunakan Navigator.push
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SCREEN 2: DETAIL KATALOG (StatefulWidget)
// -----------------------------------------------------------------------------
class DetailScreen extends StatefulWidget {
  final CatalogItem item;

  const DetailScreen({super.key, required this.item});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // State interaktif untuk tombol Like/Disukai
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        // Icon panah di atas ini adalah tombol Back otomatis bawaan AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nama Produk
            Text(
              widget.item.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Harga Produk
            Text(
              widget.item.price,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // Container Warna Pastel untuk Deskripsi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Warna hijau pastel
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.item.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 24),

            // Row berisi Tombol Sukai & Tombol Back Manual
            Row(
              children: [
                // Tombol Interaktif (Perubahan State)
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  label: Text(isFavorite ? 'Disukai' : 'Sukai Produk'),
                ),
                const SizedBox(width: 12),

                // Tombol Back Manual tambahan
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Perintah kembali ke Screen 1
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
