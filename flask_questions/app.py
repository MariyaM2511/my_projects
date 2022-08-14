import json

from flask import Flask, jsonify, request
import dill
import pandas as pd
dill._dill._reverse_typemap['ClassType'] = type
from flask import Flask
import logging
from logging.handlers import RotatingFileHandler
from time import strftime
from flask import render_template




app = Flask(__name__)
model = None


handler = RotatingFileHandler(filename='app.log', maxBytes=100000, backupCount=10)
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(handler)

def load_model(model_path):
	# load the pre-trained model
	global model
	with open(model_path, 'rb') as f:
		model = dill.load(f)
	print(model)
	return model

modelpath = "pipeline.dill"
load_model(modelpath)


@app.route('/')
def index():
    return render_template('index.html')



@app.route('/prediction', methods=['GET', 'POST'])

def comment_checking():
    dt = strftime("[%Y-%b-%d %H:%M:%S]")
    # handle the POST request
    if request.method == 'POST':
        data = request.form.get('text')
        text = {"Text": data}
        text = json.dumps(text)
        text = json.loads(text)
        if text["Text"]:
            text = text['Text']
        with open('pipeline.dill', 'rb') as in_strm:
            model = dill.load(in_strm)
        try:
            answer = ''
            preds = model.predict(pd.DataFrame({'Text': [text]}))
            if preds[0] == 0:
                answer = 'HQ'
            elif preds[0] == 1:
                answer = 'LQ_CLOSE'
            elif preds[0] == 2:
                answer = 'LQ_EDIT'
            print(text)
            print(preds[0])


        except AttributeError or TypeError as e:
            logger.warning(f'{dt} Exception: {str(e)}')
            return '''
                <h1>The question is not correct</h1>'''

        return render_template('result.html', answer = answer)


    # otherwise handle the GET request
    return render_template('prediction.html')

if __name__ == '__main__':
    app.run(debug=True, port=5000,host='0.0.0.0')