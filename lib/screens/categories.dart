import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen({
    super.key ,
    required this.availableMeals,
    });
   
   final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
late  AnimationController _animationController ; 

@override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      //vsync requires ticker provider which can be obtained by "with SingleTickerProviderStateMixin"
      vsync: this, // refers to this ticker class
      duration: const  Duration(milliseconds: 300), 
      lowerBound: 0,
      upperBound: 1,//animation controller always works between these two values
    );

    _animationController.forward();//this is the callinf function 
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose(); //this ensures that the animation is removed from the memory when animation controller 
    //is removed to avoid memory overflow
  }





  void _selectCategory(BuildContext context ,Category category ){

    final filteredMeals = widget.availableMeals.where((meal) => meal.categories.contains(category.id)).toList();


    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => 
        MealsScreen(
          title: category.title,
           meals: filteredMeals,

          ),
          ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder( //explicit animation 
      animation: _animationController, 
      child : GridView(
        padding : const EdgeInsets.all(24),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio: 1.5, // size of the grid 
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
           ),//we get 2 columns next to each other
        children: [
          for(final category in availableCategories)
          CategoryGridItem(category: category , 
            OnSelectcategory: (){
              _selectCategory(context ,category);
            })
          ],
        ),
      builder: (context , child ) => SlideTransition(
        position:   Tween(
            begin :const Offset(0, 0.3),//i.e along y axis(up and down)30%
            end : const Offset(0, 0)//should end at 0 , 0
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child : child)
      

                                    //  or 
      
      /*Padding(
        padding : EdgeInsets.only(top : 100 -  _animationController.value*100
        ),
        child : child )*/
     );
      
  
  }
}