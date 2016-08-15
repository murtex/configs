
-- string formatting
function conky_uppercase( s )
	return string.upper( conky_parse( s ) )
end

function conky_format( format, s )
	s = conky_parse( s )
	u = string.match( conky_parse( s ), "%a+" )
	n = string.match( conky_parse( s ), "[0-9.]+" )
	if u == nil or u == "" then
		return string.format( format, n )
	end
	return string.format( format, n ) .. u
end

function conky_ceil( s )
	return string.format( "%.0f", math.ceil( conky_parse( s ) ) )
end

