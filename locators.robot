
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
${Add user}                     xpath=//a[contains(.,"Add User")]
${Reset pass}                   12345678

${Log in}                       xpath=//a[@class="btn btn-primary"]

${login_admin}                  cutoreno@p33.org
${pass_admin}                   qw1as2zx3po


${MAIL_HOST}                    smtp.gmail.com
${MAIL_USER}                    auto.testfloship@gmail.com

${client mail}                  test@floship.com
${cli_role}                      client@floship.com
${staff_user}                  staff@floship.com
${3pl_client}                  3pl@floship.com
${MAIL_PASSWORD}                fJ4qEn5Y





#Data for geristration
${comp name}                     mycompany_
${order_id}                      ID_
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
${three_pl}                      xpath=//span[@aria-labelledby='select2-id_three_pls-0-three_pl-container']

#add_product_page:
${sku name}                 XM01_
${desc name}                Desc_
${sku_field}                xpath=//input[@ng-model='$ctrl.product.sku']
${description_field}        xpath=//input[@ng-model='$ctrl.product.description']
${cust_description_field}   xpath=//input[@ng-model='$ctrl.product.customs_description']
${harmonized_code_field}   xpath=//input[@ng-model='$ctrl.product.harmonized_code']
${product_upc}             xpath=//input[@ng-model='$ctrl.product.upc']
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



# inner

${inner_unit_qty}          xpath=//*[@ng-model="$ctrl.product.inventory_items.inner_carton.product_quantity"]
${inner_width}             xpath=//*[@ng-model="$ctrl.product.inventory_items.inner_carton.gross_width"]
${inner_height}             xpath=//*[@ng-model="$ctrl.product.inventory_items.inner_carton.gross_height"]
${inner_length}             xpath=//*[@ng-model="$ctrl.product.inventory_items.inner_carton.gross_length"]
${inner_weight}             xpath=//*[@ng-model="$ctrl.product.inventory_items.inner_carton.gross_weight"]

# master

${master_unit_qty}          xpath=//*[@ng-model="$ctrl.product.inventory_items.master_carton.product_quantity"]
${master_width}             xpath=//*[@ng-model="$ctrl.product.inventory_items.master_carton.gross_width"]
${master_height}             xpath=//*[@ng-model="$ctrl.product.inventory_items.master_carton.gross_height"]
${master_length}             xpath=//*[@ng-model="$ctrl.product.inventory_items.master_carton.gross_length"]
${master_weight}             xpath=//*[@ng-model="$ctrl.product.inventory_items.master_carton.gross_weight"]


#asn_details_page:

${add}                  css=a.btn.btn-primary
${calendar_button}      xpath=//i[@class='icmn-calendar']
${today_button}         xpath=//li[@ng-if='showButtonBar']/span/button[1]
${upload_file}          xpath=//div[@ngf-select='upload($files)']
${referense_asn}        xpath=//input[@ng-model='$ctrl.asn.client_reference_number']
${tracking_asn}         xpath=//input[@ng-model='$ctrl.asn.tracking_number']
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
${items_list}           xpath=//div[contains(@class,"angucomplete-row")]


# shipping option
${shipping_name}        SOM01_
${som_name_field}       xpath=//input[@ng-model='$ctrl.som.shipping_option']

# group items

${sku_field_group}           xpath=//input[@ng-model='$ctrl.groupItem.sku']
${description_field_group}   xpath=//input[@ng-model='$ctrl.groupItem.description']
${items_field_gr}         xpath=//div[@class='modal-content']//input[@id='_value']
${items_list}          xpath=//div[@ng-click='selectResult(result)']/div[@ng-bind-html='result.description']

#Order

#add_order_page:
${order_company}          xpath=//input[@ng-model='$ctrl.order.shipping_address.company']
${full_name_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.addressee']
${address_1_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.address_1']
${city_field_order}       xpath=//input[@ng-model='$ctrl.order.shipping_address.city']
${state_field_order}      xpath=//input[@ng-model='$ctrl.order.shipping_address.state']
${postal_code_field_order}  xpath=//input[@ng-model='$ctrl.order.shipping_address.postal_code']
#${country_select_order}       xpath=//div[@ng-model='$ctrl.order.shipping_address.country']/div/input
#${country_select_list_order}  xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
${phone_field_order}      xpath=//input[@ng-model='$ctrl.order.shipping_address.phone']
${value_order}                       xpath=//input[@ng-model='$ctrl.order.insurance_value.amount']
${order_id_field}  xpath=//input[@ng-model='$ctrl.order.client_po']
${courier_select}    xpath=//div[@ng-model='$ctrl.order.ship_via_id']/div/input
${courier_select_list}     xpath=//div[@ng-show='$select.open']//div[@class='ng-binding ng-scope']
${items_field_order}      xpath=(//input[@id='_value'])[2]

# address book

${company_field_address}    xpath=//input[@ng-model='$ctrl.address.company']
${full_name_field_address}  xpath=//input[@ng-model='$ctrl.address.addressee']
${address_1_field_address}      xpath=//input[@ng-model='$ctrl.address.address_1']
${address_2_field_address}      xpath=//input[@ng-model='$ctrl.address.address_2']
${city_field_address}        xpath=//input[@ng-model='$ctrl.address.city']
${state_field_address}       xpath=//input[@ng-model='$ctrl.address.state']
${postal_code_field_address}  xpath=//input[@ng-model='$ctrl.address.postal_code']
${country_select_address}    xpath=//div[@ng-model='$ctrl.address.country']/div/input
${phone_address}             xpath=//input[@ng-model='$ctrl.address.phone']

${MAIL_USER}                    test@floship.com

${fsn}             FSN
${cpo}             CPO
${group}           GR_
${track_n}         TC
${sku}             SKU
${sku_desc}        Desc
${tracking}        TNASN
${refer}           Refer
${create_user}     For_Test
${client}          Client for autotests_
${client_role}     Client for role_
${fo}              FS
${3pl_rand}             3PL_
${couirier_rand}        _

# Long symbols

${long_symbols}            ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
${long_symbols_61}         sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss

#product

${long_symbols_255}         Test_thisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbols_123456789
${long_symbols_60}          thisTestSKUForCheckLongSymbolsthisTestSKUForCheckLongSymbols
${long_symbols_21}          123456789123456789123