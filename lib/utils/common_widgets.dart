import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onAction;
  const CommonActionButton(
      {required this.onAction, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onAction,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.w400, letterSpacing: 0.5),
          ).copyWith(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          child: Text(title),
        ),
      ),
    );
  }
}

class CommonTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool obscureText;
  final bool isDatePicker;
  final TextInputType keyboardType; // New parameter for input type
  final List<String> locations; // New parameter for locations
  final bool disableCopyPaste; // New parameter to disable copy and paste

  const CommonTextField(
    this.title,
    this.controller, {
    this.obscureText = false,
    this.isDatePicker = false,
    this.keyboardType = TextInputType.text, // Default is text
    this.locations = const [], // Default to an empty list
    this.disableCopyPaste = false, // Default is false
    super.key,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _isObscured = true;
  bool get shouldObscureText => widget.obscureText && _isObscured;

  void _selectDate(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final DateTime currentDate = widget.controller.text.isNotEmpty
        ? dateFormat.parse(widget.controller.text)
        : DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  initialDateTime: currentDate,
                  minimumYear: 1900,
                  maximumDate: currentDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDateTime) {
                    widget.controller.text = dateFormat.format(newDateTime);
                  },
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectLocation(String? location) {
    setState(() {
      widget.controller.text = location ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: widget.controller,
          obscureText: shouldObscureText,
          textAlign: TextAlign.justify,
          keyboardType: widget.keyboardType,
          readOnly: widget.disableCopyPaste,
          onTap: () {
            if (widget.disableCopyPaste) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                color: Color(0xff787878),
                width: 2.0,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            hintText: widget.title,
            hintStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: Color(0xff515151),
            ),
            suffixIcon: widget.isDatePicker
                ? IconButton(
                    icon: const Icon(Icons.calendar_month_outlined,
                        color: Colors.grey),
                    onPressed: () => _selectDate(context),
                  )
                : (widget.obscureText
                    ? IconButton(
                        icon: Icon(
                          shouldObscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                      )
                    : widget.locations.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.grey),
                            onPressed: () {
                              // Show the dropdown
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Select Location'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children:
                                            widget.locations.map((location) {
                                          return GestureDetector(
                                            onTap: () {
                                              _selectLocation(location);
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(location),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : null),
          ),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
