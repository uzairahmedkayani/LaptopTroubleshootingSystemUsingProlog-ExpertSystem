:- (clause(conman,_) ; consult('conman.pl')).

:- abolish(kb_intro/1).
:- abolish(kb_threshold/1).
:- abolish(kb_hypothesis/1).
:- abolish(c_rule/4).
:- abolish(kb_can_ask/1).

kb_intro(['',
          'Laptop Troubleshooting System',
          '']).

kb_threshold(0.65).

kb_hypothesis('The laptop has a faulty battery.').
kb_hypothesis('The laptop has a software issue.').
kb_hypothesis('The laptop has a hardware issue.').
kb_hypothesis('The laptop needs a software update.').
kb_hypothesis('The laptop needs a hardware repair.').
kb_hypothesis('The laptop needs a battery replacement.').
kb_hypothesis('The laptop needs a system reset.').

c_rule('The laptop is not turning on.',
       0.95,
       [],
       ['The laptop battery is dead.',yes]).

c_rule('The laptop is slow and unresponsive.',
       0.65,
       [],
       [and,['There are multiple software programs running.',yes],
            ['The laptop has low available memory.',yes]]).

c_rule('The laptop is not charging.',
       1,
       [],
       ['The laptop charger is faulty.',yes]).

c_rule('The laptop is not connecting to Wi-Fi.',
       0.80,
       [],
       [and,['The Wi-Fi network is not available.',yes],
            ['The laptop''s Wi-Fi adapter is disabled.',yes]]).

c_rule('The laptop has a faulty battery.',
       1,
       ['The laptop is not turning on.'],
       []).

c_rule('The laptop has a software issue.',
       1,
       ['The laptop is slow and unresponsive.'],
       ['The laptop needs a software update.',yes]).

c_rule('The laptop has a hardware issue.',
       0.95,
       [],
       [or,['The laptop is not turning on.',yes],
           ['The laptop is not charging.',yes],
           ['The laptop is not connecting to Wi-Fi.',yes]]).

c_rule('The laptop needs a software update.',
       0.90,
       ['The laptop has a software issue.'],
       []).

c_rule('The laptop needs a hardware repair.',
       0.95,
       ['The laptop has a hardware issue.'],
       []).

c_rule('The laptop needs a battery replacement.',
       0.85,
       ['The laptop has a faulty battery.'],
       []).

c_rule('The laptop needs a system reset.',
       0.80,
       [],
       ['The laptop is not responding to any commands.',yes]).

kb_can_ask('The laptop is not turning on.').
kb_can_ask('The laptop is slow and unresponsive.').
kb_can_ask('The laptop is not charging.').
kb_can_ask('The laptop is not connecting to Wi-Fi.').
kb_can_ask('The Wi-Fi network is not available.').
kb_can_ask('The laptop''s Wi-Fi adapter is disabled.').
kb_can_ask('The laptop charger is faulty.').
kb_can_ask('The laptop needs a software update.').
kb_can_ask('The laptop needs a system reset.').
kb_can_ask('The laptop is not responding to any commands.').

:- conman.