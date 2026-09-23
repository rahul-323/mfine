import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class MfineDocumentService {
  // ===========================================================================
  // DOWNLOAD PRESCRIPTION
  // ===========================================================================

  static Future<String> downloadPrescription() async {
    final assetBytes = await rootBundle.load('assets/files/prescription .pdf');
    final bytes = assetBytes.buffer.asUint8List(
      assetBytes.offsetInBytes,
      assetBytes.lengthInBytes,
    );

    Directory directory;
    if (Platform.isAndroid) {
      directory = await getDownloadsDirectory() ??
          await getApplicationDocumentsDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final file = File('${directory.path}/prescription .pdf');

    await file.writeAsBytes(bytes, flush: true);

    return file.path;
  }

  // ===========================================================================
  // SHARE PRESCRIPTION
  // ===========================================================================

  static Future<String> sharePrescription({
    String fileName = 'Disha Prescription.pdf',
  }) async {
    final List<int> bytes;
    if (fileName == 'Disha Prescription.pdf') {
      final assetBytes =
          await rootBundle.load('assets/files/Disha Prescription.pdf');
      bytes = assetBytes.buffer.asUint8List(
        assetBytes.offsetInBytes,
        assetBytes.lengthInBytes,
      );
    } else {
      bytes = await _buildDecemberPrescriptionPdf();
    }
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');

    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: fileName,
    );

    return file.path;
  }

  static Future<List<int>> _buildDecemberPrescriptionPdf() async {
    final document = pw.Document();
    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(42),
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'mfine',
              style: pw.TextStyle(
                fontSize: 22,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.cyan800,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text('Digital Prescription - 02 Dec 2025'),
            pw.SizedBox(height: 28),
            pw.Text('Patient: Disha Sankneniwar'),
            pw.Text('Doctor: Dr. Prem Prakash Bansal'),
            pw.Text('Speciality: Pulmonologist'),
            pw.SizedBox(height: 24),
            pw.Text(
              'Prescription',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 8),
            pw.Text('1. Azee 500 - 1 tablet after food'),
            pw.Text('2. Cough syrup - 5 ml twice daily'),
            pw.Text('3. Vitamin C - 1 tablet in the morning'),
            pw.SizedBox(height: 24),
            pw.Text(
              'Advice: Rest well, stay hydrated, and follow up if symptoms persist.',
            ),
          ],
        ),
      ),
    );
    return document.save();
  }

  // ===========================================================================
  // DOWNLOAD INVOICE
  // ===========================================================================

  static Future<String> downloadInvoice(
    String invoiceNumber,
    String date,
    int amount,
  ) async {
    final bytes = await _buildInvoicePdf(
      invoiceNumber: invoiceNumber,
      date: date,
      amount: amount,
      product: amount == 249
          ? 'MFine ONE Membership - 3 months'
          : 'Online Consultation',
      priceBeforeTax: amount == 249 ? '211.02' : '384.75',
      tax: amount == 249 ? '37.98' : '69.25',
    );

    final directory = await getApplicationDocumentsDirectory();

    final file = File(
      '${directory.path}/$invoiceNumber.pdf',
    );

    await file.writeAsBytes(
      bytes,
      flush: true,
    );

    return file.path;
  }

  // ===========================================================================
  // SHARE INVOICE
  // ===========================================================================

  static Future<String> shareInvoice(
    String invoiceNumber,
    String date,
    int amount,
  ) async {
    final bytes = await _buildInvoicePdf(
      invoiceNumber: invoiceNumber,
      date: date,
      amount: amount,
      product: amount == 249
          ? 'MFine ONE Membership - 3 months'
          : 'Online Consultation',
      priceBeforeTax: amount == 249 ? '211.02' : '384.75',
      tax: amount == 249 ? '37.98' : '69.25',
    );

    final directory = await getTemporaryDirectory();

    final file = File(
      '${directory.path}/$invoiceNumber.pdf',
    );

    await file.writeAsBytes(
      bytes,
      flush: true,
    );

    await Share.shareXFiles(
      [
        XFile(file.path),
      ],
      text: 'mfine invoice $invoiceNumber',
    );

    return file.path;
  }

  // ===========================================================================
  // BUILD PRESCRIPTION PDF
  // ===========================================================================

  static Future<List<int>> _buildPrescriptionPdf() async {
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(42, 42, 42, 42),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'mfine',
                        style: pw.TextStyle(
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.cyan800,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'Digital Prescription',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.cyan50,
                      borderRadius: const pw.BorderRadius.all(
                        pw.Radius.circular(12),
                      ),
                    ),
                    child: pw.Text(
                      'Valid for 30 days',
                      style: pw.TextStyle(
                        color: PdfColors.cyan800,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 28),
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(18),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey100,
                  borderRadius: const pw.BorderRadius.all(
                    pw.Radius.circular(16),
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Dr. Prem Prakash',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'MBBS, MD (General Medicine)',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                    pw.SizedBox(height: 12),
                    pw.Text(
                      'Clinic: MFine Care Center',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                    pw.Text(
                      'Date: 07 Sep 2026',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 28),
              pw.Text(
                'Patient',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('Disha Sankneniwar',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.Text('Age: 28 years', style: const pw.TextStyle(fontSize: 12)),
              pw.Text('ID: MF-2026-1842',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 26),
              pw.Text(
                'Medication',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey700),
                columnWidths: const {
                  0: pw.FlexColumnWidth(3),
                  1: pw.FlexColumnWidth(1),
                  2: pw.FlexColumnWidth(1),
                },
                children: [
                  _pdfRow('Medicine', 'Dosage', 'Timing', bold: true),
                  _pdfRow('Azee 500', '1 tablet', 'After food'),
                  _pdfRow('Cough Syrup', '5 ml', 'Twice daily'),
                  _pdfRow('Vitamin C', '1 tablet', 'Morning'),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                'Instructions',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '1. Take medicines as prescribed and complete the full course.\n2. Stay hydrated and avoid heavy exertion for the next 3 days.\n3. Follow up if symptoms persist or worsen.',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.Spacer(),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Doctor Signature',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                    pw.SizedBox(height: 22),
                    pw.Text(
                      'Dr. Prem Prakash',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return document.save();
  }

  // ===========================================================================
  // BUILD PDF
  // ===========================================================================

  static Future<List<int>> _buildInvoicePdf({
    required String invoiceNumber,
    required String date,
    required int amount,
    required String product,
    required String priceBeforeTax,
    required String tax,
  }) async {
    final document = pw.Document();

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(
          48,
          52,
          48,
          48,
        ),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // =============================================================
              // HEADER
              // =============================================================

              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Powered By mfine',
                        style: const pw.TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      pw.SizedBox(height: 30),
                      pw.Container(
                        width: 52,
                        height: 52,
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.cyan800,
                          shape: pw.BoxShape.circle,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'mfine',
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.Spacer(),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'TAX INVOICE',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 18),
                      pw.Text(
                        'Invoice # $invoiceNumber',
                        style: const pw.TextStyle(
                          fontSize: 9,
                        ),
                      ),
                      pw.Text(
                        'Invoice Date $date',
                        style: const pw.TextStyle(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 25),

              // =============================================================
              // BILLING
              // =============================================================

              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Billing From',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'mfine Healthcare',
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Address',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          'Billing To',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Disha Sankneniwar',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 32),

              // =============================================================
              // PRODUCT TABLE
              // =============================================================

              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColors.grey700,
                ),
                columnWidths: const {
                  0: pw.FlexColumnWidth(5.5),
                  1: pw.FlexColumnWidth(0.8),
                  2: pw.FlexColumnWidth(1),
                },
                children: [
                  _pdfRow(
                    'Product',
                    'Qty',
                    'Price',
                    bold: true,
                  ),
                  _pdfRow(
                    product,
                    '1',
                    priceBeforeTax,
                    bold: true,
                  ),
                ],
              ),

              pw.SizedBox(height: 8),

              _pdfTotal(
                'Total',
                priceBeforeTax,
              ),

              _pdfTotal(
                'Tax (18.00 %)',
                tax,
              ),

              _pdfTotal(
                'Amount Payable',
                '₹$amount',
              ),

              pw.SizedBox(height: 12),

              pw.Text(
                'SAC code : 998319',
              ),

              pw.Text(
                'Place of supply - Karnataka (29)',
              ),

              pw.SizedBox(height: 42),

              pw.Text(
                'NOTES',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 4),

              pw.Text(
                'The invoice is a computer generated invoice, hence no signature is required',
                style: const pw.TextStyle(
                  fontSize: 8,
                ),
              ),
            ],
          );
        },
      ),
    );

    return document.save();
  }

  // ===========================================================================
  // PDF TABLE ROW
  // ===========================================================================

  static pw.TableRow _pdfRow(
    String a,
    String b,
    String c, {
    bool bold = false,
  }) {
    final style = pw.TextStyle(
      fontSize: 9,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
    );

    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            a,
            style: style,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            b,
            style: style,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(5),
          child: pw.Text(
            c,
            style: style,
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // PDF TOTAL ROW
  // ===========================================================================

  static pw.Widget _pdfTotal(
    String label,
    String value,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Text(
              label,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(width: 40),
          pw.SizedBox(
            width: 50,
            child: pw.Text(
              value,
              textAlign: pw.TextAlign.right,
              style: pw.TextStyle(
                fontSize: 9,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
