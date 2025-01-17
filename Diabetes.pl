% facts
patientName(john).
has_type_1(john).   
glucose_level(john, 100). 
carbo_consumed(john, 100).
physical_level(john, 4).

patientName(elizabeth).
has_type_2(elizabeth).
carbo_consumed(elizabeth, 200).
glucose_level(elizabeth, 140).
physical_level(elizabeth, 1).

patientName(sam).
has_type_2(sam).
glucose_level(sam, 60). (Fail)
carbo_consumed(sam, 50). (Fail)
physical_level(sam, 5). (True)

% Rules
carbo_pass(X) :- carbo_consumed(X,A), A < 150, A > 100.
glucose_pass(X) :- glucose_level(X, A), A > 70, A < 130.
physical_pass(X) :- physical_level(X,A), A >= 4, A < 6.

type(has_type_1, 'Type 1 Diabetes').
type(has_type_2, 'Type 2 Diabetes').
has_type_1(X).
has_type_1(X) :- not has_type_2(X).
has_type_2(X).
has_type_2(X) :- not has_type_1(X).

under_control(X) :- glucose_pass(X), physical_pass(X), carbo_pass(X).

% advice
advice(X, 'You should increase having carbs!') :- carbo_consumed(X,A), A < 100.
advice(X, 'You have monitored your carbs!') :- carbo_consumed(X,A), A > 100, A < 150.
advice(X, 'You should decrease having carbs!') :- carbo_consumed(X,A), A > 150.

advice(X, 'Get up on your seat and move around!') :- physical_level(X,A), A < 4.
advice(X, 'Calm down! You are moving too much!') :- physical_level(X,A), A > 4.

advice(X, 'You have monitored your sugar level!') :- glucose_level(X,A), A < 70, A > 130.
advice(X, 'Need more sugar!') :- glucose_level(X,A), A < 70.
advice(X, 'Slow down on sugar!') :- glucose_level(X,A), A > 130.

advice(X, 'Consult with a doctor') :- not under_control(X).
advice(X, 'You are doing good!') :- under_control(X).

all_advice(X, AdviceList) :- findall(Advice, advice(X, Advice), AdviceList).
