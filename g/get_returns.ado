* will store into locals the return values from command (some commands should 1-liners!)
* Ex:
*   get_returns pvar=r(panelvar) tvar=r(timevar) : tsset, noquery
program get_returns
	gettoken my_opts 0: 0, parse(":")
	gettoken colon their_cmd: 0, parse(":")
	
	`their_cmd'
	foreach my_opt in `my_opts'{
		if regexm("`my_opt'","(.+)=(.+\(.+\))"){
			c_local `=regexs(1)' = "``=regexs(2)''"
		}
	}
end
