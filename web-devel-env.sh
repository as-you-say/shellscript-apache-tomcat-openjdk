# wget 패키지 설치
yum install -y wget

# OPEN-JDK 1.8.0 설치
yum install -y java-1.8.0-openjdk-devel

# 아파치 설치
yum install -y httpd-devel

# 톰캣 설치
wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.22/bin/apache-tomcat-8.0.22.tar.gz
tar -zxvf apache-tomcat-8.0.22.tar.gz
mkdir -p /usr/local/tomcat
mv ./apache-tomcat-8.0.22 /usr/local/tomcat

# 환경변수 추가
echo 'JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk' >> /etc/profile
echo 'PATH=$PATH:$JAVA_HOME/bin' >> /etc/profile
source /etc/profile

# 톰캣 서비스 등록
# chkconfig관련 옵션
# 345 는 런레벨 3, 4, 5의 뜻임. 런레벨은 구글에 '리눅스 런레벨' 검색.
# 85 는 데몬실행 우선순위
# 15 는 데몬 종료 우선순위임.
cd /etc/init.d
touch tomcat
chmod 755 tomcat
echo '#!/bin/sh' >> tomcat
echo '# chkconfig: 345 85 15' >> tomcat 
echo '# description: apache tomcat 8.x' >> tomcat
echo '# processname: tomcat' >> tomcat
echo 'export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk' >> tomcat
echo 'export JRE_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' >> tomcat
echo 'export CATALINA_HOME=/usr/local/tomcat/apache-tomcat-8.0.22' >> tomcat
echo 'export JAVA_OPTS="-server -Xms512m -Xmx512m"' >> tomcat
echo 'export PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin' >> tomcat
echo 'case "$1" in' >> tomcat
echo '  start)' >> tomcat
echo '  echo -n "Starting tomcat: "' >> tomcat
echo '  $CATALINA_HOME/bin/catalina.sh start' >> tomcat
echo '  echo' >> tomcat
echo '  ;;' >> tomcat
echo '  stop)' >> tomcat
echo '  echo -n "Shutting down tomcat: "' >> tomcat
echo '  $CATALINA_HOME/bin/catalina.sh stop' >> tomcat
echo '  echo' >> tomcat
echo '  ;;' >> tomcat
echo '  restart)' >> tomcat
echo '  $0 stop' >> tomcat
echo '  sleep 2' >> tomcat
echo '  $0 start' >> tomcat
echo '  ;;' >> tomcat
echo '  *)' >> tomcat
echo '  echo "Usage: $0 {start|stop|restart}"' >> tomcat
echo '  exit 1' >> tomcat
echo 'esac' >> tomcat
echo 'exit 0' >> tomcat
chkconfig --add tomcat

# 포트 열기 (80, 8080)
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

# 아파치 실행
service httpd start

# 톰캣 실행
service tomcat start

# 톰캣 아파치 커넥터 다운로드
wget http://us.mirrors.quenda.co/apache/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz
tar -zxvf tomcat-connectors-1.2.48-src.tar.gz

# 설치
yum install -y gcc gcc-c++ make
cd tomcat-connectors-1.2.48-src/native
./configure --with-apxs=/usr/bin/apxs
make
make install
cp ./tomcat-connectors-1.2.48-src/native/apache-2.0/mod_jk.so /etc/httpd/modules/

# 셀리눅스를 위한 패키지
yum -y install policycoreutils-python

