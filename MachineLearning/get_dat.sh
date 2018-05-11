#!/bin/tcsh

foreach line ("`cat crossed_data.txt`")
	set argv = ( $line )
	set from = $1
	set to = $2
	set day = $3
	python expedia.py $from $to $day
	wait
end


exit 0