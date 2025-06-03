import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Berikutnya')),
      body: Center(
        child:
            Text('Data berhasil ditambahkan!\nIni adalah halaman berikutnya.'),
      ),
    );
  }
}
