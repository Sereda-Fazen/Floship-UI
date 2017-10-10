#!/usr/bin/env python3

import re

import requests
import selenium
from selenium.webdriver.common.by import By
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.ui import WebDriverWait
from time import sleep

def find_element(driver, locator):
    return WebDriverWait(driver, 10).until(expected_conditions.presence_of_element_located(locator))


if __name__ == '__main__':
    devtools_proxy_port = 9801

    desired_capabilities = DesiredCapabilities.CHROME.copy()
    print('--devtools-proxy-args=--port {}'.format(devtools_proxy_port))
    desired_capabilities['chromeOptions'] = {
        'binary': '/home/alex/Загрузки/devtools/chrome-wrapper.sh',
        'args': [
            '--devtools-proxy-binary={}'.format('/home/alex/Загрузки/devtools/devtools-proxy'),
            '--devtools-proxy-args=--port {}'.format(devtools_proxy_port)
        ]
    }

    driver = selenium.webdriver.Chrome(desired_capabilities=desired_capabilities)

    version = requests.get('http://localhost:{}/json/version'.format(devtools_proxy_port)).json()
    webkit_version = version['WebKit-Version']  # 537.36 (@8ee402c67ff2f8f7c746e56d3530b4dcec0709ad)
    webkit_hash = re.search(r'\((.+)\)', webkit_version).group(1)  # @8ee402c67ff2f8f7c746e56d3530b4dcec0709ad

    tabs = requests.get('http://localhost:{}/json/list'.format(devtools_proxy_port)).json()
    tab = next(tab for tab in tabs if tab.get('type') == 'page')
    devtools_frontend_url = tab['devtoolsFrontendUrl']
    devtools_frontend_url = re.sub(r'^/devtools/', '', devtools_frontend_url)

    url_template = 'https://chrome-devtools-frontend.appspot.com/serve_file/{}/{}&remoteFrontend=true'
    url = url_template.format(webkit_hash, devtools_frontend_url)
    print(url)

    driver.get('http://google.co.uk')
    driver.find_element_by_name('q').send_keys('Something')
    sleep(100)
    driver.quit()