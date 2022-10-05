import pandas as pd
import numpy as np

def prefilter(data, take_n_popular, item_features):
    popularity = data.groupby('item_id')['user_id'].nunique().reset_index() 
    popularity.rename(columns={'user_id': 'share_unique_users'}, inplace=True)
    popularity['share_unique_users'] = popularity['share_unique_users']/ data['user_id'].nunique()
#
    # Уберем самые популярные товары (их и так купят)
    top_popular = popularity[popularity['share_unique_users'] > 0.2].item_id.tolist()
    data = data[~data['item_id'].isin(top_popular)]
   # Уберем самые НЕ популярные товары (их и так НЕ купят)
    top_notpopular = popularity[popularity['share_unique_users'] < 0.02].item_id.tolist()
    data = data[~data['item_id'].isin(top_notpopular)]

    # Уберем товары, которые не продавались за последние 12 месяцев
    data = data[data['week_no'] < 53]
    
    # Уберем не интересные для рекоммендаций категории (department)
    department = ['CHEF SHOPPE', 'RX', 'CNTRL/STORE SUP', 'POSTAL CENTER', 'VIDEO RENTAL', 'GM MERCH EXP', 'TOYS', 'DAIRY DELI',
                  'DELI/SNACK BAR', 'PHOTO', 'CHARITABLE CONT', 'PROD-WHS SALES', 'AUTOMOTIVE', 'VIDEO', 'MEAT-WHSE', 'PHARMACY SUPPLY',
                  'HOUSEWARES', 'HBC', 'PORK', 'ELECT &PLUMBING']
    index = item_features.loc[~item_features['DEPARTMENT'].isin(department), 'PRODUCT_ID'].tolist()
    data = data[data['item_id'].isin(index)]

    # Уберем слишком дешевые товары (на них не заработаем). 1 покупка из рассылок стоит 60 руб.
    data = data[data['sales_value'] > 2]

    # Уберем слишком дорогие 
    data = data[data['sales_value'] < 400]
    
    # Возьмем топ по популярности
    pop = data.groupby('item_id')['quantity'].sum().reset_index()
    pop.rename(columns={'quantity': 'n_sold'}, inplace=True)
    top_5000 = pop.sort_values('n_sold', ascending=False).head(take_n_popular).item_id.tolist()
#
    #data = data[data['item_id'].isin(top_5000)]
#
## Заведем фиктивный item_id (если юзер не покупал товары из топ-5000, то он "купил" такой товар)
    #top_5000 = pop.sort_values('n_sold', ascending=False).head(take_n_popular).item_id.tolist()
    data.loc[~data_train['item_id'].isin(top_5000), 'item_id'] = 999999
#
return data


def postfilter_items(user_id, recommednations):
    pass