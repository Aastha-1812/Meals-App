import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category, required this.OnSelectcategory});

  final Category category;
  final void Function() OnSelectcategory;

  @override
  Widget build(BuildContext context) {
    //inkwell is used to make grid boxes tapable, gesturedetector can also be used but inkwell is more efficient.
    return InkWell(
      onTap: OnSelectcategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        // container used for decoration anmd features
        padding : const  EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(colors: [
          category.color.withOpacity(0.55),
          category.color.withOpacity(0.9)
        ],
        begin: Alignment.topLeft,
        end : Alignment.bottomRight,
        ),
      ),
      child : Text(
        category.title,
        style : Theme.of(context).textTheme.titleLarge!.copyWith(
          color : Theme.of(context).colorScheme.onSurface,
        )
      ),
      ),
    );
  }
}
