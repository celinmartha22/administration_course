import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/formating.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/paket_kursus.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_add_page.dart';
import 'package:administration_course/pages/paket_kursus/paket_kursus_detail_page.dart';
import 'package:administration_course/widgets/confirm_pop_up.dart';
import 'package:administration_course/widgets/page/notification_blank_data_result.dart';
import 'package:administration_course/widgets/page/notification_data_not_found.dart';
import 'package:administration_course/widgets/page/notification_error_data.dart';
import 'package:administration_course/widgets/page/notification_no_data.dart';
import 'package:administration_course/widgets/welcome_login_signup/rounded_input_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PaketKursusPage extends StatefulWidget {
  static const routeName = '/paket_kursus';
  const PaketKursusPage({Key? key}) : super(key: key);

  @override
  State<PaketKursusPage> createState() => _PaketKursusPageState();
}

class _PaketKursusPageState extends State<PaketKursusPage> {
  late List<PaketKursus> listPaketKursus;
  String searchString = "";
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(child: _buildAllPaketKursusList(context, "search")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(PaketKursusAddFormPage.routeName,
              arguments: PaketKursus(
                  idPaketKursus: '',
                  namaPaketKursus: '',
                  harga: 0,
                  berlakuSelama: '',
                  jenjang: '',
                  keterangan: ''));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<PaketKursus> _searchPaketKursus(List<PaketKursus>? paketKursus) {
    if (searchString.isNotEmpty) {
      return paketKursus
              ?.where((element) => element.namaPaketKursus
                  .toLowerCase()
                  .contains(searchString.toLowerCase()))
              .toList() ??
          <PaketKursus>[];
    }
    return paketKursus ?? <PaketKursus>[];
  }

  Widget _buildAllPaketKursusList(BuildContext context, String key) {
    return Consumer<PaketKursusProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listPaketKursus = state.result;
          final result = _searchPaketKursus(listPaketKursus);
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
                                  'Delete Kursus ${result[index].namaPaketKursus}');
                              confirmPopUp(
                                  context,
                                  "delete_kursus",
                                  result[index].idPaketKursus,
                                  "Hapus",
                                  "Hapus 1 data kursus?",
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
                              'Edit Kursus ${result[index].namaPaketKursus} on Press');
                          Navigator.of(context).pushNamed(
                              PaketKursusAddFormPage.routeName,
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
                  child: _buildPaketKursusItem(
                      context,
                      key,
                      result.length,
                      result[index].idPaketKursus,
                      result[index].namaPaketKursus,
                      result[index].harga.toString(),
                      result[index].berlakuSelama,
                      result[index].jenjang,
                      result[index].keterangan),
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

  Widget _buildPaketKursusItem(
      BuildContext context,
      String key,
      int total,
      String idPaketKursus,
      String namaPaketKursus,
      String harga,
      String berlakuSelama,
      String jenjang,
      String keterangan) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(PaketKursusDetailPage.routeName,
            arguments: idPaketKursus);
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
                    tag: key + idPaketKursus.toString(),
                    child: const CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.book,
                        color: kTextWhiteColor,
                      ),
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
                              children: [
                                Text(
                                  namaPaketKursus,
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
                                        Icons.school,
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
                                        jenjang,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Flexible(
                                      child: Icon(
                                        Icons.attach_money,
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
                                        "Rp ${formatNumber(
                                          harga.toString().replaceAll(',', ''),
                                        ).replaceAll(",", ".")}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: kDefaultPadding / 8,
                      ),
                      Text(
                        keterangan,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
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
