import 'package:flutter/cupertino.dart';

import '../cubit/home_sections_state.dart';
import '../sections/categories/dynamic_category_section.dart';

void addDynamicSection(
    List<Widget> sections, HomeSectionsState state, int index) {
  if (state is HomeSectionsLoaded && state.sections.length > index) {
    sections.add(DynamicCategorySection(section: state.sections[index]));
  }
}
