FROM jfmorneau/ubuntu:latest

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -qy \
    qt5-default \
    cmake \
    gdb

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp 
RUN cd /tmp && git clone https://github.com/cpp-redis/cpp_redis.git
RUN cd /tmp/cpp_redis && git submodule init && git submodule update
RUN cd /tmp/cpp_redis && cmake .
RUN echo "BUILD_SHARED_LIBS:BOOL=ON" >> /tmp/cpp_redis/MakeCache.txt
RUN echo "CMAKE_SKIP_BUILD_RPATH:BOOL=ON" >> /tmp/cpp_redis/MakeCache.txt
RUN echo "TACOPIE_INCLUDE_DIR:PATH=/usr/local/include" >> /tmp/cpp_redis/MakeCache.txt
RUN echo "CMAKE_CXX_FLAGS:STRING=" >> /tmp/cpp_redis/MakeCache.txt
RUN echo "CMAKE_INSTALL_PREFIX:STRING=" >> /tmp/cpp_redis/MakeCache.txt
RUN cd /tmp/cpp_redis && cmake .
RUN cd /tmp/cpp_redis && make
RUN cd /tmp/cpp_redis && make install
RUN cd /tmp/cpp_redis/tacopie && make && make install
