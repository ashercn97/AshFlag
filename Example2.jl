# --------------- #
#  a simple cli   #
#  cli calculator #
# --------------- #

include("AshFlag.jl")  # Include the ArgParser module

using .ArgParser

# Define the flags and their argument count
flag_definitions = Dict("op" => Flag("op", 1), "nums" => Flag("nums", 2)) # op is the operation, nums takes two numbers as input (the 2)


flag_arg_types = Dict(
    "op" => String,
    "nums" => Int,
)

parsed_args = ArgParser.put_in_struct(ArgParser.get_array(), flag_definitions)
processed_args = ArgParser.process_args(parsed_args, flag_arg_types) #same as other eexxample

#println(processed_args)

num1 = processed_args[2].value[1]    # makes it easier to use
num2 = processed_args[2].value[2]    # makes it easier to use

op = processed_args[1].value 

if op == "add"
    println(num1 + num2)
elseif op == "sub"
    println(num1 - num2)
elseif op == "mul"
    println(num1 * num2)
elseif op == "div"
    println(num1/num2)
else
    println("not a valid operation")
end
