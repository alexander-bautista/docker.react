# multi-step dockerfile
# first stage: build (temporaly container). Notice the use of "as builder" to demark the block
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# second stage run. The first stage finish here. No need to use "as blablabla".
FROM nginx
# expose the port 80 to the ouside
EXPOSE 80
# from docker hub instructions, copy files from builder stage to run stage
COPY --from=builder /app/build /usr/share/nginx/html