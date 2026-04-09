def remove_duplicates(input_string):
    result=""
    for char in input_string:
        if char not in result:
            result+=char
    return result

input_string = "programming"
unique_string = remove_duplicates(input_string)

print(f"Original: {input_string}")
print(f"Unique: {unique_string}")

        