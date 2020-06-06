
***Settings***
Documentation   Actions é o arquivo que terá keywords que implementam os steps

#Library     libs/db.py
Library     SeleniumLibrary
Library     OperatingSystem

Resource    pages/BasePage.robot
Resource    pages/Sidebar.robot
Resource    pages/LoginPage.robot
Resource    pages/ProductPage.robot


***Keywords***
### Helprs
Get Product Json
    [Arguments]     ${file_name}

    ${file}=    Get File       resources/fixtures/${file_name}
    ${json}=    Evaluate       json.loads($file)       json

    [Return]    ${json}



### Login
Dado que eu acesso a página de Login
    Go To       ${base_url}/login

Quando submeto minhas credenciais "${email}" e "${pass}"
    Login With      ${email}       ${pass}

Entao devo ser autenticado
    Wait Until Element Is Visible       ${LOGGED_USER}
    Wait Until Element Contains         ${LOGGED_USER}        Papito   
    #Element Text Should Be              ${LOGGED_USER}        Papito   
    #Wait Until Page Contains            Papito

Entao devo ver uma mensagem de erro
    [Arguments]         ${expect_message}

    #Wait Until Page Contains        ${excect_message}
    Wait Until Element Contains         ${ALERT_DANGER}         ${expect_message}

Entao devo ver uma mensagem informativa
    [Arguments]         ${expect_message}

    Wait Until Element Contains         ${ALERT_INFO}           ${expect_message}

### Products
Dado que eu tenho um novo produto
    [Arguments]     ${file_name}

    ${product_json}=    Get Product Json        ${file_name}

 ###   Remove Product By Name          ${product_json['name']}
    Set Test Variable               ${product_json}

Mas este produto já foi cadastrado
    Go To Product Form
    Create New Product              ${product_json}

Quando eu faço o cadastro desse produto
    Go To Product Form
    Create New Product              ${product_json}

Quando eu tento cadastrar o produto
    Create New Product              ${product_json}
 
Então Devo ver este item no catálago
    Table Should Contain        class:table            ${product_json['name']}

### Remover Produto
Dado que eu tenho o produto "${file_name}" no catálago
    ${product_json}=    Get Product Json        ${file_name}

 ###   Remove Product By Name          ${product_json['name']}
    Go To Product Form
    Create New Product              ${product_json}
    Set Test Variable               ${product_json}

Quando solicito a Exclusão
    Click Element       xpath://tr[td//text()[contains(., '${product_json['name']}')]]//button
    Wait Until Element Is Visible       class:swal2-modal

E confirmo a solicitação
    Click Element       class:swal2-confirm

Mas cancelo a solicitação
    Click Element       class:swal2-cancel

Então não devo ver este item no catálago
    Wait Until Element Does Not Contain        class:table            ${product_json['name']}