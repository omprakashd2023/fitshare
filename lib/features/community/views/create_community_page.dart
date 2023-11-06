import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/colours.dart';
import '../../../common/widgets/round_button.dart';
import '../../../common/widgets/round_textfield.dart';

//Controller
import '../controller/community_controller.dart';

class CreateCommunityPage extends ConsumerStatefulWidget {
  const CreateCommunityPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateCommunityPageState();
}

class _CreateCommunityPageState extends ConsumerState<CreateCommunityPage> {
  bool isCheck = false;
  final TextEditingController _communityNameController =
          TextEditingController(),
      _descriptionController = TextEditingController(),
      _locationController = TextEditingController();

  void createCommunity() {
    ref.read(communityControllerProvider.notifier).createCommunity(
          name: _communityNameController.text,
          description: _descriptionController.text,
          location: _locationController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(communityControllerProvider);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: TColor.primaryColor1,
              ),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Text(
                        "Hey there,",
                        style: TextStyle(color: TColor.gray, fontSize: 16),
                      ),
                      Text(
                        "Create a Community",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      RoundTextField(
                        hintText: "Name",
                        icon: "assets/img/name.png",
                        controller: _communityNameController,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Description",
                        icon: "assets/img/description.png",
                        controller: _descriptionController,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        hintText: "Location",
                        icon: "assets/img/location.png",
                        controller: _locationController,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isCheck = !isCheck;
                              });
                            },
                            icon: Icon(
                              isCheck
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank_outlined,
                              color: TColor.gray,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "By continuing you accept our Privacy Policy and\nTerm of Use",
                              style:
                                  TextStyle(color: TColor.gray, fontSize: 10),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.15,
                      ),
                      RoundButton(
                        title: "Create Community",
                        onPressed: () => createCommunity(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
