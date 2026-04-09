def convert_minutes(total_minutes):
    hours = total_minutes//60
    minutes= total_minutes%60 
    
    hr_label = "hr" if hours == 1 else "hrs"
    return f"{hours} {hr_label} {minutes} minutes"

print(convert_minutes(130))
print(convert_minutes(110))