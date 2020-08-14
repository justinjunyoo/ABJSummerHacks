import firebase_admin
import csv
import google.cloud
import xlrd 
from firebase_admin import credentials, firestore
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import os

os.remove("Texas COVID-19 Case Count Data by County.xlsx")
def enable_download_headless(browser,download_dir):
    browser.command_executor._commands["send_command"] = ("POST", '/session/$sessionId/chromium/send_command')
    params = {'cmd':'Page.setDownloadBehavior', 'params': {'behavior': 'allow', 'downloadPath': download_dir}}
    browser.execute("send_command", params)

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--window-size=1920x1080")
chrome_options.add_argument("--disable-notifications")
chrome_options.add_argument('--no-sandbox')
chrome_options.add_argument('--verbose')
chrome_options.add_experimental_option("prefs", {
        "download.default_directory": "<path_to_download_default_directory>",
        "download.prompt_for_download": False,
        "download.directory_upgrade": True,
        "safebrowsing_for_trusted_sources_enabled": False,
        "safebrowsing.enabled": False
})
chrome_options.add_argument('--disable-gpu')
chrome_options.add_argument('--disable-software-rasterizer')


#Scrape data from excel on Texas Department of Health Services Website
driver2 = webdriver.Chrome(chrome_options=chrome_options, executable_path=r'<path_to_chromedriver>')

download_dir = "path_to_download_default_directory"

enable_download_headless(driver2, download_dir)

driver2.get("https://www.dshs.texas.gov/coronavirus/additionaldata/")

driver2.find_element_by_xpath('//*[@id="ctl00_ContentPlaceHolder1_uxContent"]/ul[1]/li[1]/a').click()

loc = ('path_to_Texas COVID-19 Case Count Data by County.xlsx')

def getCases(county):
    wb = xlrd.open_workbook(loc) 
    sheet = wb.sheet_by_index(0)
    x = 2
    column = sheet.ncols
    temp = sheet.row_values(x)
    name = temp[0]
    res = []
    if (str(county) == 'Texas Total'):
        county = 'Total'
    while( name != str(county) ):
        x += 1
        temp = sheet.row_values(x)
        name = temp[0]
        if x > 270:
            break
    if name == str(county): 
        for i in range(2,column):
            res.append(temp[i])
            i += 1
    return res


def getDates():
    wb = xlrd.open_workbook(loc) 
    sheet = wb.sheet_by_index(0)
    x = 2
    column = sheet.ncols
    temp = sheet.row_values(x)
    name = temp[0]
    res = []
    for i in range(2,column):
        temp[i] = temp[i].replace('\r', '')
        temp[i] = temp[i].replace('Cases', '')
        temp[i] = temp[i].replace('\n', '')
        temp[i] = temp[i].replace('*', '')
        temp[i] = temp[i].replace(' ', '')

        res.append(temp[i])
        i += 1
    return res



# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
cred = credentials.Certificate("./ServiceAccountKey.json")
app = firebase_admin.initialize_app(cred)
store = firestore.client()
doc_ref = store.collection(u'Counties')

#Scrape Data from Worldometer Texas Website

options = Options()
options.headless = True
options.add_argument("--window-size=1920,1200")
driver = webdriver.Chrome(options=options, executable_path=r'<path_to_chromedriver>')
driver.get("https://www.worldometers.info/coronavirus/usa/texas/")



for i in range(1, 255):
    temp = str(i)

    countyName = driver.find_element_by_xpath('//*[@id="usa_table_countries_today"]/tbody[1]/tr['+temp+']/td[1]')
    countyDeaths = driver.find_element_by_xpath('//*[@id="usa_table_countries_today"]/tbody[1]/tr['+temp+']/td[4]')

    deaths = countyDeaths.text.replace(',', '')
    if deaths == '' :
        deaths = int(0)
    daily = []
    daily = getCases(countyName.text)
    if i == 2:
        dates = getDates()
        store.collection(u'TexasTotal').document(str("Dates")).set({u'Dates': list(dates)})
        
    if daily == []:
        continue

    if countyName.text == "Texas Total":
        store.collection(u'TexasTotal').document(str("Texas")).set({u'Name': str(countyName.text), u'Cases': int(daily[-1]), u'Deaths': int(deaths)})
        store.collection(u'TexasTotal').document(str(countyName.text)).set({u'Name': str(countyName.text), u'Cases': int(daily[-1]), u'Deaths': int(deaths), u'Trend_Cases': list(daily)})

    doc_ref.document(str(countyName.text)).set({u'Name': str(countyName.text), u'Cases': int(daily[-1]), u'Deaths': int(deaths), u'Trend_Cases': list(daily)})
    
    
    
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
print("DONE")
driver.close() 

