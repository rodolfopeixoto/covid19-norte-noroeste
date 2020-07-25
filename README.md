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


### Contribuidores

Amanda Gregório, Pedro Rodrigues e Rodolfo Peixoto
