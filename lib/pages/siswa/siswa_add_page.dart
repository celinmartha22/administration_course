import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/siswa.dart';
import 'package:administration_course/data/provider/siswa_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_datepicker.dart';
import 'package:administration_course/widgets/form/form_dropdown_button.dart';
import 'package:administration_course/widgets/form/form_radio.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SiswaAddFormPage extends StatefulWidget {
  static const routeName = '/siswa_add_update';
  const SiswaAddFormPage({super.key, required this.data});
  final Siswa data;

  @override
  State<SiswaAddFormPage> createState() => _SiswaAddFormPageState();
}

class _SiswaAddFormPageState extends State<SiswaAddFormPage> {
  List<String> listKelas = <String>['SD/MI', 'SMP/MTs', 'SMA/SMK'];

  Gender? _gender;

  final _namaSiswaController = TextEditingController();
  final _kelasController = TextEditingController();
  final _asalSekolahController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _tanggalMasukController = TextEditingController();
  final _emailController = TextEditingController();
  final _namaAyahController = TextEditingController();
  final _namaIbuController = TextEditingController();
  final _nomorHPController = TextEditingController();
  final _alamatController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idSiswa != '') {
      setData();
    }
    super.initState();
  }

  void setData() {
    _namaSiswaController.text = widget.data.namaSiswa;
    _kelasController.text = widget.data.kelas;
    _asalSekolahController.text = widget.data.asalSekolah;
    _tanggalLahirController.text = widget.data.tanggalLahir;
    _tanggalMasukController.text = widget.data.tanggalMasuk;
    _emailController.text = widget.data.email;
    _namaAyahController.text = widget.data.namaAyah;
    _namaIbuController.text = widget.data.namaIbu;
    _nomorHPController.text = widget.data.nomorHP;
    _alamatController.text = widget.data.alamat;

    _gender = widget.data.jenisKelamin.toLowerCase().contains("perempuan") ||
            widget.data.jenisKelamin.toLowerCase().contains("female")
        ? Gender.female
        : Gender.male;
  }

  Future<void> goAddOrUpdate(
      String nama,
      String kelas,
      String asalSekolah,
      String jenisKelamin,
      String tglLahir,
      String tglMasuk,
      String email,
      String namaAyah,
      String namaIbu,
      String noHP,
      String alamat) async {
    debugPrint(
        'ADD SISWA => Siswa: $nama, kelas: $kelas, asalSekolah: $asalSekolah, jenisKelamin: $jenisKelamin, tglLahir: $tglLahir, tglMasuk: $tglMasuk, email: $email, namaAyah: $namaAyah, namaIbu: $namaIbu, noHP: $noHP, alamat: $alamat');
    String id = "S${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    final dataSiswa = Siswa(
        idSiswa: widget.data.idSiswa == '' ? id : widget.data.idSiswa,
        namaSiswa: nama,
        kelas: kelas == "" ? 'SD/MI' : kelas,
        asalSekolah: asalSekolah,
        jenisKelamin: jenisKelamin,
        tanggalLahir: tglLahir,
        tanggalMasuk: tglMasuk,
        email: email,
        namaAyah: namaAyah,
        namaIbu: namaIbu,
        nomorHP: noHP,
        alamat: alamat);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idSiswa == '') {
        await Provider.of<SiswaProvider>(context, listen: false)
            .addSiswa(dataSiswa);
      } else {
        await Provider.of<SiswaProvider>(context, listen: false)
            .updateSiswa(dataSiswa);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Siswa"),
          backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Siswa"),
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
                child: const Icon(Icons.account_circle,
                    color: Colors.deepPurple, size: 45)),
            const Text(
              "Siswa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("Tambahkan data siswa dalam formulir di bawah ini"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyFormTextfield(
                      myController: _namaSiswaController,
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
                    MyFormDatePicker(
                        myController: _tanggalLahirController,
                        myFieldName: 'Tanggal Lahir',
                        myIcon: Icons.calendar_month,
                        myPrefixIconColor: Colors.deepPurple.shade300,
                        myValidationNote: "Please select date"),
                    MyFormDropdownButton(
                      listItem: listKelas,
                      myController: _kelasController,
                      myFieldName: "Jenjang Sekolah",
                      myIcon: Icons.school,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValue: _kelasController.text,
                    ),
                    MyFormTextfield(
                      myController: _asalSekolahController,
                      myFieldName: "Asal Sekolah",
                      myIcon: Icons.home_work,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormTextfield(
                      myController: _emailController,
                      myFieldName: "Email",
                      myIcon: Icons.email,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.emailAddress,
                    ),
                    MyFormTextfield(
                      myController: _namaAyahController,
                      myFieldName: "Nama Ayah",
                      myIcon: Icons.person_sharp,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.name,
                    ),
                    MyFormTextfield(
                      myController: _namaIbuController,
                      myFieldName: "Nama Ibu",
                      myIcon: Icons.person_2,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.name,
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
                            _namaSiswaController.text,
                            _kelasController.text,
                            _asalSekolahController.text,
                            _gender.toString().toLowerCase().contains("female")
                                ? "Perempuan"
                                : "Laki-laki",
                            _tanggalLahirController.text,
                            DateFormat("yyyy-MM-dd").format(DateTime.now()),
                            _emailController.text,
                            _namaAyahController.text,
                            _namaIbuController.text,
                            _nomorHPController.text,
                            _alamatController.text);
                      },
                      textButton:
                          widget.data.idSiswa != '' ? 'simpan' : 'tambah',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
