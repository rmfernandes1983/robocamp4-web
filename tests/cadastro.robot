*** Settings ***
Documentation   Cadastro de Produtos
...         Sendo um administrador de catálago
...         Quero cadastrar produtos
...         Para que eu possa disponibiliza-los na loj virtual

Resource    ../resources/actions.robot


Suite Setup         Login Session
Suite Teardown      Close Session

Test Teardown       After Test

#Test Setup      Login Session
#Test Teardown   Close Session

*** Test Cases ***
Disponibilizar produto
    Dado que eu tenho um novo produto   dk.json
    Quando eu faço o cadastro desse produto     
    Então Devo ver este item no catálago

Produto Duplicado
    Dado que eu tenho um novo produto   master.json
    Mas este produto já foi cadastrado
    Quando eu faço o cadastro desse produto
    Entao devo ver uma mensagem de erro       Oops - Este produto já foi cadastrado!
