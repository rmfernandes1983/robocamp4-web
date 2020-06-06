***Settings***
Documentation   Login
...     Sendo um administrador de catálago
...     Quero me autenticar no sistema
...     Para que eu possa gerenciar o catálago de produtos
# ATDD Desenvolvimento guiado por testes de aceitação
# BDD Desenvolvimento orientado Comportamento

Resource    ../resources/actions.robot

Suite Setup     Open Session
Suite Teardown  Close Session
#Test Teardown   Close Session

Test Teardown       After Test

*** Test Cases ***
# Login com sucesso
#     [tags]      login
#     Dado que eu acesso a página de Login
#     Quando submeto minhas credenciais 'papito@ninjapixel.com' e 'pwd123'
#     Entao devo ser autenticado

#     [Teardown]      After Test With Clear Local Storage
Login com sucesso
    [tags]      login
    [Template]      Realizar Login com sucesso
    papito@ninjapixel.com   pwd123


Senha incorreta
    [Template]      Tentativa de login com mensagem de erro
    papito@ninjapixel.com   abc123      Usuário e/ou senha inválidos

Email que existe
    [Template]      Tentativa de login com mensagem de erro
    404@ninjapixel.com      abc123        Usuário e/ou senha inválidos
    
Email Obrigatório
    [Template]      Tentativa de login com mensagem informativa
    ${EMPTY}    abc123        Opps. Informe o seu email!

Senha Obrigatório
    [Template]      Tentativa de login com mensagem informativa
    papito@ninjapixel.com       ${EMPTY}          Opps. Informe a sua senha!

*** Keywords ***
Tentativa de login com mensagem de erro
    [Arguments]     ${email}    ${pass}     ${saida}

    Dado que eu acesso a página de Login
    Quando submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ver uma mensagem de erro         ${saida}

Tentativa de login com mensagem informativa
    [Arguments]     ${email}    ${pass}     ${saida}

    Dado que eu acesso a página de Login
    Quando eu submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ver uma mensagem informativa         ${saida}

Realizar Login com sucesso    
    [Arguments]     ${email}    ${pass}

    Dado que eu acesso a página de Login
    Quando submeto minhas credenciais "${email}" e "${pass}"
    Entao devo ser autenticado

    [Teardown]      After Test With Clear Local Storage