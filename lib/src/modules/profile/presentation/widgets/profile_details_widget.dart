import 'package:ecommercebusiness/src/core/utils/helper_extenstions.dart';
import 'package:ecommercebusiness/src/core/widgets/text_widget.dart';
import 'package:ecommercebusiness/src/modules/profile/data/model/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final UserModel data;
  const ProfileDetailsWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 80,
          child: Icon(
            CupertinoIcons.profile_circled,
            size: 150,
          ),
        ),
        25.ph,
        TextWidget(
          txt: '${data.name.firstname} ${data.name.lastname}',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        10.ph,
        TextWidget(
          txt: 'Email: ${data.email}',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        10.ph,
        TextWidget(
          txt: 'Phone: ${data.phone}',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        10.ph,
        const TextWidget(
          txt: 'Address:',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        5.ph,
        TextWidget(
          txt:
              '${data.address.number}, ${data.address.street}, ${data.address.city}, ${data.address.zipcode}',
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      ],
    );
  }
}
