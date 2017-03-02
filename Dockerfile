FROM openjdk:8u111-jdk
MAINTAINER Shane Husson shane.a.husson@gmail.com

RUN apt-get update --fix-missing && apt-get install -y \
    ca-certificates \
    cmake \
    g++ \
    git \
    libc6-compat \
    wget

ENV SPARK_HOME=/usr/spark/spark-2.1.0-bin-hadoop2.7 \
    HAIL_HOME=/usr/hail \
    PATH=/opt/conda/bin:$PATH:/usr/spark/spark-2.1.0-bin-hadoop2.7/bin:/usr/hail/build/install/hail/bin/

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.1.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

RUN mkdir /usr/spark && \
    curl -sL --retry 3 \
    "http://apache.mirror.serversaustralia.com.au/spark/spark-2.1.0/spark-2.1.0-bin-hadoop2.7.tgz" \
    | gzip -d \
    | tar x -C /usr/spark && \
    chown -R root:root $SPARK_HOME

RUN git clone https://github.com/broadinstitute/hail.git ${HAIL_HOME} && \
    cd ${HAIL_HOME} && \
    ./gradlew shadowJar && \
    pip install py4j && \
    echo 'alias pyhail="PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.3-src.zip:$HAIL_HOME/python SPARK_CLASSPATH=$HAIL_HOME/build/libs/hail-all-spark.jar python"' >> ~/.bashrc

ENV PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.3-src.zip:$HAIL_HOME/python \
    SPARK_CLASSPATH=$HAIL_HOME/build/libs/hail-all-spark.jar

ENTRYPOINT ["python"]
