import 'package:flutter/material.dart';
import 'package:flutter_todo/common/color.dart';
import 'package:flutter_todo/common/size_constants.dart';
import 'package:flutter_todo/data/controller/todo_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TodoListBuilder extends HookConsumerWidget {
  const TodoListBuilder({
    super.key,
    required this.todoProvider,
  });

  final ToDoNotifier todoProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          itemCount: ref.watch(todoControllerProvider).tasks.length,
          itemBuilder: (context, index) {
            final task = ref.watch(todoControllerProvider).tasks[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SizeConstants.size10,
              ),
              child: GestureDetector(
                onDoubleTap: () {
                  todoProvider.deleteTodo(task.title!, task.date!);
                },
                onTap: () {
                  todoProvider.toggleTask(task);
                },
                child: Container(
                  width: SizeConstants.size25,
                  height: SizeConstants.size50,
                  decoration: BoxDecoration(
                      color: TodoColor.lightColor,
                      borderRadius:
                          BorderRadius.circular(SizeConstants.size15)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizeConstants.size15,
                      vertical: SizeConstants.size8,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          task.isComplete
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          size: SizeConstants.size24,
                          color: TodoColor.whiteColor,
                        ),
                        const SizedBox(
                          width: SizeConstants.size15,
                        ),
                        GestureDetector(
                          child: Text(
                            task.title!,
                            style: TextStyle(
                              fontSize: SizeConstants.size18,
                              color: TodoColor.whiteColor,
                              decoration: task.isComplete
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat.jm().format(task.date!),
                          style: TextStyle(
                            fontSize: SizeConstants.size18,
                            color: TodoColor.whiteColor,
                            decoration: task.isComplete
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
