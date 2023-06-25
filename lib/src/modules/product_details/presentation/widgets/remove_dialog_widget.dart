import 'package:ecommercebusiness/src/core/utils/app_colors.dart';
import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/modify_product_riverpod.dart';

class RemoveDialogWidget extends ConsumerWidget {
  final String id;
  const RemoveDialogWidget(
    this.id, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remove = ref.watch(modifyProduct);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15),
      title: const TextWidget(txt: 'Delete this product ?'),
      actions: [
        ElevatedButton(
            onPressed: () {
              remove.deleteProduct(id: id).then((value) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: AppColor.primaryBLue,
                    behavior: SnackBarBehavior.floating,
                    content: TextWidget(
                      txt:
                          'Success removed this product \nid: ${value['id']},\ntitle: ${value['title']},\nprice: \$${value['price']},\ncategory: ${value['category']}',
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    )));
              });
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.pink),
            child: const TextWidget(
              txt: 'Delete',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.white,
            )),
        ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: const TextWidget(
              txt: 'No',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
