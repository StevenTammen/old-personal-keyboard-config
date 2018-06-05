Hotstring("(3[\ta-z'./;,\- 1\n]|2.|[./;,\- \t\n])(wo)([\t'./;,\- 1\n23])", "f_wo", 3, 0)
f_wo(matchObj)
{
	TextBrief(matchObj, "without", "Without")
	return
}