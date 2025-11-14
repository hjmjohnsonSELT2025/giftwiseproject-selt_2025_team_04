[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/dOTUOfXR)
# SELT Project 2025

## To run the rails app locally
In order to use the OAuth github support you must create your own github OAuth key.

1. Go to github, settings -> developer settings
2. click OAuth Apps and click new app
3. pick a name and then a client id will be automatically generated.
4. For app and callback URLs, enter "http://localhost"
5. Next click generate a new client secret and save it
6. next you can add the credentials to rails by typing `rails credentials:edit`
> If this step fails try `EDITOR=nano rails credentials:edit`
> Or delete the existing `credentials.yml.enc` file
6. Next type
```
github:
  client_id: <id>
  client_secret: <secret>
```
7. save and close. Then the app should continue working.

## To seed the test database
Rails is in the development environment by default. If you want to add seed values to the test database for your rspec tests, run `RAILS_ENV=test rails db:seed`.
