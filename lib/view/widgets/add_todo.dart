import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo/common/size_constants.dart';
import 'package:flutter_todo/common/string.dart';
import 'package:flutter_todo/data/controller/todo_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AddTodo extends HookConsumerWidget {
  const AddTodo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = useTextEditingController();
    TextEditingController dateInputController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeConstants.size20, vertical: SizeConstants.size20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              TodoString.addTodo,
            ),
            const SizedBox(
              height: SizeConstants.size15,
            ),
            TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: TodoString.addTodoTitle,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SizeConstants.size20,
        ),
        TextFormField(
          controller: dateInputController,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2034),
            );
            if (pickedDate != null) {
              String formatDate = DateFormat.yMd().format(pickedDate);
              dateInputController.text = formatDate;
            }
          },
          decoration: const InputDecoration(
            hintText: TodoString.selectDateText,
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: SizeConstants.size20,
        ),
        GestureDetector(
          onTap: () async {
            if (controller.text.isEmpty || dateInputController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(TodoString.emptyTextFieldText),
                ),
              );
              return;
            }
            await ref.watch(todoControllerProvider).addTodo(controller.text,
                DateFormat.yMd().parse(dateInputController.text));
            Navigator.pop(context);
          },
          child: Container(
            height: SizeConstants.size40,
            decoration: BoxDecoration(
                color: const Color(0xff0AB6AB),
                borderRadius: BorderRadius.circular(SizeConstants.size12)),
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                TodoString.addNewTask,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
