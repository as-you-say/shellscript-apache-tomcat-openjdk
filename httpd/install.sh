# 포트허용
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --reload

# 아파치 설치
yum install -y httpd-devel

# 설치파일 덮어쓰기

cp ./file/httpd.conf /etc/httpd/conf

# 아파치 실행
service httpd start