
*** Variables ***
# Url's
${BROWSER}                      chrome
${WIDTH}                        1920
${HEIGHT}                       1080
${SERVER}                       https://floship-staging.herokuapp.com
${ADMIN}                        ${SERVER}/admin-backend/
${login_email}                  xpath=//input[@id='validation-email']
${login_pass}                   xpath=//input[@id='validation-password']
${Signup}                       xpath=//button[@type='submit']
${Add user}                     xpath=//div[@class="dashboard-item-content"]//a[@class="addlink icon"]
${Reset pass}                   12345678

${Log in}                       xpath=//a[@class="btn btn-primary"]


#Data for geristration
${comp name}                     mycompany_
${comp email}                    testfloship@gmail.com
${first name}                    Steve
${last name}                     Vai
${phone}                         1234567890
${address_1}                     Street 1
${city}                          New York
${state}                         NY
${post code}                     124456
${country}                       United States of America
${mycompany}                     MyCompany
# payment

${agree}                         xpath=//label/input
${card num}                      4111 1111 1111 1111
${exp date}                      1020
${cvv}                           123

# 3Pl
${3pl}                           xpath=//div[@class='form-row field-default_3pl']//span[@role='combobox']


#add_product_page:
${sku_field}                xpath=//input[@ng-model='$ctrl.product.sku']
${description_field}        xpath=//input[@ng-model='$ctrl.product.description']
${cust_description_field}   xpath=//input[@ng-model='$ctrl.product.customs_description']
${harmonized_code_field}   xpath=//input[@ng-model='$ctrl.product.harmonized_code']
${packaging_combobox}     xpath=//select[@ng-model='$ctrl.product.inventory_items.base_item.packaging_type']
${packaging_list}        xpath=//select[@ng-model='$ctrl.product.inventory_items.base_item.packaging_type']/option
${customs_value_field}   xpath=//input[@ng-model='$ctrl.product.customs_value.amount']
${width_field}           xpath=//input[@ng-model='$ctrl.product.inventory_items.base_item.gross_width']
${height_field}          xpath=//input[@ng-model='$ctrl.product.inventory_items.base_item.gross_height']
${length_field}          xpath=//input[@ng-model='$ctrl.product.inventory_items.base_item.gross_length']
${weight_field}           xpath=//input[@ng-model='$ctrl.product.inventory_items.base_item.gross_weight']
${save_button}            xpath=//button[@ng-click='$ctrl.submit()']
${any_tooltip}           xpath=//div[@id='toast-container']/div
${tooltip_message}      xpath=//div[@id='toast-container']//div[@ng-switch-default]


#asn_details_page:
${calendar_button}      xpath=//i[@class='icmn-calendar']
${today_button}         xpath=//li[@ng-if='showButtonBar']/span/button[1]
${upload_file}          xpath=//div[@ngf-select='upload($files)']
${contact_name_field}   xpath=//input[@ng-model='$ctrl.asn.contact_name']
${full_name_field}      xpath=//input[@ng-model='$ctrl.asn.addressee']
${address_1_field}      xpath=//input[@ng-model='$ctrl.asn.address_1']
${city_field}           xpath=//input[@ng-model='$ctrl.asn.city']
${state_field}          xpath=//input[@ng-model='$ctrl.asn.state']
${postal_code_field}    xpath=//input[@ng-model='$ctrl.asn.postal_code']
${post_code}            10003
${country_select}       xpath=//input[@ng-model='$select.search']
${country_select_list}   xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
${items_field}          xpath=//div[@class='modal-content']//input[@id='_value']
${items_list}           css=div.angucomplete-description


# shipping option
${som_name_field}       xpath=//input[@ng-model='$ctrl.som.shipping_option']

# group items

${sku_field_group}           xpath=//input[@ng-model='$ctrl.groupItem.sku']
${description_field_group}   xpath=//input[@ng-model='$ctrl.groupItem.description']
${items_field_gr}         xpath=//div[@class='modal-content']//input[@id='_value']
${items_list}          xpath=//div[@ng-click='selectResult(result)']/div[@ng-bind-html='result.description']

#Order

#add_order_page:
${full_name_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.addressee']
${address_1_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.address_1']
${city_field_order}       xpath=//input[@ng-model='$ctrl.order.shipping_address.city']
${state_field_order}      xpath=//input[@ng-model='$ctrl.order.shipping_address.state']
${postal_code_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.postal_code']
#${country_select_order}       xpath=//div[@ng-model='$ctrl.order.shipping_address.country']/div/input
#${country_select_list_order}  xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
${phone_field_order}      xpath=//input[@ng-model='$ctrl.order.shipping_address.phone']
${order_id_field}  xpath=//input[@ng-model='$ctrl.order.client_po']
${courier_select}    xpath=//div[@ng-model='$ctrl.order.ship_via_id']/div/input
${courier_select_list}     xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
${items_field_order}      xpath=//div[@class='modal-content']//input[@id='_value']

# address book

${company_field_address}    xpath=//input[@ng-model='$ctrl.address.company']
${full_name_field_address}  xpath=//input[@ng-model='$ctrl.address.addressee']
${address_1_field_address}      xpath=//input[@ng-model='$ctrl.address.address_1']
${city_field_address}        xpath=//input[@ng-model='$ctrl.address.city']
${state_field_address}       xpath=//input[@ng-model='$ctrl.address.state']
${postal_code_field_address}  xpath=//input[@ng-model='$ctrl.address.postal_code']
${country_select_address}    xpath=//div[@ng-model='$ctrl.address.country']/div/input

${long_symbols}            ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss