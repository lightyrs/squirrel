es: elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
web: bundle exec rails s puma
worker: bundle exec sidekiq -C ./config/sidekiq.yml
redis: leader --unless-port-in-use 6379 redis-server ~/workspace/capture/resources/redis.conf
