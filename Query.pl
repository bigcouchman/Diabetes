?- under_control(sam).
# (Fail ALL), John (GOOD)

?- physical_level(A, 4).
# (RETURN A = 'john')

?- type(john, A).
# (RETURN A = 'Type 1 Diabetes')

?- advice(john, Advice).
# (GOOD)

?- advice(elizabeth, Advice). 
# (Fail ALL)