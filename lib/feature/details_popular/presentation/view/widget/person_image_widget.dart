import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/full_screen_image_dialog.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonImageWidget extends StatefulWidget {
  final String? imageUrl;
  final String personName;

  const PersonImageWidget({
    super.key,
    required this.imageUrl,
    required this.personName,
  });

  @override
  State<PersonImageWidget> createState() => _PersonImageWidgetState();
}

class _PersonImageWidgetState extends State<PersonImageWidget> {
  bool _isDownloading = false;

  Future<void> _downloadImage() async {
    if (widget.imageUrl == null) return;

    setState(() => _isDownloading = true);

    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        _showSnackBar('Storage permission denied', Colors.red);
        return;
      }
      final directory = await getExternalStorageDirectory();
      final fileName = '${widget.personName.replaceAll(' ', '_')}_image.jpg';
      final filePath = '${directory?.path}/$fileName';

      final dio = Dio();
      await dio.download(widget.imageUrl!, filePath);

      _showSnackBar('Image downloaded successfully!', Colors.green);
    } catch (e) {
      _showSnackBar('Download failed: $e', Colors.red);
    } finally {
      setState(() => _isDownloading = false);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showFullScreenImage() {
    if (widget.imageUrl == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => FullScreenImageDialog(
        imageUrl: widget.imageUrl!,
        personName: widget.personName,
        onDownload: _downloadImage,
        isDownloading: _isDownloading,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showFullScreenImage,
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: widget.imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: widget.imageUrl!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const PersonPlaceholderWidget(),
                )
              : const PersonPlaceholderWidget(),
        ),
      ),
    );
  }
}
