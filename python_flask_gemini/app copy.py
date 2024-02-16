from flask import Flask,request,jsonify
import google.generativeai as genai
app = Flask(__name__)

@app.route('/api',methods = ['GET'])
def returnascii():
    d={}
    intputstr = str(request.args['query'])
    # answer = str(ord(intputchr))
    # lst=str.split(",")
    """
    At the command line, only need to run once to install the package via pip:

    $ pip install google-generativeai
    """

    genai.configure(api_key="AIzaSyB1OICYjUzxVZIrkO7texsBGw-ZeK-4K_s")

    # Set up the model
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
    # "Make a tour plan for these places in Chennai within 2 days, the plan must be optimized based on the minimum distance and time to travel, the best time to visit, and the entry fee with an exact time slot. give results in table formate each day separately.\n1. Kapaleeshwarar\n2. Snow Kingdom\n3. Besant Nagar Beach\n4. San Thome Church Day \n5. Marina beach\n",
    # ]

    prompt_parts = [
    "Make a tour plan for these places in Chennai within 2 days, the plan must be optimized based on the minimum distance and time to travel, the best time to visit, and the entry fee with an exact time slot. give results in table formate each day separately."+intputstr,
    ]

    response = model.generate_content(prompt_parts)
    # print(response.text)

        # json_file = {}
    d['output'] = response.text
        # d['output1']=answer
    return jsonify(d)





        # d['output']=answer
        # return d


if __name__ == '__main__':
    app.run()