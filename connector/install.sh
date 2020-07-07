# wget 패키지 설치
yum install -y wget

# 컴파일 패키지 설치
yum install -y wget gcc gcc-c++ make

# 톰캣 아파치 커넥터 다운로드
wget http://us.mirrors.quenda.co/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
tar -zxvf tomcat-connectors-1.2.48-src.tar.gz

# 커넥터 설치
cd tomcat-connectors-1.2.48-src/native
./configure --with-apxs=/usr/bin/apxs
make
make install

# 모듈 복사
cp ./tomcat-connectors-1.2.48-src/native/apache-2.0/mod_jk.so /etc/httpd/modules/

# 셀리눅스를 위한 패키지 -- 진행중
yum -y install policycoreutils-python














