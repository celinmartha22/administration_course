import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/widgets/form/form_button.dart';
import 'package:administration_course/widgets/form/form_dropdown_button.dart';
import 'package:administration_course/widgets/form/form_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JenisKasAddFormPage extends StatefulWidget {
  static const routeName = '/jenis_kas_add_update';
  const JenisKasAddFormPage({super.key, required this.data});
  final JenisKas data;

  @override
  State<JenisKasAddFormPage> createState() => _JenisKasAddFormPageState();
}

class _JenisKasAddFormPageState extends State<JenisKasAddFormPage> {
  List<String> listStatus = <String>['Kas Keluar', 'Kas Masuk'];

  final _namaJenisKasController = TextEditingController();
  final _statusController = TextEditingController();
  Color pickerColor = kSecondaryColor;
  Color currentColor = kSecondaryColor;
  Icon? _icon = const Icon(Icons.playlist_add_check);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data.idJenisKas != '') {
      setData();
    }
    super.initState();
  }

  void setData() {
    _namaJenisKasController.text = widget.data.namaJenisKas;
    _statusController.text = widget.data.status;
    pickerColor = Color(widget.data.warna);
    currentColor = Color(widget.data.warna);
    _icon = Icon(IconData(
        int.parse(
          widget.data.ikon,
        ),
        fontFamily: 'MaterialIcons'));
  }

  Future<void> goAddOrUpdate(
      String nama, String status, int warna, String ikon) async {
    debugPrint(
        'ADD JenisKas => JenisKas: $nama, status: $status, warna: $warna');
    String id = "J${DateFormat("yyyy.MMdd.HHmmss").format(DateTime.now())}";
    final dataJenisKas = JenisKas(
        idJenisKas: widget.data.idJenisKas == '' ? id : widget.data.idJenisKas,
        namaJenisKas: nama,
        status: status == "" ? 'Kas Keluar' : status,
        warna: warna,
        ikon: ikon);
    if (_formKey.currentState!.validate()) {
      if (widget.data.idJenisKas == '') {
        await Provider.of<JenisKasProvider>(context, listen: false)
            .addJenisKas(dataJenisKas);
      } else {
        await Provider.of<JenisKasProvider>(context, listen: false)
            .updateJenisKas(dataJenisKas);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Berhasil menyimpan data Kategori"),
            backgroundColor: Colors.green,));
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: const Text("Gagal menyimpan data Kategori"),
          backgroundColor: Colors.red.shade300,));
    }
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    setState(() {
      if (icon != null) {
        _icon = Icon(icon);
      }
    });
    debugPrint('Picked Icon:  $icon');
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
                child:
                    const Icon(Icons.sell, color: Colors.deepPurple, size: 45)),
            const Text(
              "Kategori",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
                "Tambahkan data kategori pengeluaran dan pemasukan keuangan dalam form di bawah ini"),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyFormTextfield(
                      myController: _namaJenisKasController,
                      myFieldName: "Nama Jenis Kas",
                      myIcon: Icons.bookmark,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValidationNote: "Please enter some text",
                      isCurrency: false,
                      myMaxLine: 1,
                      myKeyboardType: TextInputType.text,
                    ),
                    MyFormDropdownButton(
                      listItem: listStatus,
                      myController: _statusController,
                      myFieldName: "Status",
                      myIcon: Icons.sell_outlined,
                      myPrefixIconColor: Colors.deepPurple.shade300,
                      myValue: _statusController.text,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pilih ikon dan warna : ",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0),
                        ),
                        IconButton(
                            iconSize: kDefaultPadding * 2,
                            onPressed: _pickIcon,
                            icon:
                                _icon ?? const Icon(Icons.playlist_add_check)),
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text('Pick a category color'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    color: pickerColor,
                                    onColorChanged: changeColor,
                                    heading: const Text('Select color'),
                                    subheading:
                                        const Text('Select color shade'),
                                    wheelSubheading: const Text(
                                        'Selected color and its shades'),
                                    pickersEnabled: const <ColorPickerType,
                                        bool>{
                                      ColorPickerType.primary: true,
                                      ColorPickerType.accent: true,
                                      ColorPickerType.custom: true,
                                      ColorPickerType.wheel: true,
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  CupertinoButton(
                                    child: const Text('Got it'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Container(
                              width: 90,
                              height: 40,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(kDefaultPadding / 3)),
                                color: pickerColor,
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 2),
                              )),
                        ),
                      ],
                    ),
                    MyFormButton(
                      onPress: () {
                        goAddOrUpdate(
                            _namaJenisKasController.text,
                            _statusController.text,
                            pickerColor.value,
                            _icon!.icon!.codePoint.toString());
                      },
                      textButton:
                          widget.data.idJenisKas != '' ? 'simpan' : 'tambah',
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
