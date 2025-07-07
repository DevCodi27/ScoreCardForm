import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;

Future<void> downloadPdf(pw.Document pdf) async {
  final bytes = await pdf.save();
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute("download", "scorecard.pdf")
    ..click();

  html.Url.revokeObjectUrl(url);
}
