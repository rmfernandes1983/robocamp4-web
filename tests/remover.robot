
*** Settings ***
Documentation   Exclusão de Produtos
...         Sendo um administrador de catálago que possui produtos indesejados
...         Quero deletar estes produtos
...         Para que eu possa msnter meu cat´lago atualizado

Resource    ../resources/actions.robot


Suite Setup         Login Session
Suite Teardown      Close Session

#Test Setup      Login Session
#Test Teardown   Close Session

Test Teardown       After Test

*** Test Cases ***
Apagar produto
    Dado que eu tenho o produto "mario.json" no catálago
    Quando solicito a Exclusão
    E confirmo a solicitação
    Então não devo ver este item no catálago

Desistir da remoção
    Dado que eu tenho o produto "zelda.json" no catálago
    Quando solicito a Exclusão
    Mas cancelo a solicitação
    Então devo ver este item no catálago