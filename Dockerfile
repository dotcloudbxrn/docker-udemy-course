FROM node:alpine AS builder

# AS phase

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

# CMD IS THE DEFAULT COMMAND RAN WHEN THE CONTAINER RUNS, IT WILL NOT RUN BUILD 
# CMD ["npm", "run", "build"]

RUN npm run build

FROM nginx
# required for Beanstalk -> uses as a port for mapping incoming trafic
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html

#default command from nginx will start it up for us