%%
%This function find the weights attributed to each sensory modality
%according to MLE.
%INPUT: stdA : standard deviation for auditory modality
%INPUT: stdV: standard deviation for visual modality
%OUTPUT: wA, wV: weight for auditory and visual  modality respectively
%%

function [wA,wV] = findWeights(stdA,stdV)

waud = 1/(stdA^2);
wvis = 1/(stdV^2);
wtotal = waud+wvis;


wA = waud/wtotal;
wV = wvis/wtotal;

