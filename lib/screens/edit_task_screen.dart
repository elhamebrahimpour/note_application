import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/utilities/utilities.dart';
import 'package:note_application/custom_widgets/task_type_item.dart';
import 'package:note_application/data/model/task.dart';
import 'package:time_pickerr/time_pickerr.dart';

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
  DateTime? _taskTime;
  int _selectedItemIndex = 0;

  @override
  void initState() {
    super.initState();

    //this line read the seletion taskType by user from hive
    //and set it as a default type for current task
    _selectedItemIndex = getTaskTypeList().indexWhere(
        (element) => element.taskTypeEnum == widget.task.taskType.taskTypeEnum);

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
      backgroundColor: AppColors.backColor,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _getTextField(
                  'عنوان', 'عنوان تسک', _titleFocusNode, 1, _titleController!),
              _getTextField('توضیحات', 'توضیحات تسک', _subTitleFocusNode, 2,
                  _subTitleController!),
              SizedBox(
                height: 12,
              ),
              _getTaskTimeWidget(),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 140,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: ((context, index) {
                      return InkWell(
                        onTap: () => setState(() {
                          _selectedItemIndex = index;
                        }),
                        child: TaskTypeItemWidget(
                          taskType: getTaskTypeList()[index],
                          index: index,
                          selectedItemIndex: _selectedItemIndex,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ElevatedButton(
                  onPressed: () {
                    editTask(_titleController!.text, _subTitleController!.text);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenColor,
                    minimumSize: Size(178, 48),
                  ),
                  child: Text(
                    'ویرایش تسک',
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTaskTimeWidget() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: CustomHourPicker(
        title: 'انتخاب زمان انجام تسک',
        negativeButtonText: 'حذف زمان',
        positiveButtonText: 'انتخاب زمان',
        titleStyle: TextStyle(
            color: AppColors.greenColor,
            fontWeight: FontWeight.bold,
            fontSize: 18),
        negativeButtonStyle: TextStyle(
            color: AppColors.redColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Shabnam'),
        positiveButtonStyle: TextStyle(
            color: AppColors.greenColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Shabnam'),
        elevation: 2,
        onPositivePressed: (context, time) {
          _taskTime = time;
        },
        onNegativePressed: (context) {
          print('onNegative');
        },
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _taskTime!;
    widget.task.taskType = getTaskTypeList()[_selectedItemIndex];
    widget.task.save();
  }

  Widget _getTextField(String str1, String str2, FocusNode focusNode,
      int maxLines, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 12),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          maxLines: maxLines,
          style: TextStyle(color: AppColors.blackColor),
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(width: 2, color: AppColors.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 3,
                color: AppColors.greenColor,
              ),
            ),
            labelText: str1,
            labelStyle: TextStyle(
                color: focusNode.hasFocus
                    ? AppColors.greenColor
                    : AppColors.greyColor,
                fontSize: 18),
            hintText: str2,
            hintStyle: TextStyle(color: AppColors.greyColor),
          ),
        ),
      ),
    );
  }
}
