% facts
% glucose level in terms of mg/dL
% carbo consumed in terms of grams (g)
% physical level - (1 = extremely inactive, 5 = extemely active)

% john - blood glucose, carbs, and physical level good/under control
patientName(john).
has_type_1(john).   
glucose_level(john, 100).
carbo_consumed(john, 100).
physical_level(john, 4).

% elizabeth - blood glucose and carbs not under control, physical level poor
patientName(elizabeth).
has_type_2(elizabeth).
glucose_level(elizabeth, 140). 
carbo_consumed(elizabeth, 170). 
physical_level(elizabeth, 1). 

% sam - blood glucose and carbs not under control, physical level poor
patientName(sam).
has_type_2(sam).
glucose_level(sam, 70).
carbo_consumed(sam,80).
physical_level(sam, 2).

% Rules
glucose_pass(X) :- 
    glucose_level(X, A), A >= 90, A =< 130.
carbo_pass(X) :- 
    carbo_consumed(X,A), A =< 150, A >= 100.
physical_pass(X) :- 
    physical_level(X,A), A >= 4.

type(X, 'Type 1 Diabetes'):-
    has_type_1(X).
type(X, 'Type 2 Diabetes'):-
    has_type_2(X).

under_control(X) :- glucose_pass(X), physical_pass(X), carbo_pass(X).

% advice
advice(X, 'Make sure to monitor your fasting glucose levels - Low') :- 
    glucose_level(X, A), A < 90.   
advice(X, 'Make sure to monitor your fasting glucose levels - High') :- 
    glucose_level(X, A), A > 130.     
    
advice(X, 'Adjust your insulin intake to increase your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A < 90, has_type_1(X).
advice(X, 'Adjust your insulin intake to decrease your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A > 130, has_type_1(X).

advice(X, 'Adjust your medication dosage to raise your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A < 90, has_type_2(X).
advice(X, 'Adjust your medication dosage to decrease your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A > 130, has_type_2(X).

advice(X, 'Increase your carbohydrate level so that it is at a healthy level (100-150 g)') :- 
    carbo_consumed(X,A), A < 100.
advice(X, 'Decrease carbohydrate intake so that it is at a healthy level (100-150 g). Doing so') :- 
    carbo_consumed(X,A), A > 150.

advice(X, 'Increase your physical activity day! Try cardiovascular exercises, such as walking and running, 
    so you can reach at least 10,000 steps daily and improve your health!') :- 
    physical_level(X,A), A < 4.
advice(X, 'Overall: Make sure to follow the above advice to better manage your sugars, and consult with your doctor for further advice!') :- 
    not(under_control(X)).
advice(X, 'Overall: You are doing good with your sugars! Make sure to consult with your doctor for further advice!') :- 
    under_control(X).