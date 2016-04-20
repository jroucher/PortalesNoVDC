# -*- coding: utf-8 -*-
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import NoSuchElementException

from toolium.pageobjects.page_object import PageObject
from toolium.pageelements import *

import time, string, random

class PasswordPageObject(PageObject):
    def init_page_elements(self):
        return self;

    def setElements(self):
        self.username = InputText(By.ID, 'MainContent_UserName')
        self.password = InputText(By.ID, 'MainContent_Password')
        self.passwordA = InputText(By.ID, 'MainContent_NewPassword')
        self.passwordB = InputText(By.ID, 'MainContent_NewPasswordRepeat')
        self.saveBtn = Button(By.ID, "BnChPwd")
        self.clearBtn = Button(By.ID, "BnClear")
        self.form = self.driver.find_element_by_id('FrmFieldsContainer')
        return self;

    def open(self, sectionName = None):
        """ Open app url in browser
        :returns: this page object instance
        """
        url = self.config.get('Common', 'url')
        self.driver.get(url)
        return self

    def waitToDrawSection(self):
        self.utils.wait_until_element_visible(Text(By.ID, "FrmFieldsContainer").locator)
        return self

    def waitToServerResponse(self):
        self.utils.wait_until_element_visible(Text(By.ID, "progressTable").locator)
        return self

    def waitToSendRequestAndActiveOkBoton(self, timeout=60):
        locator = Button(By.ID, "BnChPwd").locator
        WebDriverWait(self.utils.driver_wrapper.driver, timeout).until(EC.element_to_be_clickable(locator))
        return self

    def setLanguage(self, id):
        idMap = {
            'es': 'LiteralSpanish',
            'en': 'LiteralEnglish',
            'pt': 'LiteralBrazilian'
        }
        # open select
        self.driver.find_element_by_xpath('//div[@class="language-header-selector"]').click()
        # click on button
        Button(By.ID, idMap.get(id, '')).click()
        return self

    def nodeHasError(self, LDAPNodeId):
        return self.hasElement('//*[@id="%s"]//*[@class="text-danger"]' % (LDAPNodeId))

    def nodeGetErrors(self, LDAPNodeId):
        return self.driver.find_elements_by_xpath('//*[@id="%s"]//*[class="text-danger"]' % (LDAPNodeId))

    def getConfigSection(self, section):
        config = {}
        options = self.config.options(section)
        for option in options:
            try:
                config[option] = self.config.get(section, option)
            except:
                config[option] = None
        return config

    def newPasswordHasError(self):
        return self.hasElement('//*[@id="NewPasswordHelper"]//ul[@role="alert"]')

    def newPasswordCopyHasError(self):
        return self.hasElement('//*[@id="NewPasswordCopyHelper"]//ul[@role="alert"]')

    def fornIsInvalid(self):
        return self.hasElement('//p[@class="help-block"]/ul[@role="alert"]')

    def hasElement(self, xpath):
        try:
            self.driver.find_element_by_xpath(xpath)
        except NoSuchElementException:
            return False
        return True

    def getMessageOfNode(self, nodeId):
        ele = Text(By.XPATH, '//*[@id="%s"]//label' % (nodeId))
        return ele.text

