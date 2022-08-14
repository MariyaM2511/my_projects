import pandas as pd
import numpy as np
import dill
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline, make_pipeline
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import LabelEncoder
from html import unescape
import re
from sklearn.linear_model import LogisticRegression

train_data = pd.read_csv("train.csv")
valid_data = pd.read_csv("valid.csv")

data = pd.concat([train_data, valid_data])

data['Text']=data['Title']+' '+data['Body']

def delete_html_chars(text):
        parsed_text = unescape(text)
        return parsed_text

data['Text'] = data['Text'].apply(delete_html_chars)


def text_clean(text):
    if not isinstance(text, str):
        text = str(text)

    text = text.lower()
    text = text.strip('\n').strip('\r').strip('\t')
    text = re.sub("-\s\r\n\|-\s\r\n|\r\n", '', str(text))

    text = re.sub("[0-9]|[-—.,:;_%©«»?*!@#№$^•·&()]|[+=]|[[]|[]]|[/]|", '', text)
    text = re.sub(r"\r\n\t|\n|\\s|\r\t|\\n", ' ', text)
    text = re.sub(r'[\xad]|[\s+]', ' ', text.strip())
    text = re.sub('[^\w\s]', '', text)
    text = re.sub(r'<.*?>', '', text)
    return text

data['Text'] = data['Text'].apply(text_clean)


le = LabelEncoder()
data['Class']=le.fit_transform(data['Y'])

new_data = data[['Text', 'Class']]

X_train, X_test, y_train, y_test = train_test_split(new_data.drop(columns=['Class']),
                                                    new_data['Class'], random_state=0)

class FeatureSelector(BaseEstimator, TransformerMixin):
    def __init__(self, column):
        self.column = column

    def fit(self, X, y=None):
        return self

    def transform(self, X, y=None):
        return X[self.column]


classifier_LG = Pipeline([('comment_text_selector', FeatureSelector(column='Text')),
                       ('comment_text_tfidf', TfidfVectorizer(strip_accents='unicode',
                                                              analyzer='word',
                                                              token_pattern=r'\w{1,}',
                                                              stop_words='english',
                                                              max_features=5000)),
                       ('clf', LogisticRegression(max_iter=5000))])
classifier_LG.fit(X_train, y_train)

with open("pipeline.dill", "wb") as f:
    dill.dump(classifier_LG, f)