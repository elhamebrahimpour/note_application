import 'package:flutter/material.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/model/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isBoxChecked = false;

  @override
  void initState() {
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return GestureDetector(
      onTap: () => setState(() {
        isBoxChecked = !isBoxChecked;
        widget.task.isDone = isBoxChecked;
        widget.task.save();
      }),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        height: 132,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: whiteColor,
        ),
        child: _getMainContent(),
      ),
    );
  }

  Widget _getMainContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Checkbox(
                      value: isBoxChecked,
                      onChanged: ((value) {}),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      checkColor: whiteColor,
                      activeColor: greenColor,
                    ),
                  ),
                  Text(widget.task.title,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Row(
                children: [
                  _getTimeAndEditContainer(
                    greenColor,
                    blackColor,
                    '10:30',
                    'icon_time',
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  _getTimeAndEditContainer(
                    lightGreen,
                    greenColor,
                    'ویرایش',
                    'icon_edit',
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Image.asset('images/workout.png'),
      ],
    );
  }

  Widget _getTimeAndEditContainer(
      Color color, Color textColor, String string, String iconName) {
    return Container(
      height: 28,
      width: 90,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              string,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 14, color: textColor),
            ),
            Image.asset('images/$iconName.png'),
          ],
        ),
      ),
    );
  }
}
