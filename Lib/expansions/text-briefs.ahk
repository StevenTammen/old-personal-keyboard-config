; Map uu to qu to be able to type q. Match on . to always trigger, but still include the
; verbose beginnings at higher priority for calculating capitalization."
Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n]|.)uu", "f_q", 3, 0)
f_q(matchObj)
{
	beginning := matchObj[1]
	needsCap := NeedsCap(beginning)
	
	KeyWait u
	
	SendInput {Backspace 2}

	if(needsCap)
	{
		SendInput Qu
	}
	else
	{
		SendInput qu
	}
}


#If !(GetKeyState(rawState) or IDEWindowActive() or TerminalActive())

; -----------------------------------------------------------------------------

; The negated regular expression character class [^123] is to prevent the hotkey from triggering on what were
; intended to be only base layer characters that occur after a layer key (1, 2, 3). These briefs need to be
; modified at some point to deal with modifier layers (so that one can use briefs right after numbers, for
; example).

; Using the normal starters and enders for this brief was causing problems on Typeracer. An extra "I" was getting entered.
; Removing the matches for capitalization starters (e.g., .?!) appears to have solved the problem.
Hotstring("(3[\ta-z'.\/;,\-21]|2[\t'.,\- ]|[^123][\t\/;,\- \n])(i)([\t'.\/;,\- 1\n23])", "f_i", 3, 0)
f_i(matchObj)
{
	TextBrief(matchObj, "I", "I")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(im)([\t'.\/;,\- 1\n23])", "f_im", 3, 0)
f_im(matchObj)
{
	TextBrief(matchObj, "I'm", "I'm")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(id)([\t'.\/;,\- 1\n23])", "f_id", 3, 0)
f_id(matchObj)
{
	TextBrief(matchObj, "I'd", "I'd")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(iv)([\t'.\/;,\- 1\n23])", "f_ive", 3, 0)
Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(ive)([\t'.\/;,\- 1\n23])", "f_ive", 3, 0)
f_ive(matchObj)
{
	TextBrief(matchObj, "I've", "I've")
	return
}

; no brief ill because that conflicts with the word "ill" (as in sick)
Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(il)([\t'.\/;,\- 1\n23])", "f_il", 3, 0)
f_il(matchObj)
{
	TextBrief(matchObj, "I'll", "I'll")
	return
}

; no brief ill because that conflicts with the word "ill" (as in sick)
Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(youre)([\t'.\/;,\- 1\n23])", "f_youre", 3, 0)
f_youre(matchObj)
{
	TextBrief(matchObj, "you're", "You're")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(wo)([\t'.\/;,\- 1\n23])", "f_wo", 3, 0)
f_wo(matchObj)
{
	TextBrief(matchObj, "without", "Without")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(st)([\t'.\/;,\- 1\n23])", "f_st", 3, 0)
f_st(matchObj)
{
	TextBrief(matchObj, "something", "Something")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(sm)([\t'.\/;,\- 1\n23])", "f_sm", 3, 0)
f_sm(matchObj)
{
	TextBrief(matchObj, "sometime", "Sometime")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(sms)([\t'.\/;,\- 1\n23])", "f_sms", 3, 0)
f_sms(matchObj)
{
	TextBrief(matchObj, "sometimes", "Sometimes")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(sn)([\t'.\/;,\- 1\n23])", "f_sn", 3, 0)
f_sn(matchObj)
{
	TextBrief(matchObj, "someone", "Someone")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(sb)([\t'.\/;,\- 1\n23])", "f_sb", 3, 0)
f_sb(matchObj)
{
	TextBrief(matchObj, "somebody", "Somebody")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(sw)([\t'.\/;,\- 1\n23])", "f_sw", 3, 0)
f_sw(matchObj)
{
	TextBrief(matchObj, "somewhere", "Somewhere")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(abt)([\t'.\/;,\- 1\n23])", "f_abt", 3, 0)
f_abt(matchObj)
{
	TextBrief(matchObj, "about", "About")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(mb)([\t'.\/;,\- 1\n23])", "f_mb", 3, 0)
f_mb(matchObj)
{
	TextBrief(matchObj, "maybe", "Maybe")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(bw)([\t'.\/;,\- 1\n23])", "f_bw", 3, 0)
f_bw(matchObj)
{
	TextBrief(matchObj, "between", "Between")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[^123][\t.\/;,\- \n])(kb)([\t'.\/;,\- 1\n23])", "f_kb", 3, 0)
f_kb(matchObj)
{
	TextBrief(matchObj, "keyboard", "Keyboard")
	return
}

#If
