class Category {
  final String name;
  final List<String> subcategories;

  Category({required this.name, required this.subcategories});
}

final List<Category> categories = [
  Category(name: 'Fruits & Vegetables', subcategories: [
    'Fresh Fruits',
    'Fresh Vegetables',
    'Organic Produce',
    'Fresh Herbs',
  ]),
  Category(name: 'Dairy & Eggs', subcategories: [
    'Milk',
    'Cheese',
    'Yogurt',
    'Butter & Margarine',
    'Eggs',
    'Cream & Creamers',
    'Plant-Based Alternatives',
  ]),
  Category(name: 'Meat & Seafood', subcategories: [
    'Fresh Meat',
    'Poultry',
    'Seafood',
    'Deli Meats & Cold Cuts',
  ]),
  Category(name: 'Pantry Staples', subcategories: [
    'Grains & Rice',
    'Pasta & Noodles',
    'Canned Goods',
    'Baking Supplies',
    'Spices & Seasonings',
    'Sauces & Condiments',
    'Jams & Spreads',
  ]),
  Category(name: 'Snacks & Beverages', subcategories: [
    'Chips & Crackers',
    'Cookies & Biscuits',
    'Nuts & Dried Fruits',
    'Candy & Chocolates',
    'Snack Bars',
    'Sodas & Soft Drinks',
    'Juices',
    'Tea & Coffee',
    'Energy & Sports Drinks',
    'Water',
  ]),
  Category(name: 'Frozen Foods', subcategories: [
    'Frozen Vegetables',
    'Frozen Fruits',
    'Ice Cream & Desserts',
    'Frozen Meals',
    'Frozen Pizza',
    'Frozen Snacks',
  ]),
  Category(name: 'Bakery', subcategories: [
    'Bread',
    'Baked Goods',
  ]),
  Category(name: 'Health & Wellness', subcategories: [
    'Organic & Natural',
    'Gluten-Free',
    'Vegan & Vegetarian',
    'Supplements',
    'Protein & Meal Replacements',
  ]),
  Category(name: 'Baby & Childcare', subcategories: [
    'Baby Food',
    'Diapers & Wipes',
    'Baby Care Products',
  ]),
  Category(name: 'Household Essentials', subcategories: [
    'Cleaning Supplies',
    'Paper Products',
    'Storage & Wraps',
    'Pet Food & Supplies',
  ]),
  Category(name: 'International Foods', subcategories: [
    'Asian Cuisine',
    'Hispanic Cuisine',
    'Indian Cuisine',
    'European Cuisine',
  ]),
  Category(name: 'Beverages & Alcohol', subcategories: [
    'Beer',
    'Wine',
    'Spirits',
    'Mixers & Cocktails',
  ]),
];
