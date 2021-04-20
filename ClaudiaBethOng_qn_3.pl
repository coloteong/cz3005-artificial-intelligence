% knowledge base
breads([honey_oat, wheat, hearty_italian, italian, flatbread]).
mains([ham, chicken, tuna, cold_cut_trio, bacon, turkey, beef]).
cheeses([american, monterey_cheddar, none]).
veggies([green_peppers, lettuce, olives, cucumbers, avocado, tomato, guacamole, red_onion]).
sauces([soy, bbq, mayonnaise, ranch, sweet_chilli]).
healthy_sauces([chipotle, vinegar, thousand_island]).
sides([chips, cookies, hashbrown]).
drinks([lipton_tea, green_tea, dasani, coffee, sunkist]).

% dynamic predicates to store user's choices
:- dynamic meal/1, bread/1, main/1, cheese/1, veggie/1, sauce/1, side/1, drink/1.


% empty list
options([]).

% list with one element and print the element
options([A]):-
    write(A).

% prints head of list and sublist recursively
options([A|B]):-
    write(A),
    write(', '),
    options(B),
    !.

% functions to show options for each part of the meal
show_options(breads):-
    breads(L),
    write('breads = '),
    options(L),
    nl.

show_options(mains):-
    mains(L),
    write('mains = '),
    options(L),
    nl.

show_options(cheeses):-
    cheeses(L),
    write('cheeses = '),
    options(L),
    nl.

show_options(veggies):-
    veggies(L),
    write('veggies = '),
    options(L),
    nl.

show_options(sauces):-
    sauces(L),
    write('sauces = '),
    options(L),
    nl.

show_options(healthy_sauces):-
    healthy_sauces(L),
    write('sauces = '),
    options(L),
    nl.

show_options(sides):-
    sides(L),
    write('sides = '),
    options(L),
    nl.

show_options(drinks):-
    drinks(L),
    write('drinks = '),
    options(L),
    nl.


% checks whether the input by the user is a part of the specific list
% for each part of the meal
valid_bread(X) :-
    breads(B),
    member(X, B),
    !.
valid_main(X) :-
    mains(M),
    member(X, M),
    !.
valid_cheese(X) :-
    cheeses(C),
    member(X, C),
    !.
valid_veggie(X) :-
    veggies(V),
    member(X, V),
    !.
valid_sauce(X) :-
    sauces(S),
    member(X, S),
    !.
valid_healthy_sauce(X) :-
    healthy_sauces(S),
    member(X, S),
    !.
valid_side(X) :-
    sides(A),
    member(X, A),
    !.
valid_drink(X) :-
    drinks(D),
    member(X, D),
    !.


% checking whether the option that is typed is a valid input, with the
% help of the previous 'valid_xx' function
check_bread :-
    read(X),
    valid_bread(X) -> write('breads = '), write(X), nl, assert(bread(X));
    write('Invalid bread, try again'), nl,
    check_bread.

check_main :-
    read(X),
    valid_main(X) -> write('main = '), write(X), nl, assert(main(X));
    write('Invalid main, try again'), nl,
    check_main.

check_cheese :-
    read(X),
    valid_cheese(X) -> write('cheese = '), write(X), nl, assert(cheese(X));
    write('Invalid cheese, try again'), nl,
    check_cheese.

check_veggie :-
    read(X),
    (not(X == 0) ->
        (valid_veggie(X) -> write('veggies = '), write(X), write(' (Enter 0 to conclude veggies)'), nl, assert(veggie(X));
        write('Invalid veggie, try again'), nl),
        check_veggie;
        true
    ).

check_sauce :-
    read(X),
    (not(X == 0) ->
        (valid_sauce(X) -> write('sauce = '), write(X), write(' (Enter 0 to conclude sauces)'), nl, assert(sauce(X));
        write('Invalid sauce, try again'), nl),
        check_sauce;
        true
    ).

check_healthy_sauce :-
    read(X),
    (not(X == 0) ->
        (valid_healthy_sauce(X) -> write('sauce = '), write(X), write(' (Enter 0 to conclude sauces)'), nl, assert(sauce(X));
        write('Invalid sauce, try again'), nl),
        check_healthy_sauce;
        true
    ).

check_side :-
    read(X),
    (not(X == 0) ->
        (valid_side(X) -> write('sides = '), write(X), write(' (Enter 0 to conclude sides)'), nl, assert(side(X));
        write('Invalid sides, try again'), nl),
        check_side;
        true
    ).

check_drink :-
    read(X),
    valid_drink(X) -> write('drink = '), write(X), nl, assert(drink(X));
    write('Invalid drink, try again'), nl,
    check_drink.

% UI of console for each option
ask_bread :-
    write('Please choose breads'),nl,
    show_options(breads),
    check_bread.

ask_main :-
    write('Please choose main: '),nl,
    show_options(mains),
    check_main.

ask_cheese :-
    write('Please choose cheese: '),nl,
    show_options(cheeses),
    check_cheese.

ask_veggie :-
    write('Please choose veggie: '),nl,
    show_options(veggies),
    check_veggie.

ask_sauce :-
    write('Please choose sauce: '),nl,
    show_options(sauces),
    check_sauce.

ask_healthy_sauce :-
    write('Please choose healthy sauce: '),nl,
    show_options(healthy_sauces),
    check_healthy_sauce.

ask_side :-
    write('Please choose sides: '),nl,
    show_options(sides),
    check_side.

ask_drink :-
    write('Please choose drinks: '),nl,
    show_options(drinks),
    check_drink.

% IMPORTANT: what options the user is offered for every kind of meal
% they choose
meal_normal :-
    ask_bread, ask_main, ask_cheese, ask_veggie,
    ask_sauce, ask_side, ask_drink.

meal_vegan :-
    ask_bread, ask_veggie,
    ask_healthy_sauce, ask_side, ask_drink.

meal_veggie :-
    ask_bread, ask_veggie, ask_cheese,
    ask_healthy_sauce, ask_side, ask_drink.

meal_value :-
    ask_bread, ask_main, ask_cheese,
    ask_veggie, ask_sauce, ask_drink.


% find all the options for each choice
get_options(Meals, Breads, Mains, Cheeses, Vegs, Sauces, Sides, Drinks) :-
    findall(X, meal(X), Meals),
    findall(X, bread(X), Breads),
    findall(X, main(X), Mains),
    findall(X, cheese(X), Cheeses),
    findall(X, veggie(X), Vegs),
    findall(X, sauce(X), Sauces),
    findall(X, side(X), Sides),
    findall(X, drink(X), Drinks).

% concatenate user's options and displays to the user in console
overview :-
    get_options(Meals, Breads, Mains, Cheeses, Vegs, Sauces, Sides, Drinks),
    atomic_list_concat(Meals, Meal),
    write('Your Meal: '), write(Meal), nl,

    write('Your orders:'),nl,
    atomic_list_concat(Breads, Bread),
    write('Bread: '), write(Bread), nl,
    atomic_list_concat(Mains, Main),
    write('Meat: '), write(Main), nl,

    atomic_list_concat(Cheeses, Cheese),
    write('Cheese: '), write(Cheese), nl,

    atomic_list_concat(Vegs, ',', Veg),
    write('Veggies: '), write(Veg), nl,
    atomic_list_concat(Sauces, ',', Sauce),
    write('Sauces: '), write(Sauce), nl,
    atomic_list_concat(Sides, ',', Side),
    write('Sides: '), write(Side), nl,
    atomic_list_concat(Drinks, ',', Drink),
    write('Drinks: '), write(Drink), nl.

% starts the entire program
start:-
    write('Hi! Welcome to Subway. Let us help you prepare your meal today!'), nl,
    prompt,
    write('Thank you for coming to Subway! Your meal will be ready soon. Hope to see you again!'),
    nl.

% is called when the program starts, to log which meal the user chose
prompt :-
    write('Please choose meal type (normal, vegan, veggie, value)'), nl,
    read(Meal),

    (Meal == normal ->
        write('meal = '), write(Meal), nl,
        meal_normal, assert(meal(normal));

    Meal == vegan ->
        write('meal = '), write(Meal), nl,
        meal_vegan, assert(meal(vegan));

    Meal == veggie ->
        write('meal = '), write(Meal), nl,
        meal_veggie, assert(meal(veggie));

        % else, value
        write('meal = '), write(Meal), nl,
        meal_value, assert(meal(value))
    ),
    nl,
    overview.


