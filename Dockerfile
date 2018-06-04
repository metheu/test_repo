FROM node:9-alpine

ENV MY_APP 0.0.2

WORKDIR ~/git/my_node/app/

# Install app dependencies ;  wildcard is used to ensure both package.json ANF package-lock.json are copied
COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]