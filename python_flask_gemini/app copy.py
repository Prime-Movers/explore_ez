from flask import Flask,request,jsonify
import google.generativeai as genai
from distance_matrix import TSPModel


app = Flask(__name__)

@app.route('/api',methods = ['GET'])
def returnascii():
    d={}
    inputstr = str(request.args['query'])
    lst=inputstr.split(',')
    a=lst[0]
    del lst[0]
    obj=TSPModel(lst)
    d["output1"]=obj.places
    # obj+=a
    str1=a
    for i in obj.places:
        str1+=i
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


        prompt_parts = [
        "Make a tour plan for these places in Chennai, the plan must be optimized based on  the best time to visit, and the entry fee with an exact time slot. give results in table formate each day separately.Within no of days"+s
        ]

        response = model.generate_content(prompt_parts)

        d['output'] = response.text
    model(str1)    
    # return jsonify(d)
    return d 
if __name__ == '__main__':
    app.run()