import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iop_wallet/src/utils/schema_form/photo_selector_controller.dart';

// TODO:
// - https://medium.com/saugo360/creating-custom-form-fields-in-flutter-85a8f46c2f41
// - https://stackoverflow.com/questions/54848639/flutter-custom-formfield-validate-and-save-methods-are-not-called

class PhotoSelectorFormField extends FormField<File> {
  final PhotoSelectorController controller;
  final String title;

  PhotoSelectorFormField({
    required this.controller,
    required this.title,
    FormFieldSetter<File>? onSaved,
    required FormFieldValidator<File> validator,
    bool autoValidate = false,
  }) : super(
            onSaved: onSaved,
            // TODO: https://github.com/Milad-Akarie/form_field_validator/issues/16
            //validator: validator,
            initialValue: controller.image,
            autovalidateMode: autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            builder: (FormFieldState<File> state) {
              final subheadTheme = Theme.of(state.context).textTheme.subtitle1;
              final titleColor =
                  state.hasError ? Colors.red : subheadTheme!.color;
              final titleStyle = subheadTheme!.copyWith(color: titleColor);

              final content = <Widget>[
                Row(children: <Widget>[
                  Expanded(child: Text(title, style: titleStyle)),
                ]),
              ];

              if (controller.isImageSelected()) {
                content.add(Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Image.file(controller.image!),
                ));
              } else {
                content.add(Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Row(children: const <Widget>[
                    Expanded(child: Text('Click Here to Select a Photo')),
                  ]),
                ));
              }

              if (state.hasError) {
                content.add(Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          state.errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ));
              }

              return InkWell(
                  onTap: () async {
                    final imageFile = await ImagePicker().getImage(
                      source: ImageSource.camera,
                    );

                    if (imageFile == null) {
                      return;
                    }

                    final image = await decodeImageFromList(
                      await imageFile.readAsBytes(),
                    );
                    final scale = _calcScale(
                      image.width,
                      image.height,
                      512,
                      512,
                    );
                    final compressedFile =
                        await FlutterImageCompress.compressAndGetFile(
                      imageFile.path,
                      imageFile.path.replaceFirst('.jpg', '_compressed.jpg'),
                      minWidth: image.width ~/ scale,
                      minHeight: image.height ~/ scale,
                      quality: 80,
                    );
                    state.didChange(compressedFile);
                    controller.image = compressedFile;
                    await File(imageFile.path).delete();
                  },
                  child: Card(
                      child: Container(
                          margin: const EdgeInsets.all(16.0),
                          child: Column(children: content))));
            });

  static int _calcScale(
    int srcWidth,
    int srcHeight,
    int minWidth,
    int minHeight,
  ) {
    final scaleW = srcWidth ~/ minWidth;
    final scaleH = srcHeight ~/ minHeight;

    return math.max(1, math.min(scaleW, scaleH));
  }
}
