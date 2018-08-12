include "globals.mzn"; 

set of int: lady = 1..5;

set of int: name = 1..5;
set of int: color = 1..5;
set of int: city = 1..5;
set of int: drink = 1..5;
set of int: item = 1..5;

array[name] of string: name2string = ["contee", "finch", "marcolla", "natsiou", "winslow"];
array[color] of string: color2string = ["blue", "green", "purple", "red", "white"];
array[city] of string: city2string = ["baleton", "dabokva", "dunwall", "fraeport", "karnaca"];
array[drink] of string: drink2string = ["absinthe", "beer", "rum", "whisky", "wine"];
array[item] of string: item2string = ["diamond", "medal", "pendant", "ring", "snuff"];

function var name: string2name(string: s) = indexOf(s, name2string);
function var color: string2color(string: s) = indexOf(s, color2string);
function var city: string2city(string: s) = indexOf(s, city2string);
function var drink: string2drink(string: s) = indexOf(s, drink2string);
function var item: string2item(string: s) = indexOf(s, item2string);

function var int: indexOf(string: s, array[1..5] of string: a) =  sum([ if s = a[i] then i else 0 endif | i in 1..5]);

array[lady] of var name: names;
array[lady] of var color: colors;
array[lady] of var city: cities;
array[lady] of var drink: drinks;
array[lady] of var item: items;

constraint all_different(names);
constraint all_different(colors);
constraint all_different(cities);
constraint all_different(drinks);
constraint all_different(items);

constraint forall(l in lady, where names[l] = string2name("natsiou")) (colors[l] = string2color("white"));

constraint names[1] = string2name("marcolla");
constraint colors[2] = string2color("purple"); 

constraint forall(l1 in lady, l2 in lady, where colors[l1] = string2color("blue") /\ colors[l2] = string2color("green")) (l1 = l2 + 1);
constraint forall(l in lady, where  colors[l] = string2color("blue")) (drinks[l] = string2drink("whisky"));

constraint forall(l in lady, where cities[l] = string2city("dabokva")) (colors[l] = string2color("red"));
constraint 
forall(l1 in lady, l2 in lady, where  items[l1] = string2item("snuff") /\ cities[l2] = string2city("dabokva")) 
  (abs(l1 - l2) = 1);

constraint forall(l in lady, where names[l] = string2name("finch")) (items[l] = string2item("ring"));
constraint forall(l in lady, where cities[l] =  string2city("fraeport")) (items[l] = string2item("medal"));

constraint 
forall(l1 in lady, l2 in lady,  l3 in lady, 
  where items[l1] = string2item("pendant") /\ cities[l2] = string2city("karnaca") /\ drinks[l3] =  string2drink("beer")) 
    (abs(l1 - l2) = 1 /\ abs(l2 - l3) = 1);

constraint forall(l in lady, where names[l] = string2name("winslow")) (drinks[l] = string2drink("wine"));

constraint forall(l in lady, where cities[l] = string2city("dunwall")) (drinks[l] = string2drink("absinthe"));
constraint drinks[3] = string2drink("rum"); 

constraint forall(l in lady, where names[l] = string2name("contee")) (cities[l] = string2city("baleton"));

solve satisfy;

output ["name: ",  join(" | ", [ name2string[fix(n)] | n in names]), "\n"] 
  ++ ["color: ",  join(" | ", [ color2string[fix(n)] | n in colors]), "\n"] 
  ++ ["city: ",  join(" | ", [ city2string[fix(n)] | n in cities]), "\n"]
  ++ ["drink: ",  join(" | ", [ drink2string[fix(n)] | n in drinks]), "\n"]
  ++ ["item: ",  join(" | ", [ item2string[fix(n)] | n in items]), "\n"];
  
  % nextTo, leftOf, center, left