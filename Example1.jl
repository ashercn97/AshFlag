# this is a sipmle example of using this module with just parsing arguements

include("AshFlag.jl")  # Include the ArgParser module

using .ArgParser

# Define the flags and their argument count
flag_definitions = Dict("age" => Flag("age", 1), "name" => Flag("name", 1), "add" => Flag("add", 2)) # the number is how many arguements are allowed


flag_arg_types = Dict(    # the types of the things
    "age" => Int,
    "name" => String,
    "add" => Int
)

parsed_args = ArgParser.put_in_struct(ArgParser.get_array(), flag_definitions)   # parses them into a messy but useable array
processed_args = ArgParser.process_args(parsed_args, flag_arg_types)             # puts them into a neater array

println(processed_args)
