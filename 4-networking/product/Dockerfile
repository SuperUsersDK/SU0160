FROM python:3.11-slim

# Set work directory
WORKDIR /usr/src/app

# Install pip and other tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && pip install --upgrade pip

# Copy requirement file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

CMD ["python", "api.py"]
