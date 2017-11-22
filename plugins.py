import time
from os import path, system

from pip import logger

# def uploaded_file(file_name):
#     file_path_list = path.join(path.join('../Floship-UI', 'utils'), file_name).split('/')
#     for word in file_path_list:
#         if word:
#             system('xdotool key 61')
#             system('xdotool type --delay 30 "{}"'.format(word))
#     time.sleep(3)
#     system('xdotool key 104')
#     logger.info('File "{}" was uploaded successfully'.format(file_name))


import csv
import random

def write_test(so):
    FILENAME = "testOrder.csv"

    users = [
        ["SO Number"],
        [so]
    ]
    with open(FILENAME, "w") as file:
        writer = csv.writer(file)
        writer.writerows(users)


def include_sku_for_role(sku):
    uniqSku = "../Floship-UI/bulk/product/for_roles_sku.csv"

    with open(uniqSku, "w") as file:
        writer = csv.writer(file)
        writer.writerows([["SKU*", "Description*", "Brand/Manufacturer", "UPC/EAN/MPN", "Harmonized Code", "Gross Weight (kg)*",
                           "Gross Length (cm)*", "Gross Width (cm)*", "Gross Height (cm)*", "Customs Value (USD)*", "Customs Description*",
                           "Category (if known)", "Lithium Ion Battery (Y/N)", "Expiry Date (Y/N)", "Liquid (Y/N)", "Item Image URL",
                           "Packaging SKU*", "Country of Manufacture", "Unit QTY", "Unit type"],
                          [sku, "A product one", "Example Co", "1234567890", "987654321", "1", "10", "12", "5", "123", "A product one",
                           "", "Y", "N", "N", "www.example.com/product_image.jpg", "SHIP-READY", "CN", "1", "base item"]])


def include_order_id_for_role(order, sku_item, express):
    uniqOrderId = "../Floship-UI/bulk/order/for_roles_order.csv"

    with open(uniqOrderId, "w") as file:
        writer = csv.writer(file)
        writer.writerows(
            [["OrderID*", "Insurance Value (in USD)", "Company", "Contact Name*", "Address 1*", "Address 2", "City", "State", "Zip Code",
              "Country Code* (2-letter)", "Phone*", "Email", "Unit Value (in USD)", "Shipping Option", "Quantity*", "Item SKU*", "Packaging Item"],

             [order, "10", "ACME INC", "JANE DARE", "123 ACME LANE", "", "SAMPLE CITY 1", "IL", "12345", "US", "(555) 555-5555",
              "JANE@EXAMPLE.COM", "1.23", express, "1", sku_item, "SHIP-READY"]])


def include_data_crowd(order, sku_item):
    uniqCrowd = "crowd.csv"

    with open(uniqCrowd, "w") as file:
        writer = csv.writer(file)
        writer.writerows(
            [["OrderID*", "Insurance Value (in USD)", "Company", "Contact Name*", "Address 1*", "Address 2",
              "City", "State", "Zip Code",
              "Country Code* (2-letter)", "Phone*", "Email", "Unit Value (in USD)", "Shipping Option",
              "Quantity*", "Item SKU*", "Packaging Item"],

             [order, "10", "ACME INC", "JANE DARE", "123 ACME LANE", "", "SAMPLE CITY 1", "IL", "12345", "US",
              "(555) 555-5555",
              "JANE@EXAMPLE.COM", "1.23", "Free Shipping", "1", sku_item, "SHIP-READY"]])


def sales_order_cost(fs_number):
    uniqCrowd = "../Floship-UI/cost_sales_order/actual_cost.csv"

    with open(uniqCrowd, "w") as file:
        writer = csv.writer(file)
        writer.writerows(
            [["SO Number", "Tracking number", "Actual cost"],

             [fs_number, "", "11"]])


def vendor_cost(fs_number):
    uniqCrowd = "../Floship-UI/cost_sales_order/vendor_bill_template.csv"

    with open(uniqCrowd, "w") as file:
        writer = csv.writer(file)
        writer.writerows(
            [["Bill reference", "Order number", "Tracking number", "Length", "Width", "Height", "Weight",
              "Vendor labour cost", "Vendor shipping cost"],

             ["12345", fs_number, "", "10", "10", "10", "7", "3.1", "4.2"]])

#
# def main():
#     id = generate_4_random_and_unique_numbers()
#
# if __name__ == '__main__':
#     main()