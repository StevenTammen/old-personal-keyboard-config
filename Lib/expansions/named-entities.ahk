Hotstring("(\\pi)([\t'./;,\- 1\n23])", "f_pi", 3, 0)
f_pi(matchObj)
{
	NamedEntity(matchObj, "π")
	return
}
