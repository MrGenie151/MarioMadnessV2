import json

import os

# Get the current directory of the script
current_directory = os.path.dirname(os.path.abspath(__file__))

# Path to the JSON file
json_file_path = os.path.join(current_directory, "data", "its-a-me", "it-a-me-noevents.json")

# Check the absolute path for debugging
print("Absolute path:", json_file_path)

# Check if the file exists
if os.path.exists(json_file_path):
    print("File exists!")
else:
    print("File does not exist.")

# Sample JSON data
json_data = '''
'''

with open("C:/Users/bj/Documents/PsychEngine/mods/MarioMadnessV2/data/unbeatable/unbeatable.json","r") as f:
	json_data = f.read()

# Load JSON data
parsed_data = json.loads(json_data)

# Function to remove arrays containing -1 in sectionNotes
def remove_arrays_with_negative_one(data):
    data["song"]["arrowSkin"] = "Mario_NOTE_assets"
    data["song"]["disableNoteRGB"] = True
    for item in data['song']['notes']:
        for note in item["sectionNotes"]:
            if note[1] == -1:
                thingy = [
                    note[0],
                    [
                        [
                            note[2],
                            note[3],
                            note[4]
                        ]
                    ]
                ]
                data["song"]["events"].append(thingy)
        item["sectionNotes"] = [note for note in item["sectionNotes"] if note[1] != -1]
    return data

# Remove arrays containing -1 in sectionNotes
filtered_data = remove_arrays_with_negative_one(parsed_data)

# Convert filtered data back to JSON
filtered_json = json.dumps(filtered_data, indent=4)
with open("whohoo.json","w") as f:
    f.write(filtered_json)
