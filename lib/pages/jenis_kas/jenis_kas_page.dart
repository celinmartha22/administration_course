import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/jenis_kas.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_add_page.dart';
import 'package:administration_course/pages/jenis_kas/jenis_kas_detail_page.dart';
import 'package:administration_course/widgets/confirm_pop_up.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:administration_course/widgets/welcome_login_signup/rounded_input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class JenisKasPage extends StatefulWidget {
  static const routeName = '/jenis_kas';
  const JenisKasPage({Key? key}) : super(key: key);

  @override
  State<JenisKasPage> createState() => _JenisKasPageState();
}

class _JenisKasPageState extends State<JenisKasPage> {
  late List<JenisKas> listJenisKas;
  String searchString = "";
  final searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: RoundedInputTextfield(
              change: (value) {
                setState(() {
                  searchString = value;
                });
              },
              icon: Icons.search,
              hintText: "Cari berdasarkan nama",
              controller: searchController,
              obscureTextValue: false,
              action: TextInputAction.done,
              backColor: kPrimaryColor,
              shadowColor: kBackgroundColor,
              offset: const Offset(4, 2),
              cursorColor: kBackgroundColor,
              iconColor: kBackgroundColor,
              textColor: kBackgroundColor,
              hinttextColor: kSecondaryColor,
              myValidationNote: "",
            ),
          ),
          const SizedBox(
            height: kDefaultPadding / 6,
          ),
          Expanded(child: _buildAllJenisKasList(context, "search")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(JenisKasAddFormPage.routeName,
              arguments: JenisKas(
                  idJenisKas: '',
                  namaJenisKas: '',
                  status: '',
                  warna: 0,
                  ikon: ''));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<JenisKas> _searchJenisKas(List<JenisKas>? jenisKas) {
    if (searchString.isNotEmpty) {
      return jenisKas
              ?.where((element) => element.namaJenisKas
                  .toLowerCase()
                  .contains(searchString.toLowerCase()))
              .toList() ??
          <JenisKas>[];
    }
    return jenisKas ?? <JenisKas>[];
  }

  Widget _buildAllJenisKasList(BuildContext context, String key) {
    return Consumer<JenisKasProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listJenisKas = state.result;
          final result = _searchJenisKas(listJenisKas);
          if (result.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: UniqueKey(),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        autoClose: false,
                        onPressed: (context) {
                          final slidable = Slidable.of(context);
                          slidable?.dismiss(
                            ResizeRequest(const Duration(milliseconds: 300),
                                () {
                              debugPrint(
                                  'Delete Kategori ${result[index].namaJenisKas}');
                              confirmPopUp(
                                  context,
                                  "delete_kategori",
                                  result[index].idJenisKas,
                                  "Hapus",
                                  "Hapus 1 data kategori keuangan?",
                                  "Ya",
                                  "Batal");
                            }),
                          );
                        },
                        backgroundColor: kErrorBorderColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever,
                        label: 'Delete',
                        borderRadius: const BorderRadius.all(
                            Radius.circular(kDefaultPadding)),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          debugPrint(
                              'Edit Kategori ${result[index].namaJenisKas} on Press');
                          Navigator.of(context).pushNamed(
                              JenisKasAddFormPage.routeName,
                              arguments: result[index]);
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        borderRadius: const BorderRadius.all(
                            Radius.circular(kDefaultPadding)),
                      ),
                    ],
                  ),
                  child: _buildjenisKasItem(
                      context,
                      key,
                      result.length,
                      result[index].idJenisKas,
                      result[index].namaJenisKas,
                      result[index].status,
                      result[index].ikon,
                      result[index].warna),
                );
              },
            );
          } else {
            return const NotificationBlankDataResult();
          }
        } else if (state.state == ResultStateDb.noData) {
          return const NotificationNoData();
        } else if (state.state == ResultStateDb.error) {
          return const NotificationErrorData();
        } else {
          return const NotificationDataNotFound();
        }
      },
    );
  }

  Widget _buildjenisKasItem(BuildContext context, String key, int total,
      String id, String nama, String status, String ikon, int warna) {
    final Color categoryColor = Color(warna);
    final IconData categoryIcon = IconData(int.parse(ikon),
        fontFamily:
            'MaterialIcons'); //fontFamily: 'MaterialIcons'  'CupertinoIcons'
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(JenisKasDetailPage.routeName, arguments: id);
      },
      child: Card(
        margin: const EdgeInsets.all(3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: kBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  height: 10.h,
                  child: Hero(
                    tag: key + id.toString(),
                    child: CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(categoryIcon),
                    ),
                  )),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  nama,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: kPrimaryColor,
                                          letterSpacing: 0),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Icon(
                                        Icons.bookmark,
                                        size:
                                            MediaQuery.of(context).size.height /
                                                40,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        status,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    width: 100,
                                    height: 20,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(kDefaultPadding)),
                                      color: categoryColor,
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          width: 2),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding / 8,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
