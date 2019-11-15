# Codenames

An API to get randomly generated codenames! It also allows you to mimic degradation (latencies, errors, etc) to be leveraged for observability.  


## Run It!

    $ go build main.go; ./main --adjectives adjectives.txt --animals animals.txt --port 8081
    
## Call It!

    $ ➜  curl -sS localhost:8081
    Alive Badger
    
