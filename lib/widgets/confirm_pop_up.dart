import 'package:administration_course/constants/style.dart';
import 'package:administration_course/data/provider/asisten_provider.dart';
import 'package:administration_course/data/provider/jenis_kas_provider.dart';
import 'package:administration_course/data/provider/paket_kursus_provider.dart';
import 'package:administration_course/data/provider/siswa_provider.dart';
import 'package:administration_course/data/provider/trans_kas_keluar_provider.dart';
import 'package:administration_course/data/provider/trans_kas_masuk_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

confirmPopUp(BuildContext context, String key, String idItem, String titleText,
    String contentText, String yesText, String noText) {
  debugPrint("Confirmation => $titleText");
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding))),
          title: Text(
            titleText,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: kTextBlackColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  contentText,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: kContainerColor, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                yesText,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                switch (key) {
                  case "edit_kursus":
                    break;
                  case "delete_kursus":
                    Provider.of<PaketKursusProvider>(context, listen: false)
                        .deletePaketKursus(idItem);
                    break;
                  case "edit_siswa":
                    break;
                  case "delete_siswa":
                    Provider.of<SiswaProvider>(context, listen: false)
                        .deleteSiswa(idItem);
                    break;
                  case "edit_asisten":
                    break;
                  case "delete_asisten":
                    Provider.of<AsistenProvider>(context, listen: false)
                        .deleteAsisten(idItem);
                    break;
                  case "edit_kategori":
                    break;
                  case "delete_kategori":
                    Provider.of<JenisKasProvider>(context, listen: false)
                        .deleteJenisKas(idItem);
                    break;
                  case "edit_kas_masuk":
                    break;
                  case "delete_kas_masuk":
                    Provider.of<TransKasMasukProvider>(context, listen: false)
                        .deleteTransKas(idItem);
                    break;
                  case "edit_kas_keluar":
                    break;
                  case "delete_kas_keluar":
                    Provider.of<TransKasKeluarProvider>(context, listen: false)
                        .deleteTransKas(idItem);
                    break;
                  default:
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                noText,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: kPrimaryColor, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
