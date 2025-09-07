<PENDENTE>

Who is the celebrity

objetivo 1

va para o lambda console

seleciona a lambda que deve ser usada como ação do gatilho do bucket

aperte em Add Trigger

em source selecione S3

em bucket, seleciona o bucket que deve ser observado pelo evento

em event type, seleciona o evento PUT

em prefix, escreva a pasta que deve ser observada com Images/

em sufix, escreva o formato do arquivo que deve ser observado como .jpg

seleciona a checkbox de aviso do Recursive Invocation

aperte no botão Add

no console lambda

seleciona a lambda do evento

va na sessão configuration

seleciona enviroment variables

adiciona a variavel TABLE_NAME com o valor no nome da tabela do dynamodb que deve salvar os nomes

3:00:00

