[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/dOTUOfXR)
# SELT Project 2025

## Instructions
In order to use the OAuth github support you must create your own github OAuth key.

1. Go to github, settings -> developer settings
2. click OAuth Apps and click new app
3. pick a name and then a client id will be automatically generated.
4. Next click generate a new client secret and save it
5. next you can add the credentials to rails by typing `rails credentials:edit`
> If this step fails try `EDITOR=nano rails credentials:edit`
6. Next type
```
github:
  client_id: <id>
  client_secret: <secret>
```
7. save and close. Then the app should continue workings
