module scripts_gen

import json

// Struct to be generated
struct Root {
	my_name string [json: "my name"]
	cars []Cars 
}

struct Cars {
	name string 
	speed f32 
}


const str_object = r'
	{
	    "my name": "André",
		"cars": [
		    {
	            "name": "Fiesta",
	            "speed": 3.3
	        },
	        {
	            "name": "Focus",
	            "speed": 5
	        }
		]
	}
	'

fn test_simple_keys() {
	mut obj_analyzed := json.decode(Root, str_object)!

    assert obj_analyzed.my_name == "André"
    assert obj_analyzed.cars[0].name == "Fiesta"
    assert obj_analyzed.cars[0].speed == 3.3
    assert obj_analyzed.cars[1].name == "Focus"
    assert obj_analyzed.cars[1].speed == 5
}
