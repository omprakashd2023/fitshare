import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

//Models
import '../../../../models/community_model.dart';

import '../../../../common/colours.dart';

//Controllers
import '../../controller/community_controller.dart';

class SearchDelegateWidget extends SearchDelegate {
  final WidgetRef ref;
  SearchDelegateWidget({
    required this.ref,
  });

  void navigateToCommunity(
      {required BuildContext context, required Community cObj}) {
    Routemaster.of(context).push('/view-community/${cObj.name}');
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = ref.watch(searchCommunitiesProvider(query));
    return result is AsyncLoading
        ? Center(
            child: CircularProgressIndicator(
              color: TColor.primaryColor1,
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                if (query.isNotEmpty &&
                    result is AsyncData<List<Community>> &&
                    result.value.isNotEmpty) ...[
                  ListTile(
                    title: Text(
                      "Search Results: '$query'",
                      style: TextStyle(
                        color: TColor.primaryColor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final community = result.value[index];
                      return GestureDetector(
                        onTap: () => navigateToCommunity(
                            context: context, cObj: community),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      "assets/img/gym-3.png",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          community.name,
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          community.location,
                                          style: TextStyle(
                                            color: TColor.gray,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => navigateToCommunity(
                                      context: context,
                                      cObj: community,
                                    ),
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: result.value.length,
                  ),
                ]
              ],
            ),
          );
  }
}
