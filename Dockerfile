FROM python:3.7.3

#COPY ../viberr /srv/www/viberr
# Подготовка рабочего пространства
RUN mkdir -p /srv/www/viberr
WORKDIR /srv/www/viberr

RUN mkdir -p /var/log/gunicorn

# RUN pip install -r requirements.txt
# Установка зависимостей
RUN pip install django==2.2.2 && \
	pip install pytz==2019.1 && \
	pip install sqlparse==0.3.0 && \
	pip install gevent && \
	pip install gunicorn && \
	pip install mysqlclient && \
	pip install django-redis && \
	pip install djangorestframework;

# Перенос приложения
COPY . /srv/www/viberr

# Юзер под которым будет вестись работа
RUN chown -R www-data:www-data /srv/www/viberr
USER www-data

#Сбор статики
RUN python manage.py collectstatic --noinput

# Запуск сервера
CMD gunicorn -c gunicorn.py Project1.wsgi

# Открыть порт 8000
EXPOSE 8000
