## 配置中心（Graalvm）
### Graalvm
    https://github.com/graalvm/graalvm-ce-builds/releases
    # 静态编译需要单独安装musl、zlib
    https://www.graalvm.org/jdk21/reference-manual/native-image/guides/build-static-executables/
	$ apt-get update
	$ apt-get install -y build-essential zlib1g-dev maven
	分割文件
	$ split -b 50M graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz -d graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz_
	合并文件
	$ ls -ltrh
	$ cat graalvm-community-jdk-21.0.2_linux-x64_bin.tar.gz_* > graalvm-community-jdk-21.0.2.tar.gz
	解压文件
	$ tar -zxvf graalvm-community-jdk-21.0.2.tar.gz -C /usr/local/ --transform="s/graalvm-community-openjdk-21.0.2+13.1/graalvm/g"
	$ sed -i '$a export PATH=/usr/local/graalvm/bin:$PATH' ~/.bashrc
	$ source ~/.bashrc
	$ java --version
	$ native-image --version
	$ mvn --version

### Git
	$ apt-update
	$ apt-get install -y git
	$ git --version
	$ git config --global user.name "renlm"
	$ git config --global user.email "renlm@21cn.com"
	$ ssh-keygen -m PEM -t rsa -b 2048 -C "renlm@21cn.com" -N ""
	$ cat ~/.ssh/id_rsa.pub

### 输出编译配置
	$ mkdir -p /root/native-image
	$ cd /root/native-image
	$ git clone -b master --single-branch git@gitee.com:renlm/config-server.git
	$ docker run -it --rm --name graalvm-ce -p 7001:7001 -p 9001:9001 -v /root/.m2:/root/.m2 -v /root/native-image/config-server:/build ubuntu:22.04 bash
	bash-5.1# cd /build
	bash-5.1# source ./graalvm/install.sh
	
	静态编译
	bash-5.1# mvn clean -Pnative -P dev native:compile
	bash-5.1# ldd target/config-server
        not a dynamic executable
	
	测试覆盖
	bash-5.1# mvn clean package -P dev
	bash-5.1# java -agentlib:native-image-agent=config-output-dir=./output -jar target/config-server.jar
	
```	
将输出拷贝到resources/META-INF/native-image
新建native-image.properties，设置构建参数
自动加载
.
|-- META-INF
|   `-- native-image
|       |-- jni-config.json
|       |-- predefined-classes-config.json
|       |-- proxy-config.json
|       |-- reflect-config.json
|       |-- resource-config.json
|       `-- serialization-config.json
```

### Noraml Image
	$ cd /root/native-image/config-server
	$ docker build -t config-server:0.0.1 --build-arg PROFILES_ACTIVE=dev -f Dockerfile .
	$ docker run -it --name config-server --rm -p 7001:7001 -p 9001:9001 config-server:0.0.1
	
### Native Image
	$ cd /root/native-image/config-server
	$ docker build -t config-native-server:0.0.1 --build-arg PROFILES_ACTIVE=prod -f graalvm/Dockerfile .
	$ docker run -it --name config-native-server --rm -p 7002:7001 -p 9002:9001 config-native-server:0.0.1
	
### 手动推送镜像
	$ docker images
	$ docker login --username=renlm@21cn.com registry.cn-hangzhou.aliyuncs.com
	$ docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/rlm/config-native-server:0.0.1
	$ docker push registry.cn-hangzhou.aliyuncs.com/rlm/config-native-server:0.0.1
	
### keyStore.jks
	keypass 与 storepass 要相同
	Warning:  Different store and key passwords not supported for PKCS12 KeyStores.
	$ keytool -genkeypair -alias alias -keyalg RSA -validity 365 -dname "C=CN" -keypass letmein -keystore keyStore.jks -storepass letmein
	
### 获取配置
	$ curl http://default:123654@localhost:7001/master/rabbitmq-dev.yaml
	$ curl http://default:123654@localhost:7001/master/rabbitmq-prod.yaml
	
	$ curl -X POST http://default:123654@localhost:7001/encrypt -s -d {明文}
	$ curl -X POST http://default:123654@localhost:7001/decrypt -s -d {密文}
	
### 请求规则

```
/{application}/{profile}[/{label}]
/{application}-{profile}.yaml
/{label}/{application}-{profile}.yaml
/{application}-{profile}.properties
/{label}/{application}-{profile}.properties
```