import json
from flask import Flask,request,jsonify
import google.generativeai as genai
from distance_matrix import TSPModel
app = Flask(__name__)
@app.route('/',methods = ['GET'])
def returnascii():
    d={}
    inputstr = str(request.args['query'])
    lst=inputstr.split(',')
    a=lst[0]
    b=lst[1]
    c=lst[2]
    del lst[0]
    del lst[0]
    del lst[0]
    obj=TSPModel(lst)
    str1=a+","+b+","+c+","
    # for i in obj.places:
    lst1=obj.places.split(',')
    for i in range(1,len(lst1)):
        str1+=lst1[i]
    # return str1
    def model(s):
        genai.configure(api_key="AIzaSyB1OICYjUzxVZIrkO7texsBGw-ZeK-4K_s")
        generation_config = {
        "temperature": 0,
        "top_p": 1,
        "top_k": 1,
        "max_output_tokens": 2048,
        }
        
        safety_settings = [
        {
            "category": "HARM_CATEGORY_HARASSMENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_HATE_SPEECH",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        {
            "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
            "threshold": "BLOCK_MEDIUM_AND_ABOVE"
        },
        ]

        model = genai.GenerativeModel(model_name="gemini-1.0-pro",
                                    generation_config=generation_config,
                                    safety_settings=safety_settings)

        # prompt_parts = [
        # "\"Make a tour plan for these places in Chennai, the plan must  contains  place name, exact time slot, the entry fee, distance from previous loaction and travel time. Give results in minimum no days and  in python dict formate in single line eg {\"day1\"={\"place_name\":,\"time_slot\":,\"entry_fee\":,\"distance_from_previous_location\":,\"travel_time\":},\"day2\"=detials} .Maximum days="+s
        # ]
        
        # prompt_parts = [
        # "\"Make a tour plan for these places in Chennai, the plan must  contains  place name, exact time slot, the entry fee, distance from previous loaction and travel time. Give results in minimum no days and  in python dict formate in (single line) eg start with {\"index\"={\"day\":trip_day,\"place_name\":,\"time_slot\":,\"entry_fee\":,\"distance_from_previous_location\":,\"travel_time\":},\"index\"=detials} .Maximum days="+s,
        # ]
        prompt_parts = [
        "\"Make a tour plan for these places in Chennai, the plan must  contains  place name, exact time slot, the entry fee, distance from previous loaction and travel time. Give results in minimum no days and  in python dict formate in (single line) eg start with {\"index\"={\"day\":trip_day,\"place_name\":,\"time_slot\":,\"entry_fee\":,\"distance_from_previous_location\":,\"travel_time\":},\"index\"=detials} .Maximum days="+s,
        ]
        response = model.generate_content(prompt_parts)

        d['output'] = response.text
    # return str1    
    model(str1)
    # model(inputstr)
    return d
if __name__ == '__main__':
    app.run()