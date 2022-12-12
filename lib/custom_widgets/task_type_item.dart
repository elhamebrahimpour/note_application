import 'package:flutter/material.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/data/model/task_type.dart';

class TaskTypeItemWidget extends StatelessWidget {
  TaskTypeItemWidget(
      {Key? key,
      required this.taskType,
      required this.index,
      required this.selectedItemIndex})
      : super(key: key);
  TaskType taskType;
  int index;
  int selectedItemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6, left: 6),
      width: 120,
      decoration: BoxDecoration(
        color: (selectedItemIndex == index)
            ? AppColors.greenColor
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (selectedItemIndex == index)
              ? AppColors.greenColor
              : AppColors.lightGreen,
          width: (selectedItemIndex == index) ? 3 : 2,
        ),
      ),
      child: Column(
        children: [
          Image.asset(
            'images/${taskType.image}',
            height: 100,
          ),
          Text(
            taskType.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: (selectedItemIndex == index)
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
          ),
        ],
      ),
    );
  }
}
