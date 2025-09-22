import 'package:first_app/core/theme/app_colors.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/expand_collapse_button.dart';
import 'package:first_app/feature/details_popular/presentation/view/widget/person_section_title_widget.dart';
import 'package:flutter/material.dart';

class PersonBiographyWidget extends StatefulWidget {
  final String biography;

  const PersonBiographyWidget({super.key, required this.biography});

  @override
  State<PersonBiographyWidget> createState() => _PersonBiographyWidgetState();
}

class _PersonBiographyWidgetState extends State<PersonBiographyWidget> {
  bool _isExpanded = false;
  bool _isTextOverflow = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PersonSectionTitleWidget(title: 'Biography'),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final textSpan = TextSpan(
                  text: widget.biography,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w800,
                  ),
                );
                final textPainter = TextPainter(
                  text: textSpan,
                  textDirection: TextDirection.ltr,
                  maxLines: null,
                )..layout(maxWidth: constraints.maxWidth);
                final numberOfLines = textPainter.computeLineMetrics().length;
                _isTextOverflow = numberOfLines > 5;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Text(
                        widget.biography,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.justify,
                        maxLines:
                            _isExpanded ? null : (_isTextOverflow ? 5 : null),
                        overflow: _isExpanded
                            ? TextOverflow.visible
                            : (_isTextOverflow
                                ? TextOverflow.ellipsis
                                : TextOverflow.visible),
                      ),
                    ),
                    if (_isTextOverflow) ...[
                      const SizedBox(height: 12),
                      ExpandCollapseButton(
                        isExpanded: _isExpanded,
                        onPressed: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
