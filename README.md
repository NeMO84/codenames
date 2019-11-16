# Codenames

An API to get randomly generated codenames! It also allows you to mimic degradation (latencies, errors, etc) to be leveraged for observability.  


## Run It!

    $ go build main.go; ./main --adjectives adjectives.txt --animals animals.txt --port 8081
    
## Call It!

    $ ➜  curl -sS localhost:8081
    Alive Badger
    
## Failure Modes

How does it work?!!

### Latency

    ➜  /Users/nemo/go/bin/hey -c 100 -n 100 "http://localhost:8081/?latency=random"

    Summary:
    Total:        2.8826 secs
    Slowest:      2.8816 secs
    Fastest:      0.0114 secs
    Average:      1.3501 secs
    Requests/sec: 34.6911
    
    Total data:   1545 bytes
    Size/request: 15 bytes

    Response time histogram:
    0.011 [1]     |■■■
    0.298 [12]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    0.585 [13]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    0.872 [10]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    1.160 [10]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    1.447 [9]     |■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    1.734 [10]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.021 [8]     |■■■■■■■■■■■■■■■■■■■■■■■■■
    2.308 [8]     |■■■■■■■■■■■■■■■■■■■■■■■■■
    2.595 [9]     |■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.882 [10]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


    Latency distribution:
    10% in 0.2483 secs
    25% in 0.5838 secs
    50% in 1.3530 secs
    75% in 2.1335 secs
    90% in 2.6145 secs
    95% in 2.8230 secs
    99% in 2.8816 secs

    Details (average, fastest, slowest):
    DNS+dialup:   0.0063 secs, 0.0114 secs, 2.8816 secs
    DNS-lookup:   0.0039 secs, 0.0028 secs, 0.0046 secs
    req write:    0.0001 secs, 0.0000 secs, 0.0009 secs
    resp wait:    1.3436 secs, 0.0048 secs, 2.8743 secs
    resp read:    0.0001 secs, 0.0000 secs, 0.0001 secs

    Status code distribution:
    [200] 100 responses

### Error (StatusCode)

    ➜  /Users/nemo/go/bin/hey -c 100 -n 100 "http://localhost:8081/?error=random"

    Summary:
    Total:        0.0270 secs
    Slowest:      0.0255 secs
    Fastest:      0.0071 secs
    Average:      0.0174 secs
    Requests/sec: 3706.1698
    
    Total data:   1544 bytes
    Size/request: 15 bytes

    Response time histogram:
    0.007 [1]     |■
    0.009 [9]     |■■■■■■■■■■
    0.011 [12]    |■■■■■■■■■■■■■
    0.013 [10]    |■■■■■■■■■■■
    0.014 [21]    |■■■■■■■■■■■■■■■■■■■■■■■
    0.016 [0]     |
    0.018 [0]     |
    0.020 [0]     |
    0.022 [0]     |
    0.024 [10]    |■■■■■■■■■■■
    0.025 [37]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■


    Latency distribution:
    10% in 0.0095 secs
    25% in 0.0122 secs
    50% in 0.0137 secs
    75% in 0.0244 secs
    90% in 0.0249 secs
    95% in 0.0251 secs
    99% in 0.0255 secs

    Details (average, fastest, slowest):
    DNS+dialup:   0.0047 secs, 0.0071 secs, 0.0255 secs
    DNS-lookup:   0.0036 secs, 0.0020 secs, 0.0044 secs
    req write:    0.0002 secs, 0.0000 secs, 0.0010 secs
    resp wait:    0.0107 secs, 0.0017 secs, 0.0185 secs
    resp read:    0.0003 secs, 0.0000 secs, 0.0029 secs

    Status code distribution:
    [401] 20 responses
    [402] 19 responses
    [403] 12 responses
    [404] 20 responses
    [409] 19 responses
    [500] 10 responses

## Docker

See Dockerfile for more details.

    # Build
    ➜  docker build -t patelify/codenames .

    # Run 
    ➜  docker run -it -p 3002:8081 --rm patelify/codenames

    # get a random codename
    export DOCKERMACHINE=$(docker-machine ip)
    ➜  curl "http://$DOCKERMACHINE:3001/"
    Hungry Alligator

    # mimic latency
    ➜  curl "http://$DOCKERMACHINE:3001/?latency=250"
    Hungry Alligator

    # mimic error code
    curl "http://$DOCKERMACHINE:3001/?error=random" -I
    HTTP/1.1 401 Unauthorized
    Date: Sat, 16 Nov 2019 05:11:43 GMT
    Content-Length: 11
    Content-Type: text/plain; charset=utf-8
