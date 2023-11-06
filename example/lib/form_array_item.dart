import 'package:flutter/material.dart';
import 'package:flutter_fast_forms/flutter_fast_forms.dart';

class FastFormArrayItem extends StatefulWidget {
  FastFormArrayItem(Key key, this.index, this.field)
      : value = field.value?.elementAt(index),
        super(key: key);

  final FastFormArrayState<String> field;
  final int index;
  final String? value;

  @override
  FastFormArrayItemState createState() => FastFormArrayItemState();
}

class FastFormArrayItemState extends State<FastFormArrayItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value)
      ..addListener(() {
        widget.field.didItemChange(widget.index, _controller.value.text);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.field.enabled;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            enabled: enabled,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed:
              enabled ? () => widget.field.insert(widget.index + 1, '') : null,
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: enabled ? () => widget.field.remove(widget.index) : null,
        ),
        IconButton(
          icon: const Icon(Icons.drag_handle),
          onPressed: enabled ? () {} : null,
        )
      ],
    );
  }
}
