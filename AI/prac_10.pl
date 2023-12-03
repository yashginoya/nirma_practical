% Define symptoms for different diseases 
symptoms(flu, [fever, cough, sore_throat]). 
symptoms(cold, [sneezing, runny_nose]). 
symptoms(allergy, [sneezing, itchy_eyes]).
% Rules to determine diseases based on symptoms 
has_symptom(Disease, Symptoms) :- symptoms(Disease, DiseaseSymptoms), 
    							subset(Symptoms, DiseaseSymptoms).
% Detect disease based on symptoms 
detect_disease(Symptoms, Disease) :- has_symptom(Disease, Symptoms),
								write('You might have '), write(Disease), nl. 
detect_disease(_, 'Unknown disease. Consult a doctor.').


%  detect_disease([fever,cough,sore_throat],Disease).  =>  ans => You might have flu , Disease = flu

%  detect_disease([sneezing],Disease).  => ans => You might have cold   , Disease = cold

%  detect_disease([sneezing,itchy_eyes],Disease).  => ans => You might have allergy  , Disease = allergy