FROM mcr.microsoft.com/playwright/python:v1.58.2-noble

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN apt-get update && apt-get install -y cron && rm -rf /var/lib/apt/lists/*
RUN echo '*/5 * * * * cd /app && python app.py >> /proc/1/fd/1 2>&1' > /etc/cron.d/scrapquotes
RUN chmod 0644 /etc/cron.d/scrapquotes
RUN crontab /etc/cron.d/scrapquotes

CMD ["cron", "-f"]