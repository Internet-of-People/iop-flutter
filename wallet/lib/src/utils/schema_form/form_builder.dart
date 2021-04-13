import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iop_wallet/src/utils/schema_form/date_selector.dart';
import 'package:iop_wallet/src/utils/schema_form/json_form_field.dart';
import 'package:iop_wallet/src/utils/schema_form/json_schema_ext.dart';
import 'package:iop_wallet/src/utils/schema_form/photo_selector.dart';
import 'package:iop_wallet/src/utils/schema_form/photo_selector_controller.dart';
import 'package:json_schema2/json_schema2.dart';

class SchemaDefinedFormContent extends StatefulWidget {
  final JsonSchema _schema;
  final JsonSchemaFormTree _schemaTree;

  const SchemaDefinedFormContent(
    this._schema,
    this._schemaTree, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SchemaDefinedFormContentState();
  }
}

class SchemaDefinedFormContentState extends State<SchemaDefinedFormContent> {
  @override
  Widget build(BuildContext context) {
    return _buildObject(
      widget._schema.description!,
      widget._schema,
      true,
      widget._schemaTree,
    );
  }

  Widget _buildWidgetFormSchema(
    String name,
    JsonSchema schema,
    bool topLevel,
    JsonSchemaFormTree schemaTree,
  ) {
    final alreadyThere = schemaTree.contains(name);

    if (schema.isString() ||
        schema.isEmail() ||
        schema.isNumber() ||
        schema.isNonce() ||
        schema.isNonce() ||
        schema.isContentId()) {
      final controller = alreadyThere
          ? schemaTree.get<JsonSchemaFormTreeValue>(name).widgetController
          : TextEditingController();
      final field = _buildText(
        name,
        schema,
        controller as TextEditingController,
        _getTextInputType(schema),
      );
      schemaTree.putIfAbsent(
        name,
        JsonSchemaFormTreeValue(field.valueProvider, controller),
      );
      return _buildContainer(field.widget, topLevel);
    } else if (schema.isPhoto()) {
      final controller = alreadyThere
          ? schemaTree.get<JsonSchemaFormTreeValue>(name).widgetController
          : PhotoSelectorController();
      final field = _buildPhoto(
        name,
        schema,
        controller as PhotoSelectorController,
      );
      schemaTree.putIfAbsent(
        name,
        JsonSchemaFormTreeValue(field.valueProvider, controller),
      );
      return _buildContainer(field.widget, topLevel);
    } else if (schema.isDate()) {
      final controller = alreadyThere
          ? schemaTree.get<JsonSchemaFormTreeValue>(name).widgetController
          : TextEditingController();
      final field = _buildDate(
        name,
        schema,
        controller as TextEditingController,
      );
      schemaTree.putIfAbsent(
          name, JsonSchemaFormTreeValue(field.valueProvider, controller));
      return _buildContainer(field.widget, topLevel);
    } else if (schema.isObject()) {
      final subTree = alreadyThere
          ? schemaTree.get<JsonSchemaFormTree>(name)
          : JsonSchemaFormTree();
      schemaTree.putSubtreeIfAbsent(name, subTree);
      return _buildContainer(
        _buildObject(name, schema, false, subTree),
        topLevel,
      );
    } else {
      throw Exception(
          'Not supported JsonSchema type: ${schema.type}, schema: $schema');
    }
  }

  Widget _buildObject(
    String name,
    JsonSchema schema,
    bool topLevel,
    JsonSchemaFormTree schemaTree,
  ) {
    final objectChildren = <Widget>[];

    if (topLevel) {
      objectChildren.add(Row(
        children: <Widget>[
          Expanded(
              child: Card(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Text(
                toBeginningOfSentenceCase(name)!,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ))
        ],
      ));
    } else {
      objectChildren.add(Row(
        children: <Widget>[
          Text(
            toBeginningOfSentenceCase(name)!,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ));
    }

    for (final entry in schema.properties.entries) {
      objectChildren.add(_buildWidgetFormSchema(
        entry.key,
        entry.value,
        topLevel,
        schemaTree,
      ));
    }

    return Column(children: objectChildren);
  }

  JsonSchemaFormField<String> _buildText(
    String name,
    JsonSchema schema,
    TextEditingController controller,
    TextInputType textInputType,
  ) {
    final textField = TextFormField(
      decoration: InputDecoration(
          hintText: schema.description,
          labelText: toBeginningOfSentenceCase(name)),
      controller: controller,
      keyboardType: textInputType,
      validator: schema.getValidators(),
    );

    return JsonSchemaFormField.textField(textField, name);
  }

  JsonSchemaFormField<String> _buildDate(
    String name,
    JsonSchema schema,
    TextEditingController controller,
  ) {
    final field = DateSelector(
      toBeginningOfSentenceCase(name)!,
      schema.getValidators()!,
      controller,
    );

    return JsonSchemaFormField.dateSelector(field, name);
  }

  JsonSchemaFormField<String> _buildPhoto(
    String name,
    JsonSchema schema,
    PhotoSelectorController controller,
  ) {
    final field = PhotoSelectorFormField(
      title: toBeginningOfSentenceCase(name)!,
      controller: controller,
      validator: schema.getValidators()!,
    );

    return JsonSchemaFormField.photoSelector(field, name);
  }

  Widget _buildContainer(Widget child, bool topLevel) {
    if (topLevel) {
      return Container(
          margin: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 16.0),
          child: child);
    }
    return child;
  }

  TextInputType _getTextInputType(JsonSchema schema) {
    if (schema.isEmail()) {
      return TextInputType.emailAddress;
    } else if (schema.isNumber()) {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }
}

class JsonSchemaFormTreeValue {
  final ValueProvider valueProvider;
  final dynamic widgetController;

  JsonSchemaFormTreeValue(this.valueProvider, this.widgetController);
}

class JsonSchemaFormTree {
  final _root = <String, dynamic>{};

  void putIfAbsent(String key, JsonSchemaFormTreeValue value) {
    if (_root[key] == null) {
      _root[key] = value;
    }
  }

  void putSubtreeIfAbsent(String key, JsonSchemaFormTree subTree) {
    if (_root[key] == null) {
      _root[key] = subTree;
    }
  }

  T get<T>(String key) => _root[key] as T;

  bool contains(String key) => _root[key] != null;

  Map<String, dynamic> asMapWithValues() {
    return _parseTree(this);
  }

  Map<String, dynamic> _parseTree(JsonSchemaFormTree tree) {
    final parsed = <String, dynamic>{};

    for (final entry in tree._root.entries) {
      if (entry.value is JsonSchemaFormTree) {
        parsed[entry.key] = _parseTree(entry.value as JsonSchemaFormTree);
      } else {
        parsed[entry.key] =
            (entry.value as JsonSchemaFormTreeValue).valueProvider();
      }
    }

    return parsed;
  }
}
