import 'package:flutter/material.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';
import'package:meals/providers/favorites_provider.dart';
import 'package:meals/models/meal.dart';
//import 'package:meals/data/dummy_data.dart';

class MealDetailsScreen extends ConsumerWidget{
  const MealDetailsScreen({
    super.key ,
    required this.meal,
    
    });
  
  final Meal meal;
  

  @override
  Widget build(BuildContext context , WidgetRef ref){
    //for stateless widget we need to add ref 
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
      title : Text(meal.title),
      actions: [
        IconButton(onPressed: (){
          final wasAdded = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
          Text(wasAdded ? 'Meal added as favorite' : 'Meal removed from favorite !' ),
          ));
         
        }, 
        
        icon:AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child , animation){
              return RotationTransition(turns:Tween(begin: 0.5,end:1.0).animate(animation), child: child );
          },
          child :  Icon(isFavorite ? Icons.star : Icons.star_border, key:ValueKey(isFavorite))))  
          // to trigger animation we require key
      ],
      ),
      body :SingleChildScrollView(
        child: Column(
        children : [
          Hero(
          tag : meal.id,// this id must be unique and same at destination and source places.
          child : Image.network(meal.imageUrl,
          width : double.infinity,
          height: 300,
          fit : BoxFit.cover,
        ),
        ),


        const SizedBox(height : 14),
        Text('Ingredients' ,style : Theme.of(context).textTheme.titleLarge!.copyWith(
              color : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
        ),),
        const SizedBox(height : 14),
        for(final ingredient in meal.ingredients)
                Text(ingredient ,style : Theme.of(context).textTheme.bodyMedium!.copyWith(
              color : Theme.of(context).colorScheme.onSurface,),),
        
         const SizedBox(height : 24),
         Text('Steps' ,style : Theme.of(context).textTheme.titleLarge!.copyWith(
              color : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
        ),),
         const SizedBox(height : 14),
        for(final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical : 8 , horizontal : 12),
                  child: Text(step ,
                  textAlign: TextAlign.center,
                  style : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color : Theme.of(context).colorScheme.onSurface,),),
                ),
        
        ],
        ),
      ),
    );
  }

}