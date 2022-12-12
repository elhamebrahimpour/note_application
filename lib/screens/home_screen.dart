import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constants/color_constant.dart';
import 'package:note_application/custom_widgets/task_widget.dart';
import 'package:note_application/data/model/task.dart';
import 'package:note_application/screens/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  //get box to put data in it
  var taskBox = Hive.box<Task>('taskBox');
  bool _isFabVisible = true;

  List<Task> taskList = [];
  bool _isSearchingInProgress = false;

  @override
  void initState() {
    super.initState();

    List<Task> _taskList = taskBox.values.toList();
    setState(() {
      taskList = _taskList;
    });

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backColor,
      appBar: AppBar(
        backgroundColor: AppColors.backColor,
        elevation: 0,
        title: _getSearchContainer(),
        centerTitle: true,
      ),
      body: _getMainBody(),
      floatingActionButton: Visibility(
        visible: _isFabVisible,
        child: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<Task>(
              builder: ((context) => AddTaskSreen()),
            ),
          ),
          backgroundColor: AppColors.greenColor,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _getSearchContainer() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              child: TextField(
                cursorColor: AppColors.greenColor,
                focusNode: _focusNode,
                controller: _textEditingController,
                style: TextStyle(color: AppColors.blackColor),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  hintText: 'جستجوی تسک...',
                  hintStyle: TextStyle(color: AppColors.greyColor),
                ),
                onChanged: (value) {
                  _onSearchAction(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: AppColors.greyColor,
            ),
          )
        ],
      ),
    );
  }

  _onSearchAction(String keyWord) {
    List<Task> _filteredList = [];
    if (keyWord.isEmpty) {
      setState(() {});
      List<Task> _updatedList = taskBox.values.toList();
      setState(() {
        taskList = _updatedList;
        _isSearchingInProgress = false;
      });
      FocusScope.of(context).unfocus();
      return;
    }
    _filteredList = taskBox.values
        .toList()
        .where((element) =>
            element.title.toLowerCase().contains(keyWord.toLowerCase()))
        .toList();
    setState(() {
      taskList = _filteredList;
      _isSearchingInProgress = true;
    });
    print(_filteredList);
  }

  Widget _getMainBody() {
    return SafeArea(
      // NotificationListener -> this widget helps us to change the visibility of FAB when scrolls the list
      child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          setState(() {
            if (notification.direction == ScrollDirection.forward) {
              _isFabVisible = true;
            }
            if (notification.direction == ScrollDirection.reverse) {
              _isFabVisible = false;
            }
          });
          return true;
        },
        child: ValueListenableBuilder(
          //box.listenable works as a valueNotifier in hive database
          valueListenable: taskBox.listenable(),
          builder: ((context, value, child) => ListView.builder(
                //get taskbox length from hive db
                itemCount: _isSearchingInProgress
                    ? taskList.length
                    : taskBox.values.length,
                itemBuilder: ((context, index) {
                  var task = _isSearchingInProgress
                      ? taskList[index]
                      : taskBox.values.toList()[index];
                  return _getTaskItem(task);
                }),
              )),
        ),
      ),
    );
  }

//use dismissable widget to slide item and delete it
  Widget _getTaskItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(
        task: task,
      ),
    );
  }
}
