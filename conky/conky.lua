
-- string formatting
function conky_uppercase( s )
	return string.upper( conky_parse( s ) )
end

function conky_format( format, s )
	s = conky_parse( s )
	u = string.match( s, "%a+" )
	n = string.match( s, "[0-9.]+" )
	if u == nil or u == "" then
		return string.format( format, n )
	end
	return string.format( format, n ) .. u
end

function conky_ceil( s )
	return string.format( "%.0f", math.ceil( conky_parse( s ) ) )
end

function conky_battery ( s1, s2 )
	s1 = conky_parse( s1 )
	m = string.match( s1, "%a+" )
	p = string.match( s1, "[0-9]+" )
	s2 = conky_parse( s2 )
	return m .. ": ${alignr}" .. s2 .. " (" .. p .. "%)"
end

