:- (clause(conman, _) ; consult('conman.pl')).

:- abolish(kb_intro/1).
:- abolish(kb_threshold/1).
:- abolish(kb_hypothesis/1).
:- abolish(c_rule/4).
:- abolish(kb_can_ask/1).

kb_intro(['',
          'Laptop Troubleshooting System',
          '']).

kb_threshold(0.65).

kb_hypothesis('The laptop needs a software update.').
kb_hypothesis('The laptop has a faulty display.').
kb_hypothesis('The laptop battery is dead.').
kb_hypothesis('The laptop charger is faulty.').
kb_hypothesis('The operating system is outdated.').

c_rule('The laptop is not turning on.',
       0.95,
       [],
       ['The laptop battery is dead.', yes]).

c_rule('The laptop is slow and unresponsive.',
       0.65,
       [],
       ['There are multiple software programs running.', yes]).

c_rule('The laptop is not charging.',
       1,
       [],
       [or, ['The laptop charger is faulty.', yes],
            ['The laptop battery is dead.', yes]]).

c_rule('The laptop is not connecting to Wi-Fi.',
       0.80,
       [],
       ['The Wi-Fi network is not available.', yes]).

c_rule('The laptop needs a software update.',
       0.90,
       [],
       ['The operating system is outdated.', yes]).

c_rule('The laptop needs a hardware repair.',
       0.95,
       ['The laptop has a hardware issue.'],
       []).

c_rule('The laptop has a faulty display.',
       0.85,
       ['The laptop is slow and unresponsive.'],
       []).

c_rule('The laptop battery is dead.',
       0.75,
       ['The laptop is not turning on.'],
       []).

c_rule('The laptop charger is faulty.',
       0.80,
       ['The laptop is not charging.'],
       []).

c_rule('The operating system is outdated.',
       0.70,
       ['The laptop needs a software update.'],
       []).

kb_can_ask('The laptop is not turning on.').
kb_can_ask('The laptop is slow and unresponsive.').
kb_can_ask('The laptop is not charging.').
kb_can_ask('The laptop is not connecting to Wi-Fi.').
kb_can_ask('The Wi-Fi network is not available.').
kb_can_ask('The laptop charger is faulty.').
kb_can_ask('The operating system is outdated.').

:- conman.
