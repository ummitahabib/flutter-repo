import 'package:flutter/material.dart';
import 'package:flutter_todo/common/color.dart';
import 'package:flutter_todo/common/size_constants.dart';
import 'package:flutter_todo/common/string.dart';
import 'package:flutter_todo/data/controller/todo_controller.dart';
import 'package:flutter_todo/view/widgets/add_todo.dart';
import 'package:flutter_todo/view/widgets/todo_list_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TodoMainWidget extends HookConsumerWidget {
  const TodoMainWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoProvider = ref.watch(todoControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: TodoColor.greenColor,
          child: const Icon(
            Icons.add,
            size: SizeConstants.size23,
            color: TodoColor.blackColor,
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(SizeConstants.size30)),
                      content: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height /
                              SizeConstants.size3,
                          child: const AddTodo()),
                    ));
          }),
      backgroundColor: TodoColor.blackColor,
      appBar: AppBar(
        backgroundColor: TodoColor.greenColor,
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: TodoColor.whiteColor,
          size: SizeConstants.size24,
        ),
        title: const Text(
          TodoString.todoListText,
          style: TextStyle(
            color: TodoColor.blackColor,
            fontSize: SizeConstants.size20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SizeConstants.size25,
            horizontal: SizeConstants.size30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                TodoString.todayText,
                style: TextStyle(
                    color: TodoColor.whiteColor,
                    fontSize: SizeConstants.size20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: const TextStyle(
                  color: TodoColor.greyColor,
                  fontSize: SizeConstants.size14,
                ),
              ),
              const SizedBox(
                height: SizeConstants.size15,
              ),
              TodoListBuilder(todoProvider: todoProvider),
            ],
          ),
        ),
      ),
    );
  }
}
