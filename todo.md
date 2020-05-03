#### Todo List:


[] Change virus spawn countdown
[] Copy config file to current{filename}.JSON so default file is preserved in case of reset
    [] Add reset game data button which will remove current{filename}.JSON

[] Add scores system
    [] Monster Kill Score
    [] Level Score = (Multiplier * Monster Kill Score) Multiplier -> Minutes spent in level Eg. 2:22s mins in level = 2(multiplier)

##### **Server:**
[] Setup NodeJS and Express
[] Add endpoints for get and set of score
    [] /getscore (get)
    [] /setscore (post)
[] Provision server in Heroku
