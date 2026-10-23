import 'package:flutter/material.dart';
import 'home_page.dart';

/// Form Registrasi [WAJIB].
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaTokoC = TextEditingController();
  final _namaPemilikC = TextEditingController();
  final _alamatC = TextEditingController();
  final _kontakC = TextEditingController();

  final List<String> _jenisUsaha = [
    'Makanan & Minuman',
    'Fashion',
    'Elektronik',
    'Furnitur',
    'Lainnya',
  ];
  String _selectedJenis = 'Makanan & Minuman';
  bool _agree = false;

  @override
  void dispose() {
    _namaTokoC.dispose();
    _namaPemilikC.dispose();
    _alamatC.dispose();
    _kontakC.dispose();
    super.dispose();
  }

  String? _required(String? v, String label) =>
      (v == null || v.trim().isEmpty) ? '$label wajib diisi' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda harus menyetujui syarat dan ketentuan')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: '/home'),
        builder: (_) => HomePage(storeName: _namaTokoC.text.trim()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Pemilik Toko'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaTokoC,
                decoration: const InputDecoration(labelText: 'Nama Toko'),
                validator: (v) => _required(v, 'Nama Toko'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _namaPemilikC,
                decoration: const InputDecoration(labelText: 'Nama Pemilik'),
                validator: (v) => _required(v, 'Nama Pemilik'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedJenis,
                decoration: const InputDecoration(labelText: 'Jenis Usaha'),
                items: _jenisUsaha
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedJenis = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _alamatC,
                decoration: const InputDecoration(labelText: 'Alamat Toko'),
                validator: (v) => _required(v, 'Alamat Toko'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kontakC,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Kontak'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Kontak wajib diisi';
                  if (!RegExp(r'^[0-9]{8,15}$').hasMatch(v.trim())) {
                    return 'Kontak harus berupa angka (8-15 digit)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (v) => setState(() => _agree = v ?? false),
                  ),
                  const Expanded(
                    child: Text('Saya menyetujui syarat dan ketentuan'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: _submit,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
