import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/model/task.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode _titleFocusNode = FocusNode();
  FocusNode _subTitleFocusNode = FocusNode();

  TextEditingController? _titleController;
  TextEditingController? _subTitleController;

  //get box to put data in it
  var taskBox = Hive.box<Task>('taskBox');

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.task.title);
    _subTitleController = TextEditingController(text: widget.task.subTitle);

    _titleFocusNode.addListener(() {
      setState(() {});
    });
    _subTitleFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Center(
        child: Column(
          children: [
            _getTextField(
                'عنوان', 'عنوان تسک', _titleFocusNode, 1, _titleController!),
            _getTextField('توضیحات', 'توضیحات تسک', _subTitleFocusNode, 2,
                _subTitleController!),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: ElevatedButton(
                onPressed: () {
                  eidtTask(_titleController!.text, _subTitleController!.text);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  minimumSize: Size(178, 48),
                ),
                child: Text(
                  'ویرایش تسک',
                  style: TextStyle(
                      fontSize: 20,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  eidtTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.save();
  }

  Widget _getTextField(String str1, String str2, FocusNode focusNode,
      int maxLines, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 40),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          maxLines: maxLines,
          style: TextStyle(color: blackColor),
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 3,
                color: greenColor,
              ),
            ),
            labelText: str1,
            labelStyle: TextStyle(
                color: focusNode.hasFocus ? greenColor : greyColor,
                fontSize: 18),
            hintText: str2,
            hintStyle: TextStyle(color: greyColor),
          ),
        ),
      ),
    );
  }
}
