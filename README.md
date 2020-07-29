# ATLAS COVID-19
Um sistema para mostrar os dados do covid-19 na região norte e norte fluminense do Estado do Rio de Janeiro

Site Oficial: [AtlasNF-Covid19](http://atlasnf-covid19.com.br)

## Requisitos

 Ruby 2.6.5
 Rails 6.0.2.2

## Theme

Utilizado Bootstrap 4 com [adminlte3](http://adminlte.io)


## Executar

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

 ## Acesso

  Painel Administrativo

 http://localhost:3000/covid_informations

### Criação de usuário

```bash
 bundle exec rails console
```


```bash
 User.create(email: 'user@email.com', password: 'covid1234')
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


### Contribuidores

Amanda Gregório, Pedro Rodrigues e Rodolfo Peixoto
