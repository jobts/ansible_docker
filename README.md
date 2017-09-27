# ansible_docker
Ansible test deploy django application. Db backend postgresql.

Деплой тестового контейнера с приложением django с помощью ansible.

Начальная конфигурация
-----
1. Версия ansible в моем случае ansible 2.4.0.0 
2. Хост машина с предустановленным Debian 8 jessie, настроен ssh доступ, sudo, python 2, 
у пользователя под которым производится деплой есть sudo права.
-----

3. Пеменные согласно задаче, зашифрованы ansible vault в файле vars.yml с помошью
ПАРОЛЯ secret
При желании можно произвести дешифровку этого файла командой 
ansible-vault decrypt vars_decrytp.yml --ask-vault-pass

4. Хосты на которые производится деплой указаны в файле hosts
в данном примере  
testhost           ansible_ssh_host=192.168.1.10
меняем на свое название hostname / address 
Группа  на которую происходит деплой в данном случае 
djangodeploy 
Добавляем в нее свой хост по имени.

5. Производим деплой приложения с помощью команды

$ ansible-playbook -D django.yml --ask-vault-pass  

Вводим пароль от vault хранилища переменных.

Как вариант можно создать файл с паролем и указывать его через параметр --vault-password-file

$ ansible-playbook -D django.yml  --vault-password-file vaultpass

6. После успешного деплоя, на хосте, на который производится деплой можно посмотреть работу двух новых контейнеров командой
# docker ps -a
Контейнер с приложением django работает на порту 8000

Также в браузере можно открыть url, в данном примере
http://192.1680.100:8000 

7. Данные второго контейнера с postgresql хранятся в volume postgresvol
# docker volume ls
DRIVER              VOLUME NAME
local               postgresvol

или физически в директории  /var/lib/docker/volumes/postgresvol/ 





