# Use an official Python runtime as a parent image
FROM continuumio/miniconda3:latest

# Set the working directory to /app
WORKDIR /STRetch
RUN apt-get update && apt-get install -y \
  git \
  unzip\ 
  openjdk-7-jre\
  build-essential\
  r-base-dev


# Copy the current directory contents into the container at /app
ADD . /STRetch
# Define environment variable
ENV PATH="/STRetch/tools/bin:${PATH}"

# Install any needed packages specified in requirements.txt
RUN /STRetch/install.sh
RUN /STRetch/tools/miniconda/envs/STR/bin/Rscript --verbose /STRetch/.testing/install-packages.R
RUN mkdir /STRetch/test
RUN wget -O /STRetch/test/testdata.zip https://ndownloader.figshare.com/articles/4762489?private_link=cc7347f4637d9a7fe22d
WORKDIR /STRetch/test/
RUN unzip testdata.zip 
RUN rm testdata.zip
#RUN cp /STRetch/reference-data/SCA8_region.bed /STRetch/test/

CMD ["/STRetch/entrypoint.bash"]






