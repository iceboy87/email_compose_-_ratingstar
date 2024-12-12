import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';

class ComposePage extends StatefulWidget {
  @override
  _ComposePageState createState() => _ComposePageState();
}

class _ComposePageState extends State<ComposePage> {
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool inUpperCaseMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Compose Email",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: Colors.white),
            onPressed: () {
              // Handle send email logic here
              print("Email Sent");
            },
          ),
        ],
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 40.h,
            width: 95.w,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: quill.QuillEditor(
                    controller: _controller,
                    scrollController: ScrollController(),
                    focusNode: FocusNode(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.format_bold),
                        onPressed: () {
                          final isBold = _controller
                              .getSelectionStyle()
                              .attributes
                              .containsKey(quill.Attribute.bold.key);
                          if (isBold) {
                            _controller.formatSelection(
                              quill.Attribute.clone(quill.Attribute.bold, null),
                            );
                          } else {
                            _controller.formatSelection(quill.Attribute.bold);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.format_italic),
                        onPressed: () {
                          final isItalic = _controller
                              .getSelectionStyle()
                              .attributes
                              .containsKey(quill.Attribute.italic.key);
                          if (isItalic) {
                            _controller.formatSelection(
                              quill.Attribute.clone(
                                quill.Attribute.italic,
                                null,
                              ),
                            );
                          } else {
                            _controller.formatSelection(quill.Attribute.italic);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.format_underline),
                        onPressed: () {
                          final isUnderlined = _controller
                              .getSelectionStyle()
                              .attributes
                              .containsKey(quill.Attribute.underline.key);
                          if (isUnderlined) {
                            _controller.formatSelection(
                              quill.Attribute.clone(
                                quill.Attribute.underline,
                                null,
                              ),
                            );
                          } else {
                            _controller.formatSelection(
                              quill.Attribute.underline,
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.format_align_left),
                        onPressed: () {
                          _controller.formatSelection(
                            quill.Attribute.leftAlignment,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.format_align_center),
                        onPressed: () {
                          _controller.formatSelection(
                            quill.Attribute.centerAlignment,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.format_align_right),
                        onPressed: () {
                          _controller.formatSelection(
                            quill.Attribute.rightAlignment,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.text_fields),
                        onPressed: () {
                          final selection = _controller.selection;

                          if (!selection.isCollapsed) {
                            final start = selection.start;
                            final end = selection.end;

                            final selectedText = _controller.document
                                .toPlainText()
                                .substring(start, end);

                            final isUpperCase =
                                selectedText == selectedText.toUpperCase();
                            final toggledText =
                                isUpperCase
                                    ? selectedText.toLowerCase()
                                    : selectedText.toUpperCase();

                            // Replace selected text with toggled case text
                            _controller.replaceText(
                              start,
                              end - start,
                              toggledText,
                              TextSelection(
                                baseOffset: start,
                                extentOffset: start + toggledText.length,
                              ),
                            );
                          }
                        },
                      ),

                      //Bullet Point (Unordered List) Button
                      IconButton(
                        icon: Icon(Icons.format_list_bulleted),
                        onPressed: () {
                          _controller.formatSelection(quill.Attribute.ul);
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.format_list_numbered),
                        onPressed: () {
                          _controller.formatSelection(quill.Attribute.ol);
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}