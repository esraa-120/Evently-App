import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/core/widgets/app_text_form_field.dart';
import 'package:evently_app/core/widgets/arrow_back_widget.dart';
import 'package:evently_app/data_source/category_data.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/add_event/widgets/select_event_date_widget.dart';
import 'package:evently_app/modules/add_event/widgets/select_event_time_widget.dart';
import 'package:evently_app/modules/layout/home/widgets/category_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditEventScreen extends StatefulWidget {

  final EventData eventData;
  const EditEventScreen({super.key, required this.eventData});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();
  int selectedTabIndex = 0;
  DateTime? selectedDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.text = widget.eventData.title;
    _descriptionController.text = widget.eventData.description;
    selectedDateTime = widget.eventData.selectedDateTime;
      final index = CategoryList.categories.indexWhere((element) =>
      element.id == widget.eventData.categoryId);

      if (index != -1) {
        selectedTabIndex = index;
      }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackWidget(),
        title: Text("Edit event"),
      ),
      body: SafeArea(
        child: Column(
          children:[
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 195,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.strokeBorder,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: AssetImage(
                                  CategoryList.categories[selectedTabIndex].imagePath
                              ),
                              fit: BoxFit.cover
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      DefaultTabController(
                        length: CategoryList.categories.length,
                        child: TabBar(
                          onTap: (index) {
                            setState(() {
                              selectedTabIndex = index;
                            });
                          },
                          dividerHeight: 0,
                          isScrollable: true,
                          labelPadding: EdgeInsets.symmetric(horizontal: 4),
                          indicator: BoxDecoration(),
                          tabAlignment: TabAlignment.start,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          tabs: CategoryList.categories.map(
                                (categoryData) => CategoryTabItem(categoryData: categoryData,
                                isSelected: CategoryList.categories.indexOf(categoryData) == selectedTabIndex
                            ),
                          )
                              .toList(),
                        ),
                      ),
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title",
                            textAlign: TextAlign.start,
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          AppTextFormField(
                            controller: _titleController,
                            hintText: "Enter Title",
                            validator: (value) {
                              if(value == null || value.trim().isEmpty) {
                                return "Please enter a title";
                              }
                              return null;
                            },
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Description",
                            textAlign: TextAlign.start,
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                          ),
                          AppTextFormField(
                            controller: _descriptionController,
                            maxLines: 4,
                            hintText: "Enter Description",
                            validator: (value) {
                              if(value == null || value.trim().isEmpty) {
                                return "Please enter a description";
                              }
                              return null;
                            },
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                      SelectEventDateWidget(
                          selectedDateTime: selectedDateTime,
                          onPressed: () {
                            _showDatePicker(context);
                          }
                      ),
                      SelectEventTimeWidget(
                          selectedDateTime: selectedDateTime,
                          onPressed: () {
                            _showTimePicker(context);
                          }
                      )
                    ],
                  ),
                ),
              ),
            ),
            AppButtonWidget(
              title: "Update event",
              onTap: updateEvent,
            ),
          ],
        ),
      ),
    );
  }

  Future <void> updateEvent() async{
    if(_formKey.currentState!.validate()) {
      if(selectedDateTime == null){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please select a date first"),
          ),
        );
        return;
      }

    final selectedCategory = CategoryList.categories[selectedTabIndex];

    final updatedEventData = EventData(
        categoryId: widget.eventData.categoryId,
        categoryImage: selectedCategory.imagePath,
        title: _titleController.text,
        description: _descriptionController.text,
        selectedDateTime: selectedDateTime!,
        eventId: widget.eventData.eventId,
        isFavorite: widget.eventData.isFavorite,
    );
    EasyLoading.show();

    try {
      final value = await FirebaseCloudStoreService.updateEvent(
          updatedEventData);

      if (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Event updated successfully"),
          ),
        );
        Navigator.pop(context, updatedEventData);
        Navigator.pop(context, updatedEventData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
          ),
        );
      }
    }
      finally {
        EasyLoading.dismiss();
      }
    }
  }


  Future<void> _showDatePicker(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (date != null) {
      setState(() {
        final oldDate = selectedDateTime ?? DateTime.now();

        selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          oldDate.hour,
          oldDate.minute,
        );
      });
    }
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedDateTime != null
          ? TimeOfDay.fromDateTime(selectedDateTime!)
          : TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        final date = selectedDateTime ?? DateTime.now();

        selectedDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

}

