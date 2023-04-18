import 'package:administration_course/constants/enum.dart';
import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/model/asisten.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/pages/asisten/asisten_add_page.dart';
import 'package:administration_course/pages/asisten/asisten_detail_page.dart';
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

class AsistenPage extends StatefulWidget {
  static const routeName = '/asisten';
  const AsistenPage({Key? key}) : super(key: key);

  @override
  State<AsistenPage> createState() => _AsistenPageState();
}

class _AsistenPageState extends State<AsistenPage> {
  late List<Asisten> listAsisten;
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
          Expanded(child: _buildAllasistenList(context, "search")),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AsistenAddFormPage.routeName,
              arguments: Asisten(
                  idAsisten: '',
                  namaAsisten: '',
                  jabatan: '',
                  alamat: '',
                  jenisKelamin: '',
                  nomorHP: ''));
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Asisten> _searchasisten(List<Asisten>? asisten) {
    if (searchString.isNotEmpty) {
      return asisten
              ?.where((element) => element.namaAsisten
                  .toLowerCase()
                  .contains(searchString.toLowerCase()))
              .toList() ??
          <Asisten>[];
    }
    return asisten ?? <Asisten>[];
  }

  Widget _buildAllasistenList(BuildContext context, String key) {
    return Consumer<AsistenProvider>(
      builder: (context, state, _) {
        if (state.state == ResultStateDb.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultStateDb.hasData) {
          listAsisten = state.result;
          final result = _searchasisten(listAsisten);
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
                              debugPrint('Delete Asisten ${result[index].namaAsisten}');
                              confirmPopUp(
                                  context,
                                  "delete_asisten",
                                  result[index].idAsisten,
                                  "Hapus",
                                  "Hapus 1 data asisten?",
                                  "Ya",
                                  "Batal");
                            }),
                          );
                        },
                        backgroundColor: kErrorBorderColor,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever,
                        label: 'Delete',
                        borderRadius:
                            const BorderRadius.all(Radius.circular(kDefaultPadding)),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          debugPrint('Edit Asisten ${result[index].namaAsisten} on Press');
                                                    Navigator.of(context).pushNamed(
                              AsistenAddFormPage.routeName,
                              arguments: result[index]);
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        borderRadius:
                            const BorderRadius.all(Radius.circular(kDefaultPadding)),
                      ),
                    ],
                  ),
                  child: _buildAsistenItem(
                      context,
                      key,
                      result.length,
                      result[index].idAsisten,
                      result[index].namaAsisten,
                      result[index].jabatan,
                      result[index].nomorHP,
                      result[index].jenisKelamin,
                      result[index].alamat),
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

  Widget _buildAsistenItem(
      BuildContext context,
      String key,
      int total,
      String id,
      String nama,
      String jabatan,
      String nomorHP,
      String jenisKelamin,
      String alamat) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AsistenDetailPage.routeName, arguments: id);
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
                    child: const CircleAvatar(
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.person,
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
                                        Icons.workspace_premium,
                                        size: MediaQuery.of(context)
                                                .size
                                                .height /
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
                                        jabatan,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                    Flexible(
                                      child: Icon(
                                        Icons.phone,
                                        size: MediaQuery.of(context)
                                                .size
                                                .height /
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
                                        nomorHP,
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
                        alamat,
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