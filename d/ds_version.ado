*! v0.3 Brian Quistorff <bquistorff@gmail.com>
*! Shows the version of the Stata dataset whose filename is passed in.
program ds_version, rclass
	version 11.0 //just a guess here
	args fname
	tempname fhandle v
	file open `fhandle' using `fname', read binary
	file read  `fhandle' %1s firstbytechar
	if "`firstbytechar'"=="<"{
		*In the future there will be more versions, so have to read ahead
		di "Minimum Version 117."
		di "This utility doesn't not have a full XML parser."
		di "I will attempt to get the version number from where"
		di "it would be stored if Stata saved this file."
		file seek `fhandle' 28
		file read  `fhandle' %3s ver_str
		scalar `v'=`ver_str'
		di "Found version " `v'
	}
	else {
		mata: st_numscalar("v", ascii("`firstbytechar'"))
		di "Version " `v'
	}
	file close `fhandle'
	return scalar version = `v'
end
