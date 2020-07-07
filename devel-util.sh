function install(){
   local CATALINA_HOME=$1
   local JAVA_HOME=$2
   local JRE_HOME=$3
   local JAVA_OPTS='-server -Xms512m -Xmx512m'
   local PATH=$PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

   ./openjdk/install.sh
   ./tomcat/install.sh
   ./httpd/install.sh

   echo "function: value= ${value}"
}

