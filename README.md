# Codenames

An API to get randomly generated codenames! It also allows you to mimic degradation (latencies, errors, etc) to be leveraged for observability.  


## Run It!

    $ go build main.go; ./main --adjectives adjectives.txt --animals animals.txt --port 8081
    
## Call It!

    $ ➜  curl -sS localhost:8081
    Alive Badger
    
## But does the failure mode work?!

### Failure Mode: Latency

    ➜  /Users/nemo/go/bin/hey -c 100 -n 100 "http://localhost:8081/?latency=2500"

    Summary:
    Total:        2.5168 secs
    Slowest:      2.5160 secs
    Fastest:      2.5100 secs
    Average:      2.5133 secs
    Requests/sec: 39.7329
    
    Total data:   1563 bytes
    Size/request: 15 bytes

    Response time histogram:
    2.510 [1]     |■■■
    2.511 [6]     |■■■■■■■■■■■■■■■■
    2.511 [4]     |■■■■■■■■■■■
    2.512 [13]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.512 [8]     |■■■■■■■■■■■■■■■■■■■■■
    2.513 [9]     |■■■■■■■■■■■■■■■■■■■■■■■■
    2.514 [14]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.514 [9]     |■■■■■■■■■■■■■■■■■■■■■■■■
    2.515 [15]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.515 [11]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
    2.516 [10]    |■■■■■■■■■■■■■■■■■■■■■■■■■■■


    Latency distribution:
    10% in 2.5111 secs
    25% in 2.5119 secs
    50% in 2.5135 secs
    75% in 2.5147 secs
    90% in 2.5155 secs
    95% in 2.5158 secs
    99% in 2.5160 secs

    Details (average, fastest, slowest):
    DNS+dialup:   0.0065 secs, 2.5100 secs, 2.5160 secs
    DNS-lookup:   0.0039 secs, 0.0026 secs, 0.0051 secs
    req write:    0.0002 secs, 0.0000 secs, 0.0021 secs
    resp wait:    2.5066 secs, 2.5004 secs, 2.5102 secs
    resp read:    0.0001 secs, 0.0000 secs, 0.0003 secs

    Status code distribution:
    [200] 100 responses

### Failure Mode: Error (StatusCode)

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