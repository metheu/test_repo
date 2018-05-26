FROM node:carbon
WORKDIR ~/git/my_node/app/

# Install app dependencies ;  wildcard is used to ensure both package.json ANF package-lock.json are copied
COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]