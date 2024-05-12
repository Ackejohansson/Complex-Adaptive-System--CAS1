# A lawn mower control software

First start the grass simulator in one terminal, and then start the lawn mower
in anohter. The two programs will start communicating, where the lawn mower
sends a control action, and the grass simulator responds with sensor values.

The simulater is started with:

    docker run -ti --rm --net=host -e COLUMNS=$COLUMNS -e LINES=$LINES -e TERM=$TERM olbender/tme290-grass-simulator-amd64:v0.0.7 tme290-sim-grass --cid=111 --time-limit=0 --dt=0.1 --verbose


Then in a second terminal

## Native build

Build:

    mkdir b
    cd b
    cmake ..
    make

Run:

    ./tme290-lawnmower --cid=111 --verbose


## Docker 

Build:

    docker build -f tme290-lawnmower .

Run:

    docker run -ti --rm --net=host tme290-lawnmower tme290-lawnmower --cid=111 --verbose