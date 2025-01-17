% facts
patientName(john).
has_type_1(john).   
glucose_level(john, 100).
carbo_consumed(john, 100).
physical_level(john, 4).

patientName(elizabeth).
has_type_2(elizabeth).
glucose_level(elizabeth, 140).
carbo_consumed(elizabeth, 170).
physical_level(elizabeth, 1).

patientName(sam).
has_type_2(sam).
glucose_level(sam, 60).
carbo_consumed(sam,30).
physical_level(sam, 2).

% Rules

glucose_pass(X) :- 
    glucose_level(X, A), A >= 70, A =< 130.
carbo_pass(X) :- 
    carbo_consumed(X,A), A =< 150, A >= 100.
physical_pass(X) :- 
    physical_level(X,A), A >= 4.

has_type_1(X) :- not has_type_2(X).
has_type_2(X) :- not has_type_1(X).

under_control(X) :- glucose_pass(X), physical_pass(X), carbo_pass(X).

% advice

advice(X, 'Make sure to monitor your fasting glucose levels - Low') :- 
    glucose_level(X, A), A < 70.   
advice(X, 'Make sure to monitor your fasting glucose levels - High') :- 
    glucose_level(X, A), A < 130.     
    
advice(X, 'Adjust your insulin intake to increase your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A < 70, has_type_1(X).
advice(X, 'Adjust your insulin intake to decrease your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A > 130, has_type_1(X).

advice(X, 'Adjust your medication dosage to raise your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A < 70, has_type_2(X).
advice(X, 'Adjust your medication dosage to decrease your fasting sugars to a reasonable level.') :- 
    glucose_level(X,A), A > 130, has_type_2(X).

