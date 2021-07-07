import redis 
import os
import time

from dotenv import load_dotenv

load_dotenv()
redis_passwd = os.getenv('redis')
r = redis.StrictRedis(host = 'db', port = 6379, db = 0, password = redis_passwd)

r.set('key1','value1')
r.set('key2','value2')
print(r.get('key2'))

while True:
    print(r.get('key2'))
    time.sleep(1)

