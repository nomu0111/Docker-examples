from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import os
import time

if __name__ == '__main__':
    # Selenium サーバへ接続
    driver = webdriver.Remote(
        command_executor="http://selenium:4444/wd/hub",
        options=webdriver.ChromeOptions()
    )

    server = "192.168.36.123:8081"
    # url = "http://192.168.36.123:8081/login"
    default_user = "admin"
    default_password = "admin"
    modify_password = "admin@redmine"

    driver.implicitly_wait(10) #seconds

    # ログイン画面にアクセス
    driver.get(f'http://{server}/login')

    # # ユーザーパスワードを入れてログイン
    driver.find_element(By.ID, "username").send_keys(default_user)
    driver.find_element(By.ID, "password").send_keys(default_password)
    # driver.find_element(By.ID, "password").send_keys(modify_password)
    driver.find_element(By.ID, "login-submit").click()

    time.sleep(3)

    # # 初期パスワードのへんこう
    driver.find_element(By.ID, "password").send_keys(default_password)
    driver.find_element(By.ID, "new_password").send_keys(modify_password)
    driver.find_element(By.ID, "new_password_confirmation").send_keys(modify_password)
    driver.find_element(By.NAME, "commit").click()

    time.sleep(2)

    # 登録
    driver.find_element(By.NAME, "commit").click()

    time.sleep(5)


    # 検索結果の画面キャプチャを取得し保存
    # FILENAME = os.path.join(os.path.dirname(os.path.abspath(__file__)), "img1.png") #ファイル名
    # w = driver.execute_script("return document.body.scrollWidth;")
    # h = driver.execute_script("return document.body.scrollHeight;")
    # driver.set_window_size(w,h)
    # driver.save_screenshot(FILENAME)

    #***********************
    # LDAP 設定
    # http://{server}/auth_sources/new
    driver.get(f'http://192.168.36.123:8081/auth_sources/new')

    # 検索結果の画面キャプチャを取得し保存
    FILENAME = os.path.join(os.path.dirname(os.path.abspath(__file__)), "ldap1.png") #ファイル名
    w = driver.execute_script("return document.body.scrollWidth;")
    h = driver.execute_script("return document.body.scrollHeight;")
    driver.set_window_size(w,h)
    driver.save_screenshot(FILENAME)

    driver.find_element(By.ID, "auth_source_name").send_keys("netssc")
    driver.find_element(By.ID, "auth_source_host").send_keys("192.168.46.21")
    driver.find_element(By.ID, "auth_source_port").send_keys("389")
    driver.find_element(By.ID, "auth_source_account").send_keys("assist@netssc.local")
    driver.find_element(By.ID, "auth_source_account_password").send_keys("NETssc-2005")
    driver.find_element(By.ID, "auth_source_base_dn").send_keys("OU=Staff,DC=netssc,DC=local")
    driver.find_element(By.ID, "auth_source_onthefly_register").click()
    driver.find_element(By.ID, "auth_source_attr_login").send_keys("SamAccountName")
    driver.find_element(By.ID, "auth_source_attr_firstname").send_keys("GivenName")
    driver.find_element(By.ID, "auth_source_attr_lastname").send_keys("Sn")
    driver.find_element(By.ID, "auth_source_attr_mail").send_keys("mail")
    driver.find_element(By.NAME, "commit").click()



    # 検索結果の画面キャプチャを取得し保存
    FILENAME = os.path.join(os.path.dirname(os.path.abspath(__file__)), "ldap.png") #ファイル名
    w = driver.execute_script("return document.body.scrollWidth;")
    h = driver.execute_script("return document.body.scrollHeight;")
    driver.set_window_size(w,h)
    driver.save_screenshot(FILENAME)



    driver.quit()

