## Stage 1: Build the frontend
#FROM node:16 AS build
#
## Устанавливаем рабочую директорию
#WORKDIR /app
#
## Копируем файлы проекта
#COPY ./chat-front/package*.json ./
#RUN npm install
#
#COPY ./chat-front ./
#
## Сборка проекта
#RUN npm run build
#
## Stage 2: Serve frontend using NGINX
#FROM nginx:stable-alpine
#
## Копируем собранные статические файлы из предыдущего этапа
#COPY --from=build /app/dist /usr/share/nginx/html
#
## Копируем конфигурационный файл NGINX (если требуется)
## COPY ./nginx.conf /etc/nginx/conf.d/default.conf
#
## Порт, на котором будет работать NGINX
#EXPOSE 80
#
## Запуск NGINX
#CMD ["nginx", "-g", "daemon off;"]



# Stage 1: Build the frontend
FROM node:16 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы проекта
COPY ./chat-front/package*.json ./
RUN npm install

COPY ./chat-front ./

# Сборка проекта
RUN npm run build

# Stage 2: Serve frontend using NGINX
FROM nginx:stable-alpine

# Копируем собранные статические файлы из предыдущего этапа
COPY --from=build /app/dist /usr/share/nginx/html

# Копируем кастомный конфиг NGINX
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# Порт, на котором будет работать NGINX
EXPOSE 8000

# Запуск NGINX
CMD ["nginx", "-g", "daemon off;"]
