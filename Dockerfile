FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# by default this doesn't do anything, but ELasticBeanstalk looks at this
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
# no need for a default command, because the default command for nginx is already to start nginx server