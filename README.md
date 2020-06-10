# Emissary Chat API

## An IM-style chat app

This repo is the backend API companion to my React JS frontend, found [here](https://github.com/strangrjrjr/emissary). The main branch is configured for local development, the heroku branch is a live demo [hosted on Heroku](https://emissary-chat.herokuapp.com)

### Features

- User creation and authentication via Bcrypt and JWT
- ActionCable connections to allow realtime message passing
- Unique ActionCable broadcasts for each conversation
- Full CRUD of conversations
- TLS for websockets and http requests
- Restricted CORS routing

### Technologies Used

- Ruby on Rails 6.0
- Postgresql
- Bcrypt
- JWT
- ActionCable
- Object serialization

### TODO (stretch goals)

- [ ] Database encryption
- [ ] Encrypted ActionCable broadcasts
- [ ] Database logging/monitoring
- [ ] Email verification

_This project is heavily based on an earlier group project called [FlatChat](https://github.com/strangrjrjr/flatchat_backend). Many thanks to John Souza and Jazz Bozner for their contributions!_
