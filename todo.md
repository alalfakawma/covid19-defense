#### Todo List:

- [] Complete stages
    - Vairengte
        - [] Stage 2
        - [] Stage 3
    - Lengpui 
        - [] Stage 1
        - [] Stage 2
        - [] Stage 3

- [x] Change virus spawn countdown
- [x] As soon as player starts the game for first time, request to pick a name which will be permanent in a file (if reset they can change name)
- [x] Copy config file to {filename}.JSON so default file is preserved in case of reset
    - [] Add reset game data button which will remove {filename}.JSON

- [] Add scores system
    - [] Monster Kill Score
    - [] Level Score = (Multiplier * Monster Kill Score) Multiplier -> Minutes spent in level Eg. 2:22s mins in level = 2(multiplier)

##### **Server:**
- [] Setup NodeJS and Express
- [] Add endpoints for get and set of score
    - [] /getscore (get)
        - Params:

    - [] /setscore (post)
        - Params: player_name, score
- [] Provision server in Heroku
