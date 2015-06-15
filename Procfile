es: elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
web: bundle exec rails s puma -p 7777
worker: bundle exec sidekiq -c 10
redis: leader --unless-port-in-use 6379 redis-server ~/workspace/capture/resources/redis.conf
