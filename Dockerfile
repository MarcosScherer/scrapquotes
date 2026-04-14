FROM mcr.microsoft.com/playwright/python:v1.58.2-noble

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN echo '*/5 * * * * cd /app && python app.py >> /proc/1/fd/1 2>&1' >> /etc/crontabs/root

CMD ["/usr/sbin/crond", "-f"]