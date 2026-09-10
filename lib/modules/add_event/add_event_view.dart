import 'package:evently_app/core/config/extensions/padding_extension.dart';
import 'package:evently_app/core/config/theme/app_colors.dart';
import 'package:evently_app/core/services/snack_service.dart';
import 'package:evently_app/core/utils/firebase_cloud_store_service.dart';
import 'package:evently_app/core/widgets/app_button_widget.dart';
import 'package:evently_app/core/widgets/app_text_form_field.dart';
import 'package:evently_app/core/widgets/arrow_back_widget.dart';
import 'package:evently_app/data_source/category_data.dart';
import 'package:evently_app/main.dart';
import 'package:evently_app/models/event_data.dart';
import 'package:evently_app/modules/add_event/widgets/select_event_data_widget.dart';
import 'package:evently_app/modules/layout/home/widgets/category_tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int selectedTabIndex = 0;
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: ArrowBackWidget(),
        title: Text("Add event"),
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children:[
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 100),
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
                SelectEventDataWidget(
                  selectedDateTime: selectedDateTime,
                  onPressed: () {
                    _showDatePicker(context);
                  }
                ),
                // SizedBox(height: 120,)
              ],
                      ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AppButtonWidget(title: "Add event",
              onTap: () {
                if (selectedDateTime != null) {
                if(_formKey.currentState!.validate()) {
                  final data = EventData(
                    categoryId: CategoryList.categories[selectedTabIndex].id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    selectedDateTime: selectedDateTime!,
                  );

                  /// Before calling server
                  EasyLoading.show();

                  FirebaseCloudStoreService.createNewEvent(data).then((value){
                    EasyLoading.dismiss();

                    if(value) {
                      SnackBarServer.showSuccessMessage(
                          "Event added successfully!"
                      );
                      navigatorKey.currentState?.pop();
                    } else {
                      SnackBarServer.showErrorMessage(
                          "Something went wrong!"
                      );
                    }
                  });

                  Future.delayed(Duration(seconds: 3), () {

                  }
                  );

                }
                } else {
                  SnackBarServer.showErrorMessage(
                    "You must select a date first"
                  );
                }
              },
              )
          ),
        ],
      ),
    );
  }
  void _showDatePicker(BuildContext context) async {
    selectedDateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    setState(() {});
  }
}
