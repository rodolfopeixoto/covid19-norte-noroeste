# ATLAS COVID-19
Um sistema para mostrar os dados do covid-19 na região norte e norte fluminense do Estado do Rio de Janeiro

Site Oficial: [AtlasNF-Covid19](http://atlasnf-covid19.com.br)

## Requisitos

 Ruby 2.6.5
 Rails 6.0.2.2

## Theme

Utilizado Bootstrap 4 com [adminlte3](http://adminlte.io)


## Executar (com Docker)

  ```bash
    docker-compose build app
  ```

  ```bash
    docker-compose run app yarn install
  ```

  ```bash
    docker-compose run app bundle exec rails db:setup
  ```

  ```bash
    docker-compose run app bundle exec rails data_marco:create
  ```

  ```bash
   docker-compose up
  ```

### Criação de usuário

  ```bash
    docker-compose run app bundle exec rails db:seed
  ```

## Executar (sem Docker)

  ```bash
    bundle exec rails db:setup
  ```

  ```bash
    bundle exec rails data_marco:create
  ```

  ```bash
   yarn install
  ```  

  ```bash
   bundle exec rails server
  ```

### Criação de usuário

  ```bash
    bundle exec rails db:seed
  ```

## Acesso

  Painel Administrativo

 http://localhost:3000/covid_informations

#### Dados de login
```
Email: user@email.com
Senha: covid1234
```

### Help

Para gerar uma release você precisa adicionar no se `~/.zshrc` ou no `~/.bashrc` o código abaixo:
```
 new-tag() {
   local folder=$(basename `pwd`)
   echo "$folder-`date '+%Y%m%d%H%M%S'`"
 }
```

depois usar o comando:

```
new-tag
```
Receberá algo assim: `covid-data-20200725154059` esse será o código do release
