import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_radio.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AsistenAddFormPage extends StatefulWidget {
  static const String routeName = '/asisten_add_update';
  const AsistenAddFormPage({super.key, required this.data});
  final Asisten data;

  @override
  State<AsistenAddFormPage> createState() => _AsistenAddFormPageState();
}

class _AsistenAddFormPageState extends State<AsistenAddFormPage> {
  List<String> listKelas = <String>['SD', 'SMP', 'SMA/SMK'];

  Gender? _gender;

  final _namaAsistenController = TextEditingController();
  final _jabatanController = TextEditingController();
  final _nomorHPController = TextEditingController();
  final _alamatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idAsisten != '') {
      setData();
    }
    super.initState();
  }

  void setData() {
    _namaAsistenController.text = widget.data.namaAsisten;
    _jabatanController.text = widget.data.jabatan;
    _nomorHPController.text = widget.data.nomorHP;
    _alamatController.text = widget.data.alamat;

    _gender = widget.data.jenisKelamin.toLowerCase().contains("perempuan") ||
            widget.data.jenisKelamin.toLowerCase().contains("female")
        ? Gender.female
        : Gender.male;
  }

  Future<void> goAddOrUpdate(String nama, String jabatan, String jenisKelamin,
      String noHP, String alamat) async {
    debugPrint(
        'ADD Asisten => Asisten: $nama, jabatan: $jabatan, jenisKelamin: $jenisKelamin, noHP: $noHP, alamat: $alamat');
    String id = "A${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    final dataAsisten = Asisten(
        idAsisten: widget.data.idAsisten == '' ? id : widget.data.idAsisten,
        namaAsisten: nama,
        jabatan: jabatan,
        alamat: alamat,
        jenisKelamin: jenisKelamin,
        nomorHP: noHP);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idAsisten == '') {
        await Provider.of<AsistenProvider>(context, listen: false)
            .addAsisten(dataAsisten);
      } else {
        await Provider.of<AsistenProvider>(context, listen: false)
            .updateAsisten(dataAsisten);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Asisten"),
            backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Asisten"),
          backgroundColor: Colors.red.shade300,));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5, vertical: defaultPadding),
          children: [
            Container(
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.supervisor_account_rounded,
                    color: Colors.deepPurple, size: 45)),
            const Text(
              "Asisten",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Tambahkan data asisten dalam formulir di bawah ini"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyFormTextfield(
                      myController: _namaAsistenController,
                      myFieldName: "Nama Lengkap",
                      myIcon: Icons.person,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          MyFormRadio(
                              title: "Laki-laki",
                              value: Gender.male,
                              gender: _gender,
                              isSelected: _gender == Gender.male ? true : false,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                          const SizedBox(width: 5),
                          MyFormRadio(
                              title: "Perempuan",
                              value: Gender.female,
                              gender: _gender,
                              isSelected:
                                  _gender == Gender.female ? true : false,
                              onChanged: (value) {
                                setState(() {
                                  _gender = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    MyFormTextfield(
                      myController: _jabatanController,
                      myFieldName: "Jabatan",
                      myIcon: Icons.workspace_premium,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormTextfield(
                      myController: _alamatController,
                      myFieldName: "Alamat",
                      myIcon: Icons.home,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 3,
                      myKeyboardType: TextInputType.streetAddress,
                    ),
                    MyFormTextfield(
                      myController: _nomorHPController,
                      myFieldName: "No.Telp/HP",
                      myIcon: Icons.phone,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.phone,
                    ),
                    MyFormButton(
                      onPress: () {
                        goAddOrUpdate(
                            _namaAsistenController.text,
                            _jabatanController.text,
                            _gender.toString().toLowerCase().contains("female")
                                ? "Perempuan"
                                : "Laki-laki",
                            _nomorHPController.text,
                            _alamatController.text);
                      },
                      textButton:
                          widget.data.idAsisten != '' ? 'simpan' : 'tambah',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
