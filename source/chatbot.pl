condition(dengue) :-
  symptom(yes),
  assertz(symptom(not(dengue))),
  check('Do you have a fever'),
  check('Do you have a headache'),
  check('Do you have pain behind the eye'),
  check('Do you have muscle and joint pain'),
  check('Do you have nausea'),
  check('Did you vomit recently'),
  check('Do you have swollen glands'),
  check('Do you have skin rash'),
  assertz(symptom(dengue)),
  assertz(symptom(check)).

condition(measles) :-
  symptom(yes),
  assertz(symptom(not(measles))),
  check('Do you have a fever'),
  check('Do you have a cough'),
  check('Do you have a runny nose'),
  check('Do you have conjunctivitis/sore eyes'),
  assertz(symptom(measles)),
  assertz(symptom(check)).

condition(tuberculosis) :-
  symptom(yes),
  assertz(symptom(not(tuberculosis))),
  check('Do you have a fever'),
  check('Did you lose weight without trying'),
  check('Do you feel weak or sick'),
  check('Do you have night sweats'),
  assertz(symptom(tuberculosis)),
  assertz(symptom(check)).

condition(diarrhea) :-
  symptom(yes),
  assertz(symptom(not(diarrhea))),
  check('Do you have a fever'),
  check('Do you have watery stools'),
  check('Do you experience abdominal pain'),
  check('Do you feel light headed'),
  check('Do you feel like you have an unquenchable thirst'),
  assertz(symptom(diarrhea)),
  assertz(symptom(check)).

condition(pneumonia) :-
  symptom(yes),
  assertz(symptom(not(pneumonia))),
  check('Do you have a fever'),
  check('Do you have difficulty breathing'),
  check('Do you experience rapid, shallow breathing'),
  check('Do you have a sharp or stabbing chest pain that gets worse when you breathe deeply or cough'),
  check('Do you have a cough'),
  check('Do you have a loss of appetite'),
  check('Do you experience fatigue'),
  assertz(symptom(pneumonia)),
  assertz(symptom(check)).

condition(bronchitis) :-
  symptom(yes),
  assertz(symptom(not(bronchitis))),
  check('Do you have a fever'),
  check('Do you have a cough'),
  check('Do you have a sore throat'),
  check('Do you have a runny nose'),
  check('Do you have muscle and joint pain'),
  check('Do you hear a high pitch whistling sound whenever you breathe'),
  check('Do you have difficulty breathing'),
  check('Do you feel any pressure or discomfort in your chest area'),
  assertz(symptom(bronchitis)),
  assertz(symptom(check)).

condition('chicken pox') :-
  symptom(yes),
  assertz(symptom(not('chicken pox'))),
  check('Do you have a fever'),
  check('Do you have a headache'),
  check('Do you have a rash that is fluid-filled'),
  check('Do you experience fatigue'),
  check('Do you have a loss of appetite'),
  assertz(symptom('chicken pox')),
  assertz(symptom(check)).

condition(influenza) :-
  symptom(yes),
  assertz(symptom(not(influenza))),
  check('Do you have a fever'),
  check('Do you have a headache'),
  check('Do you have a cough'),
  check('Do you have a sore throat'),
  check('Do you have a runny nose'),
  check('Do you have muscle and joint pain'),
  check('Do you experience fatigue'),
  assertz(symptom(influenza)),
  assertz(symptom(check)).

condition(malaria) :-
  symptom(yes),
  assertz(symptom(not(malaria))),
  check('Do you have a fever'),
  check('Do you have a headache'),
  check('Do you have muscle and joint pain'),
  check('Do you experience fatigue'),
  check('Do you have nausea'),
  check('Did you vomit recently'),
  check('Do you have yellowish skin or eyes'),
  assertz(symptom(malaria)),
  assertz(symptom(check)).

condition(typhoid) :-
  symptom(yes),
  assertz(symptom(not(typhoid))),
  check('Do you have a fever'),
  check('Do you experience abdominal pain'),
  check('Do you have bloody stools'),
  check('Did you experience nosebleeds'),
  check('Do you experience fatigue'),
  check('Do you experience hallucinations, agitation, and/or confusion'),
  check('Do you have difficulty paying attention'),
  assertz(symptom(typhoid)),
  assertz(symptom(check)).


valid_response(yes).
valid_response(no).

ask(Variable):-
  write(Variable),
  write('(yes or no)? '),
  read(X),
  ((valid_response(X),
    (X==yes) -> assertz(symptom(Variable));
    ((X==no) -> assertz(symptom(not(Variable))); ask(Variable)))).

check(Variable) :-
  symptom(Variable) -> true;
  symptom(not(Variable)) -> fail;
  (ask(Variable), check(Variable)).


diagnose:-
  write('Good day! I am RoboDoc, ready to assist you!'),nl,
  write('Please answer everything with a "yes" or "no". '),nl,
  retractall(symptom(_)),
  assertz(symptom(not(check))),
  assertz(symptom(yes)),
  (condition(dengue);true),
  (condition(measles);true),
  (condition(tuberculosis);true),
  (condition(diarrhea);true),
  (condition(pneumonia);true),
  (condition(bronchitis);true),
  (condition('chicken pox');true),
  (condition(influenza);true),
  (condition(malaria);true),
  (condition(typhoid);true),

  ((symptom(dengue) -> write('You have dengue.'),nl, retract(symptom(dengue))); true),
  ((symptom(measles) -> write('You have measles.'),nl, retract(symptom(measles))); true),
  ((symptom(tuberculosis) -> write('You have tuberculosis.'),nl, retract(symptom(tuberculosis))); true),
  ((symptom(diarrhea) -> write('You have diarrhea.'),nl, retract(symptom(diarrhea))); true),
  ((symptom(pneumonia) -> write('You have pneumonia.'),nl, retract(symptom(pneumonia))); true),
  ((symptom(bronchitis) -> write('You have bronchitis.'),nl, retract(symptom(bronchitis))); true),
  ((symptom('chicken pox') -> write('You have chicken pox.'),nl, retract(symptom('chicken pox'))); true),
  ((symptom(influenza) -> write('You have influenza.'),nl, retract(symptom(influenza))); true),
  ((symptom(malaria) -> write('You have malaria.'),nl, retract(symptom(malaria))); true),
  ((symptom(typhoid) -> write('You have typhoid fever.'),nl, retract(symptom(typhoid))); true),
  (symptom(check); (write('We could not find the disease.'),nl, retract(symptom(check))); true).