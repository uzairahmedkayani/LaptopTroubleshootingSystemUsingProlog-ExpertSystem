:- dynamic known/3.

conman :- kb_intro(Statement),
          writeln(Statement),nl,
          kb_threshold(T),
          kb_hypothesis(Hypothesis),
          confidence_in([Hypothesis,yes],CF),
          CF >= T,
          write('Conclusion: '),
          writeln(Hypothesis),
          write('Confidence in hypothesis: '),
          write(CF),
          writeln('.'),
          explain_conclusion(Hypothesis), fail.

conman :- kb_hypothesis(Hypothesis),
          confirm([Hypothesis]),!,
          writeln('No further conclusions.'),
          nl, finish_conman.

conman :- writeln('Can draw no conclusions.'),
          nl, finish_conman.

finish_conman :-
     retractall(known(_,_,_)),
     write('Do you want to conduct another consultation?'),
     yes, nl, nl, !, conman.

finish_conman.

ask_confidence(Hypothesis,CF) :-
     kb_can_ask(Hypothesis),
     writeln('Is the following statement true? --'),
     write('  '), writeln(Hypothesis),
     writeln(['Possible responses: ',
              '  (y) yes            (n) no',
              '  (l) very likely    (v) very unlikely',
              '  (p) probably       (u) unlikely',
              '  (m) maybe          (d) don''t know.',
              '         (?) why?']),
     write('  Your response --> '),
     get_only([y,l,p,m,n,v,u,d,?],Reply), nl, nl,
     convert_reply_to_confidence(Reply,CF),
     !, Reply \== d,
     ask_confidence_aux(Reply,Hypothesis,CF).

ask_confidence_aux(Char,_,_) :- Char \== ?, !.

ask_confidence_aux(_,Hypothesis,CF) :-
     explain_question,
     !, ask_confidence(Hypothesis,CF).

get_only(List,Reply) :-
     get(Char),name(Value,[Char]),
     member(Value,List),Reply = Value, !.

get_only(List,Reply) :-
     write(' [Invalid response.  Try again.] '),
     !,
     get_only(List,Reply).

convert_reply_to_confidence(?,_).
convert_reply_to_confidence(d,_).
convert_reply_to_confidence(n,0).
convert_reply_to_confidence(v,0.05).
convert_reply_to_confidence(u,0.25).
convert_reply_to_confidence(m,0.60).
convert_reply_to_confidence(p,0.80).
convert_reply_to_confidence(l,0.90).
convert_reply_to_confidence(y,1).

explain_question :-
     current_hypothesis(Hypothesis),
     writeln(
'This information is needed to test the following hypothesis:'),
     writeln(Hypothesis), nl,
     writeln('Do you want further explanation?'),
     explain_question_aux,!.

explain_question :-
     writeln('This is a basic hypothesis.'),
     nl, wait.

explain_question_aux :- \+ yes, nl, nl, !.

explain_question_aux :- nl, nl, fail.

explain_conclusion(Hypothesis) :-
     writeln('Do you want an explanation?'),
     yes, nl, nl,
     explain_conclusion_aux(Hypothesis), wait, !.

explain_conclusion(_) :- nl, nl.

explain_conclusion_aux([]) :- !.

explain_conclusion_aux([Hypothesis,_]) :-
     !, explain_conclusion_aux(Hypothesis).

explain_conclusion_aux([and,[Hypothesis,_],Rest]) :-
     !, explain_conclusion_aux(Hypothesis),
     explain_conclusion_aux(Rest).

explain_conclusion_aux([or,[Hypothesis,_],Rest]) :-
     !, explain_conclusion_aux(Hypothesis),
     explain_conclusion_aux(Rest).

explain_conclusion_aux(Hypothesis) :-
     known(Hypothesis,CF,user),
     kb_threshold(T),CF >= T,
     !, write(Hypothesis),writeln(' -'),
     write('From what you told me, I accepted this with '),
     write(CF),writeln(' confidence.'), nl.

explain_conclusion_aux(Hypothesis) :-
     known(Hypothesis,CF,user),
     !, DisCF is 1 - CF,
     write(Hypothesis),writeln(' -'),
     write('From what you told me, I rejected this with '),
     write(DisCF),writeln(' confidence.'), nl.

explain_conclusion_aux(Hypothesis) :-
     known(Hypothesis,0.50,no_evidence),
     !, write(Hypothesis),writeln(' -'),
     writeln(
          'Having no evidence, I assumed this was 50-50.'),
      nl.

explain_conclusion_aux(Hypothesis) :-
     !, known(Hypothesis,CF1,[CF,Prerequisites,Conditions]),
     writeln(Hypothesis),write('Accepted with '),
     write(CF1),
     writeln(' confidence on the basis of the following'),
     write('Rule: '),writeln(Hypothesis),
     write('  with confidence of '),
     write(CF),
     writeln(' if'),
     list_prerequisites(Prerequisites),
     list_conditions(Conditions), nl,
     explain_conclusion_aux(Conditions).

list_prerequisites([]) :- !.

list_prerequisites([-,Hypothesis|Rest]) :-
     !, write('  is disconfirmed: '),
     writeln(Hypothesis),
     list_prerequisites(Rest).

list_prerequisites([Hypothesis|Rest]) :-
     write('  is confirmed: '),
     writeln(Hypothesis),
     list_prerequisites(Rest).

list_conditions([]) :- !.

list_conditions([and,Hypothesis,Rest]) :-
     list_conditions(Hypothesis),
     list_conditions(Rest).

list_conditions([or,Hypothesis,Rest]) :-
     writeln(' ['),
     list_conditions(Hypothesis),
     writeln('     or'),
     list_conditions(Rest), writeln(' ]').

list_conditions([Hypothesis,yes]) :-
     write('    to confirm: '),
     writeln(Hypothesis).

list_conditions([Hypothesis,no]) :-
     write('    to disconfirm: '),
     writeln(Hypothesis).

wait :- write('Press Return when ready to continue. '),
        get0(_), nl, nl.

confidence_in([],1) :- !.

confidence_in([Hypothesis,yes],CF) :-
     known(Hypothesis,CF,_), !.

confidence_in([Hypothesis,yes],CF) :-
     ask_confidence(Hypothesis,CF), !,
     assert(known(Hypothesis,CF,user)).

confidence_in([Hypothesis,yes],CF) :-
     asserta(current_hypothesis(Hypothesis)),
     findall(X,evidence_that(Hypothesis,X),List),
     findall(C,member([C,_],List),CFList),
     retract(current_hypothesis(_)),
     CFList \== [],
     !, maximum(CFList,CF),
     member([CF,Explanation],List),
     assert(known(Hypothesis,CF,Explanation)).

confidence_in([Hypothesis,yes],0.50) :-
     assert(known(Hypothesis,0.50,no_evidence)), !.

confidence_in([Hypothesis,no],CF) :-
     !, confidence_in([Hypothesis,yes],CF0),
     CF is 1 - CF0.

confidence_in([and,Conjunct1,Conjunct2],CF) :-
     !, confidence_in(Conjunct1,CF1),
     confidence_in(Conjunct2,CF2),
     minimum([CF1,CF2],CF).

confidence_in([or,Disjunct1,Disjunct2],CF) :-
     !, confidence_in(Disjunct1,CF1),
     confidence_in(Disjunct2,CF2),
     maximum([CF1,CF2],CF).

evidence_that(Hypothesis,[CF,[CF1,Prerequisite,Condition]]):-
     c_rule(Hypothesis,CF1,Prerequisite,Condition),
     confirm(Prerequisite),
     confidence_in(Condition,CF2),
     CF is (CF1 * CF2).

confirm([]).

confirm([-,Hypothesis|Rest]) :-
     !, known(Hypothesis,CF,_),
     kb_threshold(T),
     M is 1 - CF, M >= T,
     confirm(Rest).

confirm([Hypothesis|Rest]) :-
     known(Hypothesis,CF,_),
     kb_threshold(T),CF >= T,
     !, confirm(Rest).

minimum([M,K],M) :- M < K, ! .
minimum([_,M],M).

yes :-  write('--> '),
        get_yes_or_no(Response),
        !,
        Response == yes.

maximum([],0) :- !.
maximum([M],M) :- !.
maximum([M,K],M) :- M >= K, !.
maximum([M|R],N) :- maximum(R,K), maximum([K,M],N).

member(X,[X|_]).
member(X,[_|Z]) :- member(X,Z).

get_yes_or_no(Result) :- get(Char),              % read a character
                         get0(_),                % consume the Return after it
                         interpret(Char,Result),
                         !.                      % cut -- see text

get_yes_or_no(Result) :- nl,
                         write('Type Y or N:'),
                         get_yes_or_no(Result).

interpret(89,yes).  % ASCII 89  = 'Y'
interpret(121,yes). % ASCII 121 = 'y'
interpret(78,no).   % ASCII 78  = 'N'
interpret(110,no).  % ASCII 110 = 'n'

writeln([]) :- !.

writeln([First|Rest]) :-
        !,
        write(First),
        nl,
        writeln(Rest).

writeln(String) :-
        write(String),
        nl.

