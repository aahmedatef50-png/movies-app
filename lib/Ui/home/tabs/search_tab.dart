import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/Ui/widget/custom_loading_widget.dart';
import 'package:my_movies_app/l10n/app_localizations.dart';
import 'package:my_movies_app/utils/app_color.dart';
import 'package:my_movies_app/utils/app_image.dart';
import 'package:my_movies_app/utils/app_style.dart';

import '../../../api/api_manger.dart';
import '../../../utils/size_utils.dart';
import '../../widget/custom_text_form_feild.dart';
import '../../widget/movies_grid/movie_card.dart';
import 'cubit/search_states.dart';
import 'cubit/serach_view_model.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width;
    double height = context.height;
    return BlocProvider(
      create: (context) => SearchViewModel(ApiManger()),

      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * .02,
                  vertical: height * .01,
                ),
                child: Column(
                  spacing: height * .02,
                  children: [
                    CustomTextFormFeild(
                      hintText: AppLocalizations.of(context)!.search,
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      prefixIcon: ImageIcon(
                        AssetImage(AppImage.searchIcon),
                        color: AppColor.whiteColor,
                      ),
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }

                        _debounce = Timer(
                          const Duration(milliseconds: 500),
                              () {
                            final query = value.trim();
                            if (query.isEmpty) {
                              context.read<SearchViewModel>().resetSearch();
                            } else {
                              context.read<SearchViewModel>().searchMovies(
                                query,
                              );
                            }
                          },
                        );
                      },
                      onSubmitted: (value) {
                        _debounce?.cancel();
                        context.read<SearchViewModel>().searchMovies(value);
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchController.clear();
                          context.read<SearchViewModel>().resetSearch();
                        },
                        icon: Icon(Icons.close),
                        color: AppColor.greyColor,
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<SearchViewModel, SearchStates>(
                        builder: (context, state) {
                          if (state is SearchInitialState) {
                            return Center(
                              child: Image.asset(
                                AppImage.popCorn,
                                width: width * .4,
                              ),
                            );
                          }

                          if (state is SearchLoadingState) {
                            return Center(child: CustomLoadingWidget());
                          }

                          if (state is SearchErrorState) {
                            return Center(
                              child: Text(
                                state.errorMessage,
                                style: AppStyle.reg16Grey,
                              ),
                            );
                          }

                          if (state is SearchSuccessState) {
                            final List movies =
                                state.response.data?.movies ?? [];

                            if (movies.isEmpty) {
                              return Center(
                                child: Text(
                                  AppLocalizations.of(context)!.noMoviesFound,
                                  style: AppStyle.bold20White,
                                ),
                              );
                            }

                            return GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: width * .03,
                                mainAxisSpacing: width * .03,
                                childAspectRatio: 0.67,
                              ),
                              itemBuilder: (context, index) {
                                return MovieCard(movie: movies[index]);
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
