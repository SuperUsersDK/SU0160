import redis 
import os

from dotenv import load_dotenv

load_dotenv()
redis_passwd = os.getenv('redis')
r = redis.StrictRedis(host = 'db', port = 6379, db = 0, password = redis_passwd)

r.set('key1','value1')
print(r.get('key1'))
