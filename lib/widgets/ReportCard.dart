import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insa_report/models/report.dart';

class ReportCard extends StatelessWidget {
  final Report report;
  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Material(
          color: Colors.grey[50],
          child: InkWell(
            overlayColor: MaterialStateProperty.all(
                Theme.of(context).colorScheme.primary.withOpacity(.1)),
            splashColor: Theme.of(context).colorScheme.primary.withOpacity(.1),
            onTap: () {
              Navigator.pushNamed(context, '/report-detail',
                  arguments: {"id": report.id});
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary.withOpacity(.1),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Report Type: ",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: report.report_type.substring(
                                  0,
                                  report.report_type.length < 30
                                      ? report.report_type.length
                                      : 30) +
                              (report.report_type.length < 30 ? "" : "..."))
                    ], style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Report Description: \n",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: report.report_description.substring(
                                0,
                                report.report_description.length < 100
                                    ? report.report_description.length
                                    : 100) +
                            (report.report_description.length < 100
                                ? ""
                                : "..."),
                      )
                    ], style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "Report Attachments: ",
                        style: TextStyle(
                            fontFamily: "Poppins", fontWeight: FontWeight.bold),
                      ),
                      const WidgetSpan(
                          child: Icon(
                        Icons.attachment,
                        size: 20,
                      )),
                      TextSpan(
                          text:
                              "\n${report.attachments == null ? "no attachments" : "${report.attachments?.length} attachments"} ")
                    ], style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    "Report Status",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "Seen ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(
                              report.seen
                                  ? Icons.check_outlined
                                  : Icons.pending_outlined,
                              size: 20,
                            ),
                          ),
                        ], style: Theme.of(context).textTheme.bodyMedium),
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Resolved ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins",
                                color: report.is_resolved
                                    ? Color.fromARGB(255, 41, 233, 47)
                                    : Colors.amber),
                          ),
                          WidgetSpan(
                            child: Icon(
                              report.is_resolved
                                  ? Icons.check_outlined
                                  : Icons.pending_outlined,
                              size: 20,
                              color: report.is_resolved
                                  ? Color.fromARGB(255, 41, 233, 47)
                                  : Colors.amber,
                            ),
                          ),
                        ], style: Theme.of(context).textTheme.bodyMedium),
                      )
                    ],
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
