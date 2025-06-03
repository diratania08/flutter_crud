import 'package:flutter/material.dart';
import '../models/arsip.dart';
import 'quiz_screen.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Arsip> arsipList = [];

  final _namaController = TextEditingController();
  final _kelasController = TextEditingController();
  final _nimController = TextEditingController();

  Map<String, int> skorMap = {}; // Menyimpan skor berdasarkan NIM

  void _tambahAtauEditArsip({Arsip? arsip, int? index}) {
    if (arsip != null) {
      _namaController.text = arsip.nama;
      _kelasController.text = arsip.kelas;
      _nimController.text = arsip.nim;
    } else {
      _namaController.clear();
      _kelasController.clear();
      _nimController.clear();
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(arsip == null ? 'Tambah Arsip' : 'Edit Arsip'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _kelasController,
              decoration: InputDecoration(labelText: 'Kelas'),
            ),
            TextField(
              controller: _nimController,
              decoration: InputDecoration(labelText: 'NIM'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_namaController.text.isEmpty ||
                  _kelasController.text.isEmpty ||
                  _nimController.text.isEmpty) return;

              final newArsip = Arsip(
                nama: _namaController.text,
                kelas: _kelasController.text,
                nim: _nimController.text,
              );

              setState(() {
                if (arsip == null) {
                  arsipList.add(newArsip);
                } else {
                  arsipList[index!] = newArsip;
                }
              });

              Navigator.pop(context); // Tutup dialog

              final quizProvider =
                  Provider.of<QuizProvider>(context, listen: false);
              quizProvider.reset(); // Reset quiz

              // Mulai quiz dan tunggu hasil skor
              final skor = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => QuizScreen()),
              );

              // Simpan skor berdasarkan NIM
              if (skor != null) {
                setState(() {
                  skorMap[newArsip.nim] = skor;
                });
              }
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  void _hapusArsip(int index) {
    setState(() {
      skorMap.remove(arsipList[index].nim); // Hapus skor juga
      arsipList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Data Arsip')),
      body: ListView.builder(
        itemCount: arsipList.length,
        itemBuilder: (ctx, i) {
          final arsip = arsipList[i];
          final skor = skorMap[arsip.nim];

          return ListTile(
            title: Text("Nama : ${arsip.nama}"),
            subtitle: Text(
              'Kelas : ${arsip.kelas} \nNim : ${arsip.nim} \nSkor : ${skor != null ? skor.toString() : "-"}',
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _tambahAtauEditArsip(arsip: arsip, index: i),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _hapusArsip(i),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _tambahAtauEditArsip(),
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
      ),
    );
  }
}
