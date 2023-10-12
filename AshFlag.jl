module ArgParser

export Flag, Argu, parse_args

struct Flag
    flag::String
    num_args::Int
end

struct Argu
    flag::Flag
    arg::String
end

struct Put
    flag::String
    value
end


function get_array()
    arg_array = []
    for arg in ARGS
        push!(arg_array, arg)
    end
    return arg_array
end

function put_in_struct(arg_array::Array, flag_defs::Dict{String, Flag})
    flag_sym = "--"
    parsed_array = []
    i = 1
    while i <= length(arg_array)
        found = false
        for (flag_name, flag) in flag_defs
            if occursin("$(flag_sym)$(flag_name)", arg_array[i])
                num_args = flag.num_args
                if i + num_args <= length(arg_array)
                    parsed = Argu(flag, join(arg_array[i + 1:i + num_args], " ")) # Join the argument array into a single string
                    push!(parsed_array, parsed)
                else
                    println("Flag $(flag_sym)$(flag_name) is missing its argument.")
                end
                i += num_args + 1  # Move to the next argument after the flag and its arguments
                found = true
                break
            end
        end
        if !found
            println("Unrecognized argument: $(arg_array[i])")
            i += 1
        end
    end

    if isempty(parsed_array)
        println("No valid args")
        return false
    end

    return parsed_array
end

function process_args(parsed_args, flag_arg_types)
    processed_args = []
    for arg in parsed_args
        flag = arg.flag.flag
        num_args = arg.flag.num_args
        arg_value = arg.arg
        if num_args == 1
            processed_arg = convert_arg(flag, arg_value, flag_arg_types)
        else
            arg_values = split(arg_value)
            processed_arg = [convert_arg(flag, val, flag_arg_types) for val in arg_values]
        end
        push!(processed_args, Put(flag, processed_arg))
    end
    return processed_args
end

function convert_arg(flag, arg, flag_arg_types)
    if haskey(flag_arg_types, flag)
        if flag_arg_types[flag] == String
            return arg
        else
            return parse(flag_arg_types[flag], arg)
        end
    else
        return arg
    end
end



end
