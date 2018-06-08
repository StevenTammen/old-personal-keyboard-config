Hotstring("(3[\ta-z'.\/;,\- 1]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(wo)([\t'.\/;,\- 1\n23])", "f_wo", 3, 0)
f_wo(matchObj)
{
	TextBrief(matchObj, "without", "Without")
	return
}

Hotstring("(3[\ta-z'.\/;,\- 1]|2|2[\t'.\/;,\- ]|[\t.\/;,\- \n])(sth)([\t'.\/;,\- 1\n23])", "f_sth", 3, 0)
f_sth(matchObj)
{
	TextBrief(matchObj, "something", "Something")
	return
}