Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(wo)([\t'.\/;,\- 1\n23])", "f_wo", 3, 0)
f_wo(matchObj)
{
	TextBrief(matchObj, "without", "Without")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(st)([\t'.\/;,\- 1\n23])", "f_st", 3, 0)
f_st(matchObj)
{
	TextBrief(matchObj, "something", "Something")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(sn)([\t'.\/;,\- 1\n23])", "f_sn", 3, 0)
f_sn(matchObj)
{
	TextBrief(matchObj, "someone", "Someone")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(sb)([\t'.\/;,\- 1\n23])", "f_sb", 3, 0)
f_sb(matchObj)
{
	TextBrief(matchObj, "somebody", "Somebody")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(sw)([\t'.\/;,\- 1\n23])", "f_sw", 3, 0)
f_sw(matchObj)
{
	TextBrief(matchObj, "somewhere", "Somewhere")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(abt)([\t'.\/;,\- 1\n23])", "f_abt", 3, 0)
f_abt(matchObj)
{
	TextBrief(matchObj, "about", "About")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(mb)([\t'.\/;,\- 1\n23])", "f_mb", 3, 0)
f_mb(matchObj)
{
	TextBrief(matchObj, "maybe", "Maybe")
	return
}

Hotstring("(3[\ta-z'.\/;,\-21]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(kb)([\t'.\/;,\- 1\n23])", "f_kb", 3, 0)
f_kb(matchObj)
{
	TextBrief(matchObj, "keyboard", "Keyboard")
	return
}
