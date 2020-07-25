import firebase_admin
import csv
import google.cloud
import xlrd 
from firebase_admin import credentials, firestore
from selenium import webdriver
from selenium.webdriver.chrome.options import Options


def getCases(county):
    loc = ('/Users/aarishbrohi/Desktop/brandon_work/webs/TexasData.xlsx')
    wb = xlrd.open_workbook(loc) 
    sheet = wb.sheet_by_index(0)
    sheet.cell_value(0, 0)
    x = 3
    dog = sheet.row_values(x)
    name = dog[0]
    cat = []
    if (str(county) == 'Texas Total'):
        county = 'Total'
    while( name != str(county) ):
        x += 1
        dog = sheet.row_values(x)
        name = dog[0]
        if x > 270:
            break
    if name == str(county): 
        for i in range (2,139):
            cat.append(dog[i])
    return cat


# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cred = credentials.Certificate("./ServiceAccountKey.json")
app = firebase_admin.initialize_app(cred)
store = firestore.client()
doc_ref = store.collection(u'Counties')


options = Options()
options.headless = True
options.add_argument("--window-size=1920,1200")
driver = webdriver.Chrome(options=options, executable_path=r'/Users/aarishbrohi/Desktop/brandon_work/webs/chromedriver')
driver.get("https://www.worldometers.info/coronavirus/usa/texas/")



for i in range(1, 31):
    temp = str(i)
    countyName = driver.find_element_by_xpath('//*[@id="usa_table_countries_today"]/tbody[1]/tr['+temp+']/td[1]')
    countyCases = driver.find_element_by_xpath('//*[@id="usa_table_countries_today"]/tbody[1]/tr['+temp+']/td[2]')
    countyDeaths = driver.find_element_by_xpath('//*[@id="usa_table_countries_today"]/tbody[1]/tr['+temp+']/td[4]')
    cases = countyCases.text.replace(',', '')
    deaths = countyDeaths.text.replace(',', '')
    daily = []
    daily = getCases(countyName.text)



#   u'Daily Cases': list(countyCases


    # doc_ref.document(str(countyName.text)).set({u'Name': str(countyName.text), u'Cases': int(cases), u'Deaths': int(deaths), u'Trend_Cases': list(daily)})
    if countyName.text == "Texas Total":
    #     store.collection(u'TexasTotal').document(u'Texas Total').delete()
    #     store.collection(u'TexasTotal').document(str(countyName.text)).set({u'Name': str(countyName.text), u'Cases': int(cases), u'Deaths': int(deaths), u'Trend_Cases': list(daily)})
        store.collection(u'TexasTotal').document(str(countyName.text)).update({u'Trend_Cases': firestore.ArrayUnion([int(cases)])})
        # ^^ only run once daily  

    doc_ref.document(str(countyName.text)).update({u'Name': str(countyName.text), u'Cases': int(cases), u'Deaths': int(deaths)})
    doc_ref.document(str(countyName.text)).update({u'Trend_Cases': firestore.ArrayUnion([int(cases)])})
    

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



print("---------------------------------------------------------------------")
# print(countyName.text)
# print(countyCases.text)
# print(countyDeaths.text)
print("DONE")
driver.close() 




# current_price = driver.find_element_by_xpath("//span[@id='prcIsum']")
# image = driver.find_element_by_xpath("//img[@id='icImg']")

# product_data = {
# 	'title': title.text,
# 	'current_price': current_price.get_attribute('content'), 
# 	'image_url': image.get_attribute('src')
# }


#Reading From Firestore
# store = firestore.client()
# doc_ref = store.collection(u'users').limit(2)

# try:
#     docs = doc_ref.get()
#     for doc in docs:
#         print(u'Doc Data:{}'.format(doc.to_dict()))
# except google.cloud.exceptions.NotFound:
#     print(u'Missing data')



#Writing into Firestore
# store = firestore.client()

# doc_ref = store.collection(u'test')
# doc_ref.add({u'name': u'test', u'added': u'just now'})
# file_path = "readCSV.csv"
# collection_name = "FINALTEST"


# def batch_data(iterable, n=1):
#     l = len(iterable)
#     for ndx in range(0, l, n):
#         yield iterable[ndx:min(ndx + n, l)]


# data = []
# headers = []
# with open(file_path) as csv_file:
#     csv_reader = csv.reader(csv_file, delimiter=',')
#     line_count = 0
#     for row in csv_reader:
#         if line_count == 0:
#             for header in row:
#                 headers.append(header)
#             line_count += 1
#         else:
#             obj = {}
#             for idx, item in enumerate(row):
#                 obj[headers[idx]] = item
#             data.append(obj)
#             line_count += 1
#     print(f'Processed {line_count} lines.')

# for batched_data in batch_data(data, 499):
#     batch = store.batch()
#     for data_item in batched_data:
#         doc_ref = store.collection(collection_name).document()
#         batch.set(doc_ref, data_item)
#     batch.commit()

# print('Done')
