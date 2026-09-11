import 'package:evently_app/core/config/gen/assets.gen.dart';
import 'package:evently_app/core/config/routes/app_routes_name.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/data_source/category_data.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {

  final EventData eventData;
  const EventDetails({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.strokeBorder,
                width: 2
            ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        title: Text(
          "Event Details",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.mainText,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(AppRoutesName.editEvent, arguments: eventData);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.strokeBorder,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Assets.icons.editIcn.svg()
            ),
          ),
          SizedBox(width: 8,),
          GestureDetector(
            onTap: (){
              EasyLoading.show();

              FirebaseCloudStoreService.deleteEvent(eventData.eventId!).then((value){
                EasyLoading.dismiss();

                try{
                  if(value){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Event deleted successfully"),
                      ),
                    );
                    Navigator.pop(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Something went wrong"),
                      ),
                    );
                  }
                }catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Something went wrong"),
                    ),
                  );
                }
                });
            },


            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.strokeBorder,
                    width: 2
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Assets.icons.deleteIcn.svg()
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
                image: DecorationImage(
                  image: AssetImage(
                    CategoryList.getCategoryById(eventData.categoryId).imagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              eventData.title,
              style: TextStyle(
                fontSize: 18,
                color: AppColors.mainText,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.strokeBorder,
              ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.strokeBorder),
                    ),
                    child: Assets.icons.calendarIcn.svg(),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("dd MMMM").format(eventData.selectedDateTime),
                        style: TextStyle(
                          color: AppColors.mainText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        DateFormat('h:mm a').format(eventData.selectedDateTime),
                        style: TextStyle(
                          color: AppColors.disabled,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ]
              )
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.mainText,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  eventData.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.mainText,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
