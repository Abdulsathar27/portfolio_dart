import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

/// Triggers a file download in the browser.
///
/// This function creates an invisible anchor element, sets the href to the [url],
/// sets the download attribute to [filename], appends it to the DOM, clicks it,
/// and then removes it. This forces the browser to download the file instead
/// of opening it in a new tab (where supported).
void downloadFile(String url, {String? filename}) {
  // Create an anchor element
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'; // Fallback for some browsers

  // Set the download attribute if a filename is provided
  if (filename != null) {
    anchor.download = filename;
  }

  // Append to the DOM (required for Firefox)
  html.document.body?.children.add(anchor);

  // Trigger the click
  anchor.click();

  // Remove from the DOM
  html.document.body?.children.remove(anchor);
}

/// Opens a file or URL in a new browser tab.
///
/// This uses [launchUrl] from url_launcher to open the [url] in a new tab.
/// This is useful for viewing PDFs or external links without leaving the app.
Future<void> openFileInNewTab(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, webOnlyWindowName: '_blank');
  } else {
    // Fallback or error handling
    html.window.open(url, '_blank');
  }
}
