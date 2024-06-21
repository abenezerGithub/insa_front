import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insa_report/models/attachments.dart';
import 'package:insa_report/models/http_exception.dart';
import 'package:insa_report/models/report.dart';
import 'package:insa_report/providers/reports_provider.dart';
import 'package:insa_report/providers/user_provider.dart';
import 'package:insa_report/services/connection.dart';
import 'package:insa_report/services/http.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:insa_report/widgets/form.dart';
import 'package:insa_report/widgets/option.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ReportScreen extends ConsumerStatefulWidget {
  const ReportScreen({super.key});

  @override
  ConsumerState<ReportScreen> createState() => _ReportScreenState();
}

const List<String> lists = ["የታቀደ", "የተፈፅመ"];

class _ReportScreenState extends ConsumerState<ReportScreen> {
  bool loading = false;

  late String reportType;
  DateTime? date_of_crime;

  final reportDescription = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isOccured = false;

  void setOccurence(bool value) {
    setState(() {
      isOccured = value;
    });
  }

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _attachmentFiles;

  Future<void> _pickImages() async {
    final List<XFile> selectedFiles = await _picker.pickMultiImage();
    setState(() {
      _attachmentFiles = selectedFiles;
    });
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      final isConnected = await Connection.isConnected();
      if (!isConnected) {
        if (mounted) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message: "Please check you internet connection.",
              messagePadding: EdgeInsets.symmetric(horizontal: 20),
              textScaleFactor: 0.88,
            ),
          );
        }
        return;
      }

      setState(() {
        loading = true;
      });
      // Use the formData in your API request
      try {
        final report = Report.fromMap({
          "id": 1,
          "report_type": isOccured ? "የተፈፅመ" : "የታቀደ",
          "report_description": reportDescription.text,
          "is_resolved": false,
          "location_url": "",
          "seen": false,
          "date_of_crime": date_of_crime?.toString(),
          "date_reported": DateTime.now().toString(),
          "attachments":
              _attachmentFiles?.map((e) => {"id": 0, "image": e.path}).toList(),
        });
        final user = await ref.read(userProvider.future);
        if (user != null) {
          final resp = await HTTPServices.submitReport(
              report: report, path: "api/report/add/", user: user);

          if (resp.statusCode != 200 && resp.statusCode != 201) {
            final message =
                jsonDecode(await resp.stream.bytesToString())["detail"];
            throw HttpStatusException(message, resp.statusCode);
          }

          final parsedReport =
              jsonDecode(await resp.stream.bytesToString())["report"];
          final savedReport = Report.fromMap(parsedReport);
          setState(() {
            loading = false;
          });

          if (mounted) {
            ref.invalidate(reportsProvider);
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: "Report submitted successfully",
                messagePadding: EdgeInsets.symmetric(horizontal: 20),
                textScaleFactor: 0.88,
              ),
            );
            Navigator.of(context).pop(report);
          }
        } else {
          throw Exception("User session expired. Please login again.");
        }
      } on TimeoutException catch (err) {
        if (mounted) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message: err.message ?? "Connection timeout please try again.",
              messagePadding: const EdgeInsets.symmetric(horizontal: 20),
              textScaleFactor: 0.88,
            ),
          );
        }
      } on HttpStatusException catch (err) {
        setState(() {
          loading = false;
        });

        if (mounted) {
          if (err.statusCode.toString().startsWith("4")) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: err.message,
                messagePadding: const EdgeInsets.symmetric(horizontal: 20),
                textScaleFactor: 0.88,
              ),
            );
          }
        }
      } catch (err) {
        setState(() {
          loading = false;
        });
        if (mounted) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message:
                  "Something went wrong. Please try again.",
              messagePadding: EdgeInsets.symmetric(horizontal: 20),
              textScaleFactor: 0.88,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "የጥቆማ ማቅረቢያ ቅፅ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14.5,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins",
          ),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Text(
                      "የጥቆማው አይነት *",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: OccurenceOption(
                          label: "የታቀደ",
                          isOccured: isOccured,
                          setOccurence: setOccurence,
                          value: false,
                        )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: OccurenceOption(
                          label: "የተፈፅመ",
                          isOccured: isOccured,
                          setOccurence: setOccurence,
                          value: true,
                        ))
                      ],
                    ),
                  ),
                  Forms(
                    label: "የጥቆማው ዝርዝር ጉዳይ *",
                    isnum: false,
                    controller: reportDescription,
                    validtor: (value) {
                      if (value == null || value.isEmpty) {
                        return "የጥቆማው ዝርዝር ጉዳይ መሙላት ያስፈልጋል ።";
                      }
                      if (value.split(" ").length < 10) {
                        return "የጥቆማው ዝርዝር ጉዳይ ቢያንስ በ10 ቃላት ይግለጹ።";
                      }
                      return null;
                    },
                  ),
                  isOccured
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 12, 10, 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Material(
                                  color:
                                      const Color.fromARGB(255, 222, 219, 219),
                                  child: InkWell(
                                    onTap: () async {
                                      final DateTime? picked1 =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2100),
                                      );
                                      setState(() {
                                        date_of_crime = picked1;
                                      });
                                    },
                                    splashColor: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.3),
                                    overlayColor:
                                        MaterialStateProperty.all<Color?>(
                                            Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.3)),
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text("ችግር የተፈፀመበት ቀን *"),
                                                Icon(Icons.date_range)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              date_of_crime != null
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                          "${date_of_crime?.day}/${date_of_crime?.month}/${date_of_crime?.year}"),
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      : Container(),

                  // isOccured
                  //     ? Forms(
                  //         label: "ችግር የተፈፀመበት ቦታ",
                  //         maxline: 3,
                  //         isnum: false,
                  //         controller: insidentplace,
                  //         req: false,
                  //       )
                  //     : Container(),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 12, 10, 2),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        color: const Color.fromARGB(255, 222, 219, 219),
                        child: InkWell(
                          onTap: () {
                            _pickImages();
                          },
                          splashColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3),
                          overlayColor: MaterialStateProperty.all<Color?>(
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3)),
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("ተያያዥ ማስረጃ ዶክመንት"),
                                      Icon(Icons.upload)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  _attachmentFiles != null &&
                          _attachmentFiles?.length != null &&
                          _attachmentFiles?.isNotEmpty == true
                      ? Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            left: 8,
                            top: 8,
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: (_attachmentFiles?.length ?? 0) < 4
                                      ? _attachmentFiles
                                              ?.map((e) => Text(e.name))
                                              .toList() ??
                                          []
                                      : [
                                          Text(
                                              "${_attachmentFiles?.length ?? 0} images selected")
                                        ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _attachmentFiles = [];
                                      // files = [];
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove_circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),

                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 10),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            overlayColor: MaterialStateProperty.all<Color?>(
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.3),
                            ),
                            backgroundColor: loading
                                ? MaterialStateProperty.all(Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.4))
                                : MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: loading == true ? null : _submitReport,
                          label: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 25.0),
                            child: Text(
                              "ጠቁም/ላክ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          icon: loading
                              ? LoadingAnimationWidget.staggeredDotsWave(
                                  color: Colors.white,
                                  size: 20,
                                )
                              : Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
