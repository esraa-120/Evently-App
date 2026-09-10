import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/core/widgets/app_text_form_field.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/layout/home/widgets/event_card_item.dart';
import 'package:flutter/material.dart';


class FavoriteView extends StatelessWidget {

  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: 16,
        children: [
          AppTextFormField(
              hintText: "Search",
              suffixIcon: Assets.icons.searchIcn.svg().paddingSymmetric(horizontal: 12)
            ),

          StreamBuilder<QuerySnapshot<EventData>>(
            stream: FirebaseCloudStoreService.getRealTimeFavoriteEventsData(),
            builder: (context, snapshot) {
              /// 1- wait
              /// 2- error
              /// 3- data

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              List<EventData> events = snapshot.data!.docs.map((data) {
                return data.data();
              }).toList();

              if (events.isEmpty) {
                return Text("No events found");
              }

              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return EventCardItem(eventData: events[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 16);
                  },
                  itemCount: events.length,
                ),
              );
            },
          ),

          // Expanded(
          //   child: ListView.separated(
          //     itemBuilder: (context, index) {
          //       return EventCardItem(
          //
          //       );
          //     }, separatorBuilder: (context, index) {
          //     return SizedBox(height: 16,);
          //   }, itemCount: 10,
          //   ),
          // ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
