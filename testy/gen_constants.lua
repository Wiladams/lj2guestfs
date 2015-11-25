local pattern_pound_define = "#%s*define%s*(%g+)%s*(.+)"


local filename = arg[1] or "guestfs.h"

local function printConstants()
	print("ffi.cdef[[")
	for line in io.lines(filename) do
		local name, value = line:match(pattern_pound_define)
		if name ~= nil then
			value = value:gsub("UINT64_C", "(uint64_t)")
			io.write(string.format("static const int %s = %s;\n", name,value))
		end
	end
	print("]]")
end

local function printNonConstants()
	print("ffi.cdef[[")
	for line in io.lines(filename) do
		local name, value = line:match(pattern_pound_define)
		if name ~= nil then
			-- do nothing
		else
			line = line:gsub("GUESTFS_DLL_PUBLIC", "")
			print(line)
		end
	end
	print("]]")
end

--printConstants()
printNonConstants()